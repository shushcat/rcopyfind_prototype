#!/usr/bin/env ruby

require "bundler/setup"
require "rcopyfind"

def reload
  load "lib/rcopyfind.rb"
  return "Reloaded RCopyfind."
end

def load_sonnets
  $son1 = Text.new('./test/sonnets/Sonnet I.txt')
  $son2 = Text.new('./test/sonnets/Sonnet II.txt')
  $son3 = Text.new('./test/sonnets/Sonnet III.txt')
  $son4 = Text.new('./test/sonnets/Sonnet IV.txt')
  $son5 = Text.new('./test/sonnets/Sonnet V.txt')
  $son6 = Text.new('./test/sonnets/Sonnet VI.txt')
end

def test_reports
  load_sonnets
  msw = 3
  ord = true
  (1..6).each do |i|
    (i+1..6).each do |j|
      $target = eval("$son#{i}")
      $source = eval("$son#{j}")
      com = eval("Comparator.new($son#{i}, $son#{j}," +
           "min_shared_words: msw, ordered: ord)")
      print_report(com)
    end
  end
end

def c25
  load_sonnets
  msw = 3
  ord = true
  $c25 = Comparator.new($son2, $son5, min_shared_words: msw, ordered: ord)
  print_report($c25)
end

def north_rich3
  $rich3 = Text
        .new("../../lib/shakespeare/plays/richard3.txt")

  $north = Text
      .new("../../lib/brief_discourse-george_north.md")

  $comp = Comparator.new($rich3, $north, window: 25, min_shared_words: 3, min_word_length: 6)
  print_report($comp)
end

require "irb"
require "irb/completion"
IRB.start(__FILE__)
