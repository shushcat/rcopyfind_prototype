require './lib/rcopyfind.rb'
require './test/assert'


def damlev_tests
  assert("single character substitution and transposition are the same") {
    damlev("hello", "hallo") == damlev("hello", "ehllo") }
end

puts "\n"
puts "Damlev Tests:"
puts "--------------------------------"
damlev_tests
