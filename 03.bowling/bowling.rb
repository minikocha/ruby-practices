#!/usr/bin/env ruby
# frozen_string_literal: true

# NOTE: 引数として渡された文字列（結果）を数値の配列に変換する。
def convert_to_numbers(arg)
  results = []
  arg.split(',').each do |result|
    if result == 'X'
      results.append(10)
    else
      results.append(result.to_i)
    end
  end
  results
end

# NOTE: 1フレーム毎のポイントを計算し、結果と次回以降の読み込み開始の位置を返却する。
def calculate_point(results, position)
  first  = results[position]
  second = results[position + 1]
  third  = results[position + 2]

  return [(first + second + third), (position + 1)] if first == 10

  point = first + second
  point += third if point == 10
  [point, (position + 2)]
end

results  = convert_to_numbers(ARGV[0])
score    = 0
position = 0
10.times do
  point, position = calculate_point(results, position)
  score += point
end

puts score
