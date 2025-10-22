#!/usr/bin/env ruby

require 'date'
require 'optparse'

year  = nil
month = nil
opt   = OptionParser.new
opt.on("-y VAL") do |v|
  year = v.to_i
end
opt.on('-m VAL') do |v|
  month = v.to_i
end
opt.parse!(ARGV)
year  = Date.today.year if year == nil
month = Date.today.month if month == nil

# ヘッダーの表示
puts "      #{" " if month < 10}#{month}月 #{year}"
puts "日 月 火 水 木 金 土"

i = Date.new(year, month, 1).cwday
i = 0 if i == 7                                # NOTE:日曜日の場合は横軸の位置をリセットする
print "#{"   " * i}"                           # NOTE: 右寄せのためのマージンをprint
(1..Date.new(year, month, -1).day).each do |d|
  print "#{" " if d < 10}#{d}"
  i +=1
  if i > 6
    puts ""
    i = 0
  else
    print " "
  end
end
puts ""
