#!/usr/bin/env ruby
# frozen_string_literal: true

def main
  path = '.'
  path = ARGV[0] unless ARGV[0].nil?

  unless File.exist?(path)
    puts "ls: #{path}: No such file or directory"
    return 1
  end

  objects = list_objects(path)
  output_objects(objects)
  0
end

def list_objects(path)
  objects = []
  if File.file?(path)
    objects.push(path)
  else
    Dir.open(path).sort.each do |object|
      next if object[0] == '.'

      objects.push(object)
    end
  end
  objects
end

MAX_COLUMN = 3 # NOTE: 1行中に表示出来る(ファイル名|ディレクトリ名)の数の最大
TAB_WIDTH  = 8 # NOTE: タブ幅

def output_objects(objects)
  return if objects.empty?

  max_name_length = objects.max_by(&:size).size                   # NOTE: 最も長い(ファイル名|ディレクトリ名)の文字数
  max_width       = (max_name_length / TAB_WIDTH + 1) * TAB_WIDTH # NOTE: max_name_lengthより大きくて最も近いTAB_WIDTHの倍数を最大幅とする
  max_row         = (objects.size / MAX_COLUMN.to_f).ceil         # NOTE: 結果を表示するのに必要な行数

  (0..(max_row - 1)).each do |i|
    i.step(objects.size - 1, max_row) do |j|
      tab_count = (max_width - 1 - objects[j].size) / TAB_WIDTH + 1 # NOTE: max_widthまで文字を埋めるのにいくつタブが必要か計算する
      print "#{objects[j]}#{"\t" * tab_count}"
    end
    puts "\n"
  end
end

exit main
