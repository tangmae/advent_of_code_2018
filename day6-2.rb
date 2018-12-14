input_text = File.read("./day6-1input.txt")
# input_text = File.read("./example.txt")
input_arr = input_text.split("\n")

def totalDistFromCoordinate (x, y, graphCoor)
    pointCoor = graphCoor.keys
    totalDist = pointCoor.inject(0) do |totalDist, coor|
        totalDist += mahattanDistance(x, y, coor[0], coor[1])
    end
    return totalDist
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

countArea = 0

(0..graphSize).each do |y|
    (0..graphSize).each do |x|
        if totalDistFromCoordinate(x, y, graphCoor) < 10000
            countArea += 1
        end
    end
end

puts "SafestArea :: #{countArea}"
