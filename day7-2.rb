input_text = File.read("./day7-1input.txt")
# input_text = File.read("./example.txt")
input_arr = input_text.split("\n")

def findNext(start, direction_to, dependencies, available_des, achieve_list)
    destination_list = direction_to[start]
    candidate_des = []
    (destination_list + available_des - achieve_list).uniq.each do |des|
        depd = dependencies[des]
        if (depd - achieve_list).size == 0
            candidate_des.push(des)
        else
            available_des = (available_des.push(des)).uniq
        end
    end
    arrive = (candidate_des.sort)[0]
    achieve_list.push(arrive)
    available_des += (candidate_des.sort)[1..-1]
    return [achieve_list, available_des]
end

direction_to = Hash.new([])
dependencies = Hash.new([])

input_arr.each do |line|
    token = line.split(/\s/)
    direction_to[token[1]] = direction_to[token[1]].nil? ? [token[7]] : direction_to[token[1]] + [token[7]]
    dependencies[token[7]] = dependencies[token[7]].nil? ? [token[1]] : dependencies[token[7]] + [token[1]]
end

dictionary = ["-"] + ("A".."Z").to_a

all_location = (direction_to.keys + dependencies.keys).uniq
start_candidate = (direction_to.keys - dependencies.keys).sort

arrive = start = start_candidate[0]

worker_achieve_list = [[start], [start]]
worker_available_des = [start_candidate[1..-1],[]]
workers_wait = [dictionary.index(start), dictionary.index(start)] #[works1_waiting_time, woker2_waiting_time]

sec = 0

while (all_location - worker_achieve_list.flatten).size > 0 do

    sec += 1

    puts "====== AT #{sec} seconds ======\n\n"
    result_worker1 = nil
    result_worker2 = nil

    if (workers_wait[0] - sec > 0 && workers_wait[1] - sec > 0)
        puts "at #{sec} :: wait\n\n"
    end

    if (workers_wait[0] - sec <= 0 )
        available_des = worker_available_des[0]
        achieve_list = worker_achieve_list[0]
        puts "worker#1 available from #{achieve_list[-1]} "
        result_worker1 = findNext(achieve_list[-1], direction_to, dependencies, available_des, worker_achieve_list.uniq.flatten)
        worker_achieve_list[0] = result_worker1[0]
        puts "worker #1 available - go to #{result_worker1[0][-1]}"
        workers_wait[0] += dictionary.index(result_worker1[0][-1])
        # available_des = result[1] - achieve_list
        worker_available_des[0] = result_worker1[1] - achieve_list
        puts "update achieve list of worker#1 #{worker_achieve_list[0]}\n\n"
    end

    if (workers_wait[1] - sec <= 0 )
        available_des = worker_available_des[1]
        achieve_list = worker_achieve_list[1]
        puts "worker#2 available from #{achieve_list[-1]} "
        result_worker2 = findNext(achieve_list[-1], direction_to, dependencies, available_des, worker_achieve_list.uniq.flatten)
        worker_achieve_list[1] = result_worker2[0]
        puts "worker #2 available - go to #{result_worker2[0][-1]}"
        workers_wait[1] += dictionary.index(result_worker2[0][-1])
        # available_des = result[1] - achieve_list
        worker_available_des[1] = result_worker2[1] - achieve_list
        puts "update achieve list of worker#2 #{worker_achieve_list[1]}\n\n"

    end

end

puts "----#{workers_wait.join(",")}----\n\n"
