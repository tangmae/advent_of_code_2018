input_text = File.read("./day14-1input.txt")
# input_text = File.read("./example.txt")
input_arr = input_text.gsub(/\n/,"").split("").map(&:to_i)

turn = 0
improve_turn = 793031

elf_1_index = 0
elf_2_index = 1

recipies = input_arr

puts "reciepies #{recipies.to_s}"


def adjust_index(index, recipies)
    return index%recipies.size
end

def print_recipie(elf_1_index, elf_2_index, recipies)
    str = ""

    recipies.each_with_index do |rep, index|

        if index == elf_1_index
            str += "(#{rep})  "
        elsif index == elf_2_index
            str += "[#{rep}]  "
        else
            str += "#{rep}  "
        end

    end
    puts str
end

(1..improve_turn+10).each do |turn|

    elf_1 = recipies[elf_1_index]
    elf_2 = recipies[elf_2_index]

    # print_recipie(elf_1_index, elf_2_index, recipies)
    # puts "elf_1 choose #{adjust_index(elf_1_index, recipies)} :: #{elf_1} elf_2 choose #{adjust_index(elf_2_index, recipies)}::#{elf_2}\n\n\n"

    new_rep = elf_1 + elf_2

    split_new_rep = new_rep.to_s.split("").map(&:to_i)

    recipies += split_new_rep

    # puts "elf_1_index #{elf_1_index + elf_1 + 1} => #{adjust_index(elf_1_index + elf_1 + 1, recipies)}"
    # puts "elf_2_index #{elf_2_index + elf_2 + 1} => #{adjust_index(elf_2_index + elf_2 + 1, recipies)}\n\n\n\n\n"

    elf_1_index = adjust_index(elf_1_index + elf_1 + 1, recipies)
    elf_2_index = adjust_index(elf_2_index + elf_2 + 1, recipies)

    if recipies[-6..-1].map(&:to_s).join("") == 793031
        puts "the reciepies improve after #{recipies.size-6} reciepies"
        break
    end
end


# print_recipie(elf_1_index, elf_2_index, recipies)
puts recipies[improve_turn..improve_turn+9].join("")
