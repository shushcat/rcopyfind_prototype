require "damerau-levenshtein"

def damlev(word1, word2)
  DamerauLevenshtein.distance(word1, word2)
end
