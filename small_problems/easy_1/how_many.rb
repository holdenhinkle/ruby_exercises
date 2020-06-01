require 'pry'

vehicles = ['car', 'car', 'truck', 'car', 'SUV', 'truck', 'motorcycle', 'motorcycle', 'car', 'truck']

def count_occurrences(vehicles)
  vehicle_types = {}
  vehicles.uniq.sort.each { |vehicle| vehicle_types[vehicle] = vehicles.count(vehicle) }
  vehicle_types.each { |vehicle_type, quanity| puts "#{vehicle_type} => #{quanity}"}
end

count_occurrences(vehicles)