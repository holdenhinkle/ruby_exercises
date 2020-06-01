require 'pry'

MINUTES_PER_HOUR = 60
HOURS_PER_DAY = 24

def after_midnight(time)
  hours, minutes = convert_to_hours_and_minutes(time)
  hours < HOURS_PER_DAY ? hours * MINUTES_PER_HOUR + minutes : minutes
end

def before_midnight(time)
  hours, minutes = convert_to_hours_and_minutes(time)
  total_mins = 0
  total_mins += (hours - 1) * MINUTES_PER_HOUR if hours > 0 && hours < HOURS_PER_DAY
  total_mins += MINUTES_PER_HOUR - minutes if minutes > 0
  total_mins
end

def convert_to_hours_and_minutes(time)
  time.split(':').map(&:to_i)
end

p after_midnight('00:00') == 0
p before_midnight('00:00') == 0
p after_midnight('12:34') == 754
p before_midnight('12:34') == 686
p after_midnight('24:00') == 0
p before_midnight('24:00') == 0