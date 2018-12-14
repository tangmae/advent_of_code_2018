# input_text = File.read("./day6-1input.txt")
input_text = File.read("./example.txt")
input_arr = input_text.split("\n")


def closestCoordinate (x, y, graphCoor)
    pointCoor = graphCoor.keys
    min = 999
    minPoint = []
    pointCoor.each do |coor|
        dist = mahattanDistance(x, y, coor[0], coor[1])
        if dist == 0
            return [graphCoor[coor].downcase]
        elsif dist < min
            min = dist
            minPoint = [graphCoor[coor]]
        elsif dist == min
            minPoint.push(graphCoor[coor])
        end
    end
    return minPoint
end

def mahattanDistance(x1, y1, x2, y2)
    return (x1-x2).abs + (y1-y2).abs
end

graphCoor = Hash.new(0)

graphSize = 0

input_arr.each_with_index do |point, index|
    xy = point.split(", ")
    x = xy[0].to_i
    y = xy[1].to_i
    if x > graphSize
        graphSize = x
    end
    if y > graphSize
        graphSize = y
    end
    # puts "(#{x}, #{y})"
    graphCoor[[x,y]] = "##{index}"
    # puts "#{graphCoor.to_s}"
end

countArea = Hash.new(0)
infiniteArea = []

(0..graphSize).each do |y|
    str = ""
    (0..graphSize).each do |x|
        closetCoor = closestCoordinate(x, y, graphCoor)
        # puts "#{x}, #{y} #{closetCoor.to_s}"
        if closetCoor.size > 1
            str += "   "
        elsif closetCoor.size == 1
            if x == 0 || y == 0 || x == graphSize || y == graphSize
                infiniteArea.push(closetCoor[0])
            end
            countArea[closetCoor[0]] += 1
            str += "#{closetCoor[0]} "
        end
    end
    puts str
end

infiniteArea.each { |a| countArea.delete(a) }

puts "\n#{countArea.values.max}"
