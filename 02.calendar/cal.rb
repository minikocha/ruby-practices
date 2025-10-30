#!/usr/bin/env ruby
require 'date'
require 'optparse'

year  = Date.today.year
month = Date.today.month

opt = OptionParser.new
opt.on("-y year",  Integer) { |v| year  = v }
opt.on("-m month", Integer) { |v| month = v }
opt.parse!(ARGV)

first_day = Date.new(year, month, 1)
last_day  = Date.new(year, month, -1)

dates = Array.new(5) { Array.new(7, "  ") }
i = 0
j = first_day.wday
(first_day..last_day).each do |date|
  dates[i][j] = date.day.to_s.rjust(2)
  
  if date.saturday?
    i += 1
    j = 0
  else
    j += 1
  end
end

# ヘッダーの表示
puts "      #{month.to_s.rjust(2)}月 #{year}"
puts "日 月 火 水 木 金 土"

# 日付の表示
dates.each { |week| puts week.join(" ") }
puts
