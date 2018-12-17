input_text = File.read("./day7-1input.txt")
# input_text = File.read("./example.txt")
input_arr = input_text.split("\n")

direction_to = Hash.new([])
dependencies = Hash.new([])


input_arr.each do |line|
    token = line.split(/\s/)
    direction_to[token[1]] = direction_to[token[1]].nil? ? [token[7]] : direction_to[token[1]] + [token[7]]
    dependencies[token[7]] = dependencies[token[7]].nil? ? [token[1]] : dependencies[token[7]] + [token[1]]
end

start_candidate = (direction_to.keys - dependencies.keys).sort
# puts "start candidate :: #{start_candidate}"
arrive = start = start_candidate[0]
achieve = []
final_string = start
available_des = start_candidate[1..-1] - [start]

while (direction_to.keys - achieve).size > 0 do
    achieve.push(arrive)
    destination_list = direction_to[arrive]
    candidate_des = []
    (destination_list + available_des - achieve).uniq.each do |des|
        depd = dependencies[des]
        # puts "TO GO #{des} REQUIRES #{(depd - achieve).to_s}"
        if (depd - achieve).size == 0
            candidate_des.push(des)
        else
            available_des = (available_des.push(des)).uniq
        end
    end
    if candidate_des.size == 0
        break
    end
    arrive = (candidate_des.sort)[0]
    final_string += arrive
    available_des = available_des + candidate_des - [arrive]
    # puts ">>>> #{final_string}"
end

puts "----#{final_string}----\n\n"
