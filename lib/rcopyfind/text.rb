class Text

  attr_reader :filename, :original_word_array, :word_array, :word_hash

  def initialize(plaintext_file)
    @filename = plaintext_file.to_s
    @word_array = init_word_array(plaintext_file)
    @word_hash = init_word_hash(@word_array)
    return nil
  end

  # Intersection of self and other
  def shared_words(other_text, min_word_length, distance: 0)
    if (distance > 0) then
      @word_array.each do |word|
        other_text.word_array.each do |other|
          if (damlev(word, other) > distance) then
            intersection << word
            intersection << other
          end
        end
      end
    else
      intersection = (@word_array & other_text.word_array)
    end
    intersection = intersection.reject{ |word| word.length < min_word_length }
    return intersection
  end

  protected

  def stem_word_array
    @original_word_array = @word_array.dup
    self.word_array.each.with_index do |word, i|
      @word_array[i] = word.stem
    end
  end

  def unstem_word_array
    @word_array = @original_word_array
  end

  private                       # For generating instance variables

  def init_word_array(plaintext_file)
    ary = File.read(plaintext_file).split(" ").map do |word|
      word.downcase.gsub(/[^a-z]/, '')
    end
    return ary
   end

  def init_word_hash(text_ary)
    words_hash = {}
    text_ary.each_with_index do |word, i|
      words_hash[word] = [words_hash[word], i].flatten.compact
    end
    return words_hash
  end

end
