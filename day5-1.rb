input_text = File.read("./day5-1input.txt")
input_arr = input_text.split("\n")

def sliceCut(str)
    arr = str.split("")
    newStr = ""
    arr.each_slice(2) do |a,b|
        if a.nil?
            newStr += b
            next
        elsif b.nil?
            newStr += a
            next
        end

        puts "Check #{a} #{b} "
        if (a == b.downcase && a.upcase == b) || (b == a.downcase && b.upcase == a)
            puts "Cut!!"
        else
            newStr += a + b
        end
    end
    return newStr
end

def reducePolarity(str)
    original = str
    res = original
    loop do
        res = sliceCut(original)
        # p "--- res1 == #{res} ---"
        res = res[0] + sliceCut(res[1..res.size-1])
        # p "--- res2 == #{res} ---"
        break if res == original
        original = res
    end
    return res
end

input_arr.each do |line|
    result = reducePolarity(line)

    puts result
end
