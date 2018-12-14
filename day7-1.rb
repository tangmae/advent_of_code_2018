input_text = File.read("./day7-1input.txt")
# input_text = File.read("./example.txt")
input_arr = input_text.split("\n")

directionTo = Hash.new([])
dependencies = Hash.new([])


input_arr.each do |line|
    token = line.split(/\s/)
    directionTo[token[1]] = directionTo[token[1]].nil? ? [token[7]] : directionTo[token[1]] + [token[7]]
    dependencies[token[7]] = dependencies[token[7]].nil? ? [token[1]] : dependencies[token[7]] + [token[1]]
end

startCandidate = (directionTo.keys - dependencies.keys).sort
# puts "start candidate :: #{startCandidate}"

startCandidate.each do |start|

    arrive = start
    achieve = []
    waitingDes = []
    finalString = start
    availableDes = startCandidate - [start]
    # puts "Let's start from #{start}"

    while (directionTo.keys - achieve).size > 0 do
        achieve.push(arrive)
        destinationList = directionTo[arrive]
        # puts "#{arrive} can go #{destinationList.to_s}"
        candidateDes = []
        (destinationList + waitingDes + availableDes - achieve).uniq.each do |des|
            depd = dependencies[des]
            # puts "going to #{des} needs #{depd.to_s} and we've achieved #{achieve.to_s}"
            if (depd - achieve).size == 0
                candidateDes.push(des)
            else
                waitingDes = (waitingDes.push(des)).uniq
            end
        end
        if candidateDes.size == 0
            # puts "start from here doesn't work"
            break
        end
        arrive = (candidateDes.sort)[0]
        finalString += arrive
        waitingDes = waitingDes + candidateDes - [arrive]
        # puts "#{str} #{arrive}"
    end

    puts "----#{finalString}----\n\n"
end
