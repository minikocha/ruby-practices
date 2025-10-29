#!/usr/bin/env ruby
# frozen_string_literal: true

# NOTE: 文字列として渡されたピンの数を数字に変換する。
def convert_to_number(pins)
  return 10 if pins == 'X'

  pins.to_i
end

# NOTE: 1フレーム毎のポイントを計算し、結果と次回以降の読み込み開始の位置を返却する。
def calculate_point(results, position)
  first  = convert_to_number(results[position])
  second = convert_to_number(results[position + 1])
  third  = convert_to_number(results[position + 2])

  return [(first + second + third), (position + 1)] if first == 10

  point = first + second
  point += third if point == 10
  [point, (position + 2)]
end

results  = ARGV[0].split(',')
score    = 0
position = 0
10.times do
  point, position = calculate_point(results, position)
  score += point
end

puts score
