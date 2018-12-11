input_text = File.read("./day1-1input.txt")
input_arr = input_text.split("\n").map(&:to_i)

frequencies = [0]

def changefq (inputArr, frequencies)
    inputArr.each do |value|
        sum = frequencies[-1] + value
        if frequencies.include? sum
            puts "twice!! #{sum}"
            return
        else
            frequencies.push(sum)
        end
    end
    puts frequencies.sort.to_s
    changefq(inputArr, frequencies)
end

changefq(input_arr,frequencies)
