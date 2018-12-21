input_text = File.read("./day10-1input.txt")
# input_text = File.read("./example.txt")
input_arr = input_text.split(/\n/)



def printGraph(coor_hash, size)

    min_x = min_y = 9999999
    max_x = max_y = 0

    coor_hash.keys.each do |coor|
        if (min_x > coor[0])
            min_x = coor[0]
        end
        if (min_y > coor[1])
            min_y = coor[1]
        end

        if (max_x < coor[0])
            max_x = coor[0]
        end
        if (max_y < coor[1])
            max_y = coor[1]
        end
    end

    puts "size of overall coordinate #{Math.sqrt((min_x-max_x)**2 + (min_y-max_y)**2)}"

    min = [min_x, min_y].min
    max = [max_x, max_y].max

    (min..max).each do |y|
        str = ""
        (min..max).each do |x|
            if !coor_hash[[x, y]].nil?
                str += "# "
            else
                str += ". "
            end
        end
        puts str
    end
end

coor_collection = []
coor_hash = {}
size = 0
input_arr.each do |coor|
    clean_coor = coor.scan(/\<[0-9,\-\s]{1,}\>/).map{ |value| value.gsub(/[\<\>]/,"").split(", ").map{|v| v.to_i} }
    coor_collection.push(clean_coor)
    coor_hash[clean_coor[0]] = 1
    if (clean_coor[0][0] > size)
        size = clean_coor[0][0]
    end
    if (clean_coor[0][1] > size)
        size = clean_coor[0][1]
    end
end

compact = 9999999
compact_coor_hash = {}

(0..100000000).each do |sec|
    x = Hash.new(0)
    y = Hash.new(0)
    coor_hash = {}
    coor_collection.each do |coor_velo|
        coor = coor_velo[0]
        velo = coor_velo[1]

        plus_coor = velo.map{|v| v*sec }
        new_coor = [coor[0] + plus_coor[0], coor[1] + plus_coor[1]]
        coor_hash[new_coor] = 1
        x[new_coor[0]] += 1
        y[new_coor[1]] += 1
    end

    min_x = min_y = 9999999
    max_x = max_y = 0

    coor_hash.keys.each do |coor|
        if (min_x > coor[0])
            min_x = coor[0]
        end
        if (min_y > coor[1])
            min_y = coor[1]
        end

        if (max_x < coor[0])
            max_x = coor[0]
        end
        if (max_y < coor[1])
            max_y = coor[1]
        end
    end

    new_compact = Math.sqrt((min_x-max_x)**2 + (min_y-max_y)**2)

    # printGraph(coor_hash, size, min_x, min_y, max_x, max_y)

    if (compact < new_compact)
        puts "at sec #{sec} compact value is #{new_compact}"
        puts "x :: #{x.to_s}"
        puts "y :: #{y.to_s}"
        printGraph(compact_coor_hash, size)
        break
    end

    compact_coor_hash = coor_hash
    compact = new_compact

end
# puts coor_collection.to_s
