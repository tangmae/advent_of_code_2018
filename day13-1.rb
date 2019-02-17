input_text = File.read("./day13-1input.txt")
# input_text = File.read("./example.txt")
input_arr = input_text.split(/\n/)


turn = straight = junction = Hash.new()
map = Hash.new(" ")
origin_map = Hash.new(" ")
cars = {}

def print_map(map)
    (0..150).each do |y|
        str = ""
        (0..200).each do |x|
            str += map[[x,y]]
        end
        puts str
    end
end

y = 0
car_count = 1
cars_current_position = Hash.new()

input_arr.each do |line|
    x = 0
    line.split("").each do |v|
        if v == "|" ||  v == "/" || v == "\\" || v == "+" || v == "-"
            turn[[x, y]] = v
            map[[x, y]] = v
            origin_map[[x, y]] = v
        # elsif v == "+"
        #     junction [[x, y]]  = 1
        elsif v == ">" || v == "v" || v == "<"  || v == "^"
            puts "car #{car_count} at #{x},#{y} with #{v}"
            cars[car_count.to_s] = {}
            cars[car_count.to_s]["position"] = [x,y]
            cars[car_count.to_s]["direction"] = v
            cars[car_count.to_s]["order"] = 0
            map[[x, y]] = v
            origin_map[[x, y]] = "|"
            cars_current_position[[x, y]] = car_count
            car_count += 1
        end
        x += 1
    end
    y += 1
end

turn_order = []
turn_order[0] = {}
turn_order[0][">"] = "^"
turn_order[0]["<"] = "v"
turn_order[0]["^"] = "<"
turn_order[0]["v"] = ">"

turn_order[1] = {}
turn_order[1][">"] = ">"
turn_order[1]["<"] = "<"
turn_order[1]["^"] = "^"
turn_order[1]["v"] = "v"

turn_order[2] = {}
turn_order[2][">"] = "v"
turn_order[2]["<"] = "^"
turn_order[2]["^"] = ">"
turn_order[2]["v"] = "<"

is_crashed = false
round = 0

while cars.size > 1
    round += 1
    # puts "ROUND #{round}"
    cars_latest_position = Hash.new()

    cars.each do |k,v|

        pos = v["position"]
        dir = v["direction"]
        order = v["order"]

        new_pos = pos
        new_dir = dir

        if dir == ">"
            new_pos = [pos[0] + 1 , pos[1]]
        elsif dir == "<"
            new_pos = [pos[0] - 1 , pos[1]]
        elsif dir == "^"
            new_pos = [pos[0] , pos[1] - 1]
        elsif dir == "v"
            new_pos = [pos[0] , pos[1] + 1]
        end

        if turn[new_pos] == "/" && dir == ">"
            new_dir = "^"
        elsif turn[new_pos] == "/" && dir == "<"
            new_dir = "v"
        elsif turn[new_pos] == "/" && dir == "^"
            new_dir = ">"
        elsif turn[new_pos] == "/" && dir == "v"
            new_dir = "<"
        elsif turn[new_pos] == "\\" && dir == ">"
            new_dir = "v"
        elsif turn[new_pos] == "\\" && dir == "<"
            new_dir = "^"
        elsif turn[new_pos] == "\\" && dir == "^"
            new_dir = "<"
        elsif turn[new_pos] == "\\" && dir == "v"
            new_dir = ">"
        end


        if turn[new_pos] == "+"
            new_dir = turn_order[order] == "|" ? dir : turn_order[order][dir]
            order = (1 + order)%3
        end

        # puts "cars #{k} :: go to #{new_pos.to_s} with direction #{new_dir.to_s} on #{turn[new_pos]}"

        # map[pos] = (k.to_i%10).to_s
        map[pos] = origin_map[pos]
        map[new_pos] = "\e[1m\e[32m#{new_dir}\e[0m\e[22m"

        v["position"] = new_pos
        v["direction"] = new_dir
        v["order"] = order


        if (cars_latest_position[new_pos] != nil)
            puts "ROUND #{round} - CAR ##{k} MOVE AND #{new_pos.to_s} CLASH WITH CAR ##{cars_latest_position[new_pos]}"

            cars_current_position.each { |k,v| puts "CAR #{v} - #{k}" }

            cars.delete(k.to_s)
            cars.delete(cars_latest_position[new_pos].to_s)

            cars_latest_position.delete_if{|k,v| k == new_pos}

            puts "cars left #{cars.keys}"

            puts "-------------------------------"

        else
            cars_latest_position[new_pos] = k.to_i
        end


        # puts "#{cars_current_position.to_s} AND #{new_pos}"

        if ((cars_current_position.keys & [new_pos]).size > 0)
            puts "ROUND #{round} - CAR ##{k} MOVE AND #{new_pos.to_s} CLASH WITH CAR ##{cars_current_position[new_pos]}"

            cars_current_position.each { |k,v| puts "CAR #{v} - #{k}" }

            is_crashed = true
            # print_map(map)
            cars.delete(k.to_s)
            cars.delete(cars_current_position[new_pos].to_s)

            puts "cars left #{cars.keys}"

            cars_latest_position.delete_if{|k,v| k == new_pos }
            cars_latest_position.delete_if{|_,v| v == cars_current_position[new_pos]}

            cars_current_position.delete_if{|k,v| k == new_pos }
            cars_current_position.delete_if{|_,v| v == k }

            puts "-------------------------------"

        end

    end


    cars_current_position = cars_latest_position


    # if (round == 298 || round == 478 || round == 868 || round == 2223)
    #     print_map(map)
    # end

end


cars_current_position.each { |k,v| puts "CAR #{v} - #{k}" }
