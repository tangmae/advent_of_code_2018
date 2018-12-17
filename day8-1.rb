input_text = File.read("./day8-1input.txt")
# input_text = File.read("./example.txt")
input_arr = input_text.split(" ").collect(&:to_i)

puts input_arr.to_s

def end_of_branch(count_header, start_index, arr, sum_meta)

    if start_index == arr.size-1
        return []
    end

    meta_index = start_index+1

    child_num = arr[start_index]
    meta_num = arr[meta_index]

    puts "##{count_header} BRANCH HAS #{child_num} CHILDREN AND #{meta_num} METADATA"

    if child_num == 0
        last_index = start_index+1+meta_num
        index_meta = 0
        meta_str = ""
        puts "BRANCH #{count_header} END "
        while index_meta < meta_num
             sum_meta += arr[start_index+2+index_meta]
             meta_str += "#{arr[start_index+2+index_meta]}, "
             index_meta += 1
        end
        # puts "RESULT #{sum_meta}, #{last_index}"
        puts "META OF ##{count_header} #{meta_str}"
        return [sum_meta, last_index] #should return sum_meta and last index of its metadata
    else
        child_start_index = start_index+2
        (0..child_num).each do |child|
            next if child == 0
            # puts "CHECK ##{count_header+child} CHILD"
            result = end_of_branch(count_header+child, child_start_index, arr, sum_meta)
            puts "BRANCH #{count_header+child} START FROM #{child_start_index} END AT #{result[1]}"
            sum_meta = result[0]
            child_start_index = result[1] + 1
        end
        branch_meta_index = child_start_index
        index_meta = 0
        meta_str = ""
        puts "BRANCH #{count_header} END GET META FROM #{branch_meta_index}"
        while index_meta < meta_num
            puts "GET META AT #{branch_meta_index+index_meta}"
            sum_meta += arr[branch_meta_index+index_meta]
            meta_str += "#{arr[branch_meta_index+index_meta]}, "
            index_meta += 1
        end
        puts "META OF ##{count_header} #{meta_str}"
        return [sum_meta, branch_meta_index+meta_num-1]
    end

end

index = 0
result = end_of_branch(1, 0, input_arr, 0)

puts "FINAL RESULT #{result.to_s}"
