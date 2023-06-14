function set_compare_arr(a1, a2)
  Set(a1) == Set(a2) && length(a1) == length(Set(a1)) && length(a2) == length(Set(a2))
end

function arr_contained_in_vec(a1, vec)
  for v in vec
    if set_compare_arr(a1, v)
      return true
    end
  end

  return false
end

function contains_any(a1, a2)
  for a in a1
    if a in a2
      return true
    end
  end

  return false
end

function combinations_in_cage(cage_sum::UInt, cage_parity::UInt, existing_entries::Array{UInt}=Vector{UInt}())
  if cage_parity == 1
    return [[cage_sum]]
  else
    breakloop::Bool = false
    it::UInt = 1
    pieces = Vector{UInt}[]

    while !breakloop
      # println(it)
      if cage_parity == 2
        # print(sum)
        # print("---")
        # println("HELLO")
        a_it::UInt = cage_sum - it
        if (it == a_it || arr_contained_in_vec([it, a_it], pieces))
          breakloop = true
        elseif it in existing_entries || a_it in existing_entries
          it += 1
          continue
        else
          push!(pieces, [it, a_it])
          # vcat(pieces, [it, a_it])
          it += 1
        end

      else
        # println("HELLO2")
        # print(sum - it)
        # print(" --- ")
        # println(n-1)
        a_its = combinations_in_cage(cage_sum - it, cage_parity - 1)
        # println("Received a_its")
        # println(a_its)

        temp_pieces = Vector{UInt}[]
        for a_it in a_its
          # print(it)
          # println(a_it)
          if !(it in a_it || arr_contained_in_vec([it, a_it...], pieces) || it in existing_entries || contains_any(a_it, existing_entries))
            push!(temp_pieces, [it, a_it...])
          else
            # return(pieces)
            continue
          end
        end

        if length(temp_pieces) == 0
          break
        else
          append!(pieces, temp_pieces)
        end

        it += 1

        if (it > 100)
          # print("done!")
          breakloop = true
        end

        # it += 1
        # if (it in a_its || )

      end

    end  

    return(pieces)
  end
end

# println(combinations_in_cage(convert(UInt8, 10), convert(UInt8, 1)))

using Test
@testset "Trivial 1-digit cages" begin
  for n in 1:9
    @test combinations_in_cage(convert(UInt, n), convert(UInt, 1)) == [[n]]
  end
end
@testset "Cage with sum 45 contains all digits 1:9" begin
  @test combinations_in_cage(convert(UInt, 45), convert(UInt, 9)) == [[1, 2, 3, 4, 5, 6, 7, 8, 9]]
end
@testset "Cage with only 1 possible combination" begin
  @test combinations_in_cage(convert(UInt, 7), convert(UInt, 3)) == [[1, 2, 4]]
end
@testset "Cage with several combinations" begin
  @test combinations_in_cage(convert(UInt, 10), convert(UInt, 2)) == [[1, 9], [2, 8], [3, 7], [4, 6]]
end
@testset "Cage with several combinations that is restricted" begin
  @test combinations_in_cage(convert(UInt, 10), convert(UInt, 2), [convert(UInt, 1), convert(UInt, 4)]) == [[2, 8], [3, 7]]
end
