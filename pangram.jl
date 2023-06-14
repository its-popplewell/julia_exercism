"""
    ispangram(input)

Return `true` if `input` contains every alphabetic character (case insensitive).

"""
function ispangram(input)
  s_inp = Set(split(lowercase(input), ""))
  s_inp = collect(s_inp)
  s_inp_filt = ""
  for el_ind in eachindex(s_inp)
    # println(s_inp[el_ind])
    # if s_inp[el_ind] in "abcdefghijklmnopqrstuvwxyz"
    if occursin(s_inp[el_ind], "abcdefghijklmnopqrstuvwxyz")
      # println("Success!: $(s_inp[el_ind])")
      s_inp_filt = s_inp_filt * s_inp[el_ind]
    end
  end

  # println(s_inp_filt)

  return length(s_inp_filt) >= 26

end


ispangram("the quick brown fox jumped_over_the_fat_peter_")
