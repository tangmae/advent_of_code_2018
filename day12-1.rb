input_text = File.read("./day12-1input.txt")
# input_text = File.read("./example.txt")
input_arr = input_text.split(/\n/)

def is_change(this_gen, next_gen)

    if this_gen.select{ |k,v| v=="#"}.keys.sort == next_gen.select{ |k,v| v=="#"}.keys.sort
        return false
    end
    return true

end

initial = input_arr[0].gsub("initial state: ","")

fertilize = {}

(1..input_arr.size-1).each do |line_no|

    line = input_arr[line_no]

    next if line[/=>/].nil?

    rules = line.split(" => ")
    fertilize[rules[0]] = rules[1]

end

# puts fertilize.to_s
# puts "##{0}\t::\t#{initial}"

num_of_pot = initial.size

this_generation = Hash.new(".")

initial.split("").each_with_index do |plant, index|
    this_generation[index.to_s] = plant
end

num_of_plant = 0
(1..199).each do |gen_num|

    next_generation = Hash.new()
    first_plant_index = this_generation.select{ |k,v| v=="#"}.keys.map(&:to_i).min
    last_plant_pot = this_generation.select{ |k,v| v=="#"}.keys.map(&:to_i).max
    pot_start = false

    # puts "first_plant_index #{first_plant_index} last_plant_pot #{last_plant_pot}"
    (first_plant_index-2..last_plant_pot+3).each do |index|

        consider_plants = ""

        [-2,-1,0,1,2].each do |shift|
            get_plant_index = index + shift
            if this_generation[get_plant_index.to_s].nil?
                consider_plants += "."
            else
                consider_plants += this_generation[get_plant_index.to_s]
            end
        end

        # puts "at index #{index} :: #{consider_plants} => #{fertilize[consider_plants].nil? ? "." : fertilize[consider_plants]}"

        if (fertilize[consider_plants].nil? || fertilize[consider_plants] == ".") #&& pot_start
            next_generation[index.to_s] = "."
        elsif !fertilize[consider_plants].nil?
            next_generation[index.to_s] = fertilize[consider_plants]
            pot_start = true
        end

    end

    # puts "##{gen_num} compare #{is_change(this_generation, next_generation)}"
    # puts "#{this_generation.select{ |k,v| v=="#"}.keys.sort}"
    # puts "#{next_generation.select{ |k,v| v=="#"}.keys.sort}\n\n"

    # break if !is_change(this_generation, next_generation)



    this_generation = next_generation
    puts "##{gen_num}\t::\t#{this_generation.values.join("")}"

end

# puts this_generation

puts this_generation.select{ |k,v| v=="#"}.keys.join(", ")
puts this_generation.select{ |k,v| v=="#"}.keys.size
puts this_generation.select{ |k,v| v=="#"}.keys.map(&:to_i).inject(&:+)
