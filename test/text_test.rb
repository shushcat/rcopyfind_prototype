require './lib/rcopyfind.rb'
require './test/assert.rb'

def load_sonnets
  son1 = Text.new('./test/sonnets/Sonnet I.txt')
  son2 = Text.new('./test/sonnets/Sonnet II.txt')
  son3 = Text.new('./test/sonnets/Sonnet III.txt')
  son4 = Text.new('./test/sonnets/Sonnet IV.txt')
  son5 = Text.new('./test/sonnets/Sonnet V.txt')
  son6 = Text.new('./test/sonnets/Sonnet VI.txt')
  return son1, son2, son3, son4, son5, son6
end

def text_tests
  sonnets = load_sonnets
  sonnets.each.with_index do |sonnet, i|
    assert("load #{sonnet.filename} as Text") { sonnet.class == Text }
    assert("initialize son#{i+1}.word_array") do
      sonnet.word_array.class == Array
    end
    assert("initialize son#{i+1}.word_hash") do
      sonnet.word_hash.class == Hash
    end
  end
end


puts "\n"
puts "Text Tests:"
puts "--------------------------------"
text_tests
