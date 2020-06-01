DEGREE_SYM = "\xC2\xB0"

def dms(angle)
  degrees = angle.to_i
  minutes = calculate_minutes_or_seconds(angle)
  seconds = calculate_minutes_or_seconds(minutes)
  format(%(#{degrees}#{DEGREE_SYM}%02d'%02d"), minutes, seconds)
end

def calculate_minutes_or_seconds(num)
  ((num - num.to_i) * 60).round(2)
end

puts dms(30)
puts dms(76.73)
puts dms(254.6)
puts dms(93.034773)
puts dms(0)
puts dms(360)

p dms(30) == %(30°00'00")
p dms(76.73) == %(76°43'48")
p dms(254.6) == %(254°36'00")
p dms(93.034773) == %(93°02'05")
p dms(0) == %(0°00'00")
p dms(360) == %(360°00'00") || dms(360) == %(0°00'00")