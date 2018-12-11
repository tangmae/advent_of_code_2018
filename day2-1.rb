input_text = File.read("./day2-1input.txt")
input_arr = input_text.split("\n")

frequencies = [0]

twoTimeAppearance = 0
threeTimeAppearance = 0

input_arr.each do |box|
    twoOnce = false
    threeOnce = false

    boxKey = box.split("")
    originalBoxSize = boxKey.size

    boxKey.each do |key|

        puts "#{boxKey.join("")} - #{key} = #{(boxKey-[key]).join("")}"

        if originalBoxSize - (boxKey - [key]).size == 2 && !twoOnce
            twoTimeAppearance += 1
            twoOnce = true
        elsif originalBoxSize - (boxKey - [key]).size == 3 && !threeOnce
            threeTimeAppearance += 1
            threeOnce = true
        end

    end
end

puts "#{twoTimeAppearance} * #{threeTimeAppearance} = #{twoTimeAppearance * threeTimeAppearance}"
