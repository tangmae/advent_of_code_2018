input_text = File.read("./day2-1input.txt")
input_arr = input_text.split("\n").map {|a| a.split("")}


def matchByIndex(arr1, arr2) # if diff char is very low
    diffPosition = [0,[]]
    arr1.each_with_index do |value, index|
        if value != arr2[index]
            diffPosition[0] += 1
            diffPosition[1].push([value, arr2[index]])
        end
    end
    return diffPosition
end

minDiff = input_arr[0].size
minDiffPair = []
input_arr.each_with_index do |starter,index1|
    input_arr.each_with_index do |comparator,index2|
        next if index1 == index2
        diffCharNum = matchByIndex(starter, comparator)
        puts "#{diffCharNum[0]} #{minDiff.class}"
        if diffCharNum[0] < minDiff
            minDiffPair = []
            minDiff = diffCharNum[0]
            minDiffPair.push([starter.join(""), comparator.join("")])
        elsif diffCharNum[0] == minDiff
            minDiffPair.push([starter.join(""), comparator.join("")])
        end
    end
end

puts minDiffPair
