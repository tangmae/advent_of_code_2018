input_text = File.read("./day3-1input.txt")
input_arr = input_text.split("\n")


def addSqrt(x1, y1, wide, tall, existingSqrt, overlapSqrt)
    yRoll = ((y1+1)..(y1+tall)).to_a
    # puts "new Y #{yRoll}"
    (x1..(x1+wide-1)).each do |x|
        # compare to existing sqrt
        yxRoll = existingSqrt[x].nil? ? [] : existingSqrt[x]
        mergeYRoll = (yxRoll + yRoll).uniq
        existingSqrt[x] = mergeYRoll

        overlapRoll = yRoll & yxRoll
        # puts "overlap #{overlapRoll.to_s}"
        # compare to existing overlapSqrt
        exOverlapRoll = overlapSqrt[x].nil? ? [] : overlapSqrt[x]
        newOverlapArea = (exOverlapRoll + overlapRoll).uniq
        overlapSqrt[x] = newOverlapArea
    end
end

def countArea (arr2x)
    sum = 0
    arr2x.each do |arr|
        sum += arr.nil? ? 0 : arr.size()
    end
    return sum
end

def isThisOverlap(x1, y1, wide, tall, overlapSqrt)
    yRoll = ((y1+1)..(y1+tall)).to_a
    # puts "new Y #{yRoll}"
    (x1..(x1+wide-1)).each do |x|
        yxRoll = overlapSqrt[x].nil? ? [] : overlapSqrt[x]
        overlapRoll = yRoll & yxRoll
        if overlapRoll.size() > 0
            return true
        end
    end
    return false
end


existingSqrt = Array.new([]) # {x1 => [y1,y2]}
overlapSqrt = Array.new([]) # {x1 => [y1,y2]}

input_arr.each do |line|

    sqrtInfo = line.gsub(/[\@\:]/,"").split(/\s{1,}/)
    x1 = sqrtInfo[1].split(/[\,]/)[0].to_i
    y1 = sqrtInfo[1].split(/[\,]/)[1].to_i

    width = sqrtInfo[2].split(/[x]/)[0].to_i
    length = sqrtInfo[2].split(/[x]/)[1].to_i

    addSqrt(x1, y1, width, length, existingSqrt, overlapSqrt)

    puts "Complete sqrt #{line}\n\n"

end

puts "size of overlap part : #{countArea(overlapSqrt)}"

input_arr.each do |line|

    sqrtInfo = line.gsub(/[\@\:]/,"").split(/\s{1,}/)
    x1 = sqrtInfo[1].split(/[\,]/)[0].to_i
    y1 = sqrtInfo[1].split(/[\,]/)[1].to_i

    width = sqrtInfo[2].split(/[x]/)[0].to_i
    length = sqrtInfo[2].split(/[x]/)[1].to_i

    if !isThisOverlap(x1, y1, width, length, overlapSqrt)
        puts "#{sqrtInfo} == this sqrt doesn't overlap!!"
    end

end
