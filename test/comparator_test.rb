require './lib/rcopyfind.rb'
require './test/assert.rb'

def init_comparator
  son2 = Text.new('./test/sonnets/Sonnet II.txt')
  son5 = Text.new('./test/sonnets/Sonnet V.txt')
  comp = Comparator.new(son2, son5)
  return comp, son2, son5
end

def comparator_tests
  comp, son2, son5 = init_comparator
  assert("load #{son2.filename} as Text") { son2.class == Text }
  assert("load #{son5.filename} as Text") { son5.class == Text }
  assert("initialize comparator") { comp.class == Comparator }
  assert("set @target_word_clusters") do
    comp.target_word_clusters.class == Array
  end
  assert("set @source_word_clusters") do
    comp.source_word_clusters.class == Array end
  assert("ensure @target.word_clusters contains Hashes") do
    comp.target_word_clusters[0].class == Hash
  end
  assert("ensure @source.word_clusters contains Hashes") do
    comp.source_word_clusters[0].class == Hash
  end
  assert("check similar_clusters.class is Array") do
    comp.similar_clusters.class == Array
  end
  assert("check similar_clusters[0].class is Array") do
    comp.similar_clusters[0].class == Array
  end
  assert("check similar_clusters[0][0].class is Hash") do
    comp.similar_clusters[0][0].class == Hash
  end
  assert("avoid erroneous $son2--$son5 match") do
    comp.similar_clusters[0] != [{"beauty"=>38, "then"=>32, "where"=>40},
                                 {"beauty"=>53, "lusty"=>49, "where"=>58}]
  end
end

puts "\n"
puts "Comparator Tests:"
puts "--------------------------------"
comparator_tests
