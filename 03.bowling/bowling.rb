#!/usr/bin/env ruby
# frozen_string_literal: true

results  = ARGV[0].split(',').map { |result| result == 'X' ? 10 : result.to_i }
score    = 0
position = 0
10.times do
  first_point, second_point, third_point = results[position, 3]
  if first_point == 10
    score += (first_point + second_point + third_point)
    position += 1
  elsif first_point + second_point == 10
    score += (first_point + second_point + third_point)
    position += 2
  else
    score += (first_point + second_point)
    position += 2
  end
end

puts score
