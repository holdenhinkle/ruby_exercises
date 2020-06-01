def toggle_lights(num_lights)
  lights = init_lights(num_lights)
  light_num = 1
  pass = 1
  num_lights.times do
    loop do
      lights[light_num] = toggle_light(lights[light_num])
      light_num = light_num + pass
      break if light_num > lights.size
    end
    pass += 1
    light_num = pass
  end
  on_lights(lights)
end

def init_lights(num_lights)
  hsh = {}
  1.upto(num_lights) { |light_num| hsh[light_num] = 'off' }
  hsh
end

def toggle_light(light)
  light == 'on' ? light = 'off' : light = 'on'
end

def on_lights(lights)
 lights.keys.select { |light| lights[light] == 'on' }
end

def display_light_status(lights, pass)
  if lights.values.all? { |status| status == 'on' }
    puts "Round #{pass}: Every light is on."
  elsif lights.values.all? { |status| status == 'off' }
    puts "Round #{pass}: Every light is off."
  else
    off_lights = lights.keys.select { |light| lights[light] == 'off' }
    on_lights = lights.keys.select { |light| lights[light] == 'on' }
    puts "Round #{pass}: #{off_lights} are now off; #{on_lights} are now on."
  end 
end

p toggle_lights(5)