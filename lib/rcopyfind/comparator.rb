require 'rcopyfind/text'

class Comparator < Text

  attr_reader :density, :similar_clusters, :source,
              :source_word_clusters, :target, :target_word_clusters

  def initialize(target, source, min_shared_words: 3,
                 ordered: true, window: 10, min_word_length: 4,
                 edit_distance: 0, stemming: false, stopwords: nil)
    @target = target
    @source = source
    if !(edit_distance == 0) then
      # invoke the damlev pruning
    end
    if stemming then
      @target.stem_word_array
      @source.stem_word_array
    end
    @target_word_clusters = init_word_clusters(target, source,
                                               window, min_shared_words,
                                               min_word_length, stopwords)
    @source_word_clusters = init_word_clusters(source, target,
                                               window, min_shared_words,
                                               min_word_length, stopwords)
    @similar_clusters = init_similar_clusters(min_shared_words, ordered)
    if stemming then
      @target.unstem_word_array
      @source.unstem_word_array
    end
    # @density = comparator_density
  end

  private

  # Given a comparator, returns its "density" as the ratio of sums of
  # the character counts of matching words in similar clusters in the
  # source text to the number of characters in the source text as a
  # whole
  def comparator_density(cmp)
    uniqued_hash = {}
    cmp.similar_clusters.each do |cluster_pair|
      cluster_pair[1].keys.each do |key|
        uniqued_hash[key] = [uniqued_hash[key], cluster_pair[1][key]]
                              .flatten.uniq.compact
      end
    end
    numer = 0
    denom = cmp.source.word_array.join.split('').length.to_f
    uniqued_hash.keys.each do |key|
      numer += (key.split('').length * uniqued_hash[key].length) #
    end
    return (numer / denom)
  end

  def index_clusters(text1, text2, window, min_word_length, stopwords)
    intersection = text1.shared_words(text2, min_word_length)
    if stopwords then
      intersection.reject! { |word| stopwords.include?(word) }
    end
    intersection_h = text1.word_hash
                       .select { |word| intersection.include?(word) }
    values = intersection_h.values.flatten.sort
    index_clusters = partition_index_clusters(values, window)
    return index_clusters
  end

  def partition_index_clusters(values, window)
    i = 0
    index_clusters = []
    while (values.size > 1) do
       if ((values[i+1] - values[i]) > window) then
         index_clusters << values.shift(i+1)
         i = 0
         next
       elsif (values[i+1] == values.last) then
         index_clusters << values.shift(i+2)
       end
      i = i+1
    end
    return index_clusters
  end

  def init_similar_clusters(min_shared_words, ordered)
    similar = get_shared_word_clusters(min_shared_words)
    if (ordered==true) then
      similar = get_shared_ordering_clusters(similar)
    end
    return similar
  end

  def init_word_clusters(text1, text2, window, min_shared_words,
                         min_word_length, stopwords)
    word_clusters = []
    index_clusters(text1, text2, window, min_word_length, stopwords)
      .each do |group|
      words = {}
      group.each do |index|
        words[text1.word_array[index]] = index
      end
      if ((words.length >= min_shared_words) &&
          !(word_clusters.include?(words))) then
        word_clusters << words
      end
    end
    return word_clusters
  end

  # Accepts data of the form [[{}, {}], [{}, {}]...]
  def get_shared_ordering_clusters(shared_word_clusters)
    shared_ordering_clusters = []
    shared_word_clusters.each do |pair|
      # Make arrays of keys in the order they occur in the texts
      a = pair[0].select { |x| pair[1].key?(x) }
            .sort_by { |_, y| y }.flatten.select.with_index { |_, i| i.even? }
      b = pair[1].select { |x| pair[0].key?(x) }
            .sort_by { |_, y| y }.flatten.select.with_index { |_, i| i.even? }
      if (a == b) then
        shared_ordering_clusters << pair
      end
    end
    return shared_ordering_clusters
  end

  def get_shared_word_clusters(min_shared_words) # OPTIMIZE
    shared_word_clusters = []
    @target_word_clusters.each do |target_cluster|
      @source_word_clusters.each do |source_cluster|
        intersection = (target_cluster.keys & source_cluster.keys)
        if (intersection.length >= min_shared_words) then
          i = target_cluster.select { |word| intersection.include?(word) }
          j = source_cluster.select { |word| intersection.include?(word) }
          shared_word_clusters << [i, j]
        end
      end
    end
    return shared_word_clusters
  end

end
