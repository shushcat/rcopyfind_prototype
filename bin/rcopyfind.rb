#!/usr/bin/env ruby

require "rcopyfind"

if ARGV.empty? then
  print_usage
  exit
end

t, s, w, msw, mwl, ord, stem, stop = parse_options
comparator = Comparator.new(t, s, min_shared_words: msw, ordered: ord,
                            window: w, min_word_length: mwl,
                            stemming: stem, stopwords: stop)
print_report(comparator)
