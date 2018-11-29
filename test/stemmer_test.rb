require './lib/rcopyfind.rb'
require './test/assert'


def stemmer_tests
  assert("the stemmer is addressable") {
    "addressable".stem == "address" }
end

puts "\n"
puts "Stemmer Tests:"
puts "--------------------------------"
stemmer_tests
