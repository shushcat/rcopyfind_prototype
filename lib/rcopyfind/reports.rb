require 'rcopyfind'

def limit_context(word_array, index_array, context_words)
  first_index = index_array.sort[0]
  last_index = index_array.sort[-1]
  range = ((first_index-context_words)..(last_index+context_words))
  limited_word_array = []
  range.each do |i|
    limited_word_array << word_array[i]
  end
  return limited_word_array
end

def highlight(word_array, index_array)
  highlighted_array = word_array.clone
  if STDOUT.isatty then
    pre = "\e[7m"
    post = "\e[0m"
  else
    pre = "**"
    post = "**"
  end
  index_array.each do |i|
    highlighted_array[i] = (pre + highlighted_array[i] + post)
  end
  return highlighted_array
end

def print_report(comparator, context_words: 10)
  width = 58
  puts "target: #{comparator.target.filename}"
  puts "source: #{comparator.source.filename}"
  puts "--------------------------------"
  if comparator.similar_clusters.empty? then
    puts "No similar clusters found."
    puts "--------------------------------"
  else
    comparator.similar_clusters.each do |pair|
      highlighted = highlight(comparator.target.word_array, pair[0].values)
      puts limit_context(highlighted, pair[0].values, context_words).join(" ")
             .gsub(/(.{1,#{width}})(\s+|\Z)/, "< \\1\n")
      puts "---"
      highlighted = highlight(comparator.source.word_array, pair[1].values)
      puts limit_context(highlighted, pair[1].values, context_words).join(" ")
             .gsub(/(.{1,#{width}})(\s+|\Z)/, "> \\1\n")
      puts "--------------------------------"
    end
  end
  return nil
end
