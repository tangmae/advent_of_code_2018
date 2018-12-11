input_text = File.read("./day4-1input.txt")
input_arr = input_text.split("\n")

def countTimeMin (startHH, startMM, endHH, endMM)
    sleepMin = []
    minuteArr = (0..60).to_a
    if startHH != endHH
        while startHH != endHH do
            sleepMin.push(minuteArr.select {|min| min >= startMM})
            sleepMin.push(minuteArr.select {|min| min < endMM})
            startHH = (startHH + 1)%24
        end
    else
        sleepMin.push(minuteArr.select {|min| min >= startMM && min < endMM})
    end
    return sleepMin
end

records = {}

input_arr.each do |line|

    time = line[/\[.*\]/]
    action = line.gsub(time, "")
    records[time] = action
    # guardNo = line[/#[0-9]{1,}/]
end

allGuardRec = Hash.new() # { guardNo => [sleep#1, sleep#2] }
guardNo = nil
sleepDate = nil
sleepHH = nil
sleepMM = nil
wakeDate = nil
wakeHH = nil
wakeMM = nil
records.sort.each do |key, value|

    if !value[/#[0-9]{1,}/].nil?
        guardNo = value[/#[0-9]{1,}/]
    end

    date = key[/\d{4}\-\d{2}\-\d{2}/].gsub("-","").to_i
    time = key[/\d{2}:\d{2}/]
    hh = time.split(":")[0].to_i
    mm = time.split(":")[1].to_i

    if value["asleep"]
        sleepDate = date
        sleepHH = hh
        sleepMM = mm
        # puts "guard #{guardNo} fall asleep"
    elsif value["wake"]
        wakeDate = date
        wakeHH = hh
        wakeMM = mm
        if allGuardRec[guardNo].nil?
            allGuardRec[guardNo] = []
        end
        # puts "Guard #{guardNo} sleep from #{sleepDate} #{sleepHH}:#{sleepMM} to #{wakeDate} #{wakeHH}:#{wakeMM}"
        allGuardRec[guardNo].push([[sleepDate, sleepHH, sleepMM],[wakeDate, wakeHH, wakeMM]])
    end
end

allGuardRec.each do |guadNo, sleepSlot|
    # puts "Analyze #{guadNo}"
    duringMid = Hash.new(0)
    sleepTotal = 0

    sleepSlot.each do |sleep|
        # puts "==> #{sleep}"
        # count minutes that guard sleep
        sleepMin = countTimeMin(sleep[0][1], sleep[0][2], sleep[1][1], sleep[1][2])
        if sleep[0][1] == 0 && sleep[1][1] != 0
            sleepMin[0].each { |min| duringMid[min.to_s] += 1 }
            sleepTotal += sleepMin.flatten.size()
        elsif sleep[0][1] != 0 && sleep[1][1] == 0
            sleepMin[1].each { |min| duringMid[min.to_s] += 1 }
            sleepTotal += sleepMin.flatten.size()
        elsif sleep[0][1] == 0 && sleep[1][1] == 0
            sleepMin[0].each { |min| duringMid[min.to_s] += 1 }
            sleepTotal += sleepMin.flatten.size()
        else
            sleepTotal += sleepMin.flatten.size()
        end
        # puts "guard #{guadNo} sleep HH #{sleep[0][1]} - #{sleep[1][1]} : #{sleepMin.to_s}"
    end
    puts "guard #{guadNo} : #{duringMid.max_by{|k,v| v}}"
    puts "guard #{guadNo} total #{sleepTotal}"

end
