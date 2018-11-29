def parse_options
  # Set default options
  target, source = nil
  window = 10
  min_shared_words = 3
  min_word_length = 4
  ordered = true
  stemming = false
  stopwords = nil
  # Parse switches
  loop do
    case ARGV[0]
    when "-h", "--help" then
      print_usage
      exit
    when "-t", "--target" then
      ARGV.shift
      target = Text.new(ARGV.shift)
    when "-s", "--source" then
      ARGV.shift
      source = Text.new(ARGV.shift)
    when "-w", "--window" then
      ARGV.shift
      window = ARGV.shift.to_i
    when "-msw", "--min-shared-words" then
      ARGV.shift
      min_shared_words = ARGV.shift.to_i
    when "-mwl", "--min-word-length" then
      ARGV.shift
      min_word_length = ARGV.shift.to_i
    when "-no", "--not-ordered" then
      ARGV.shift
      ordered = false
    when "-stem", "--stemming" then
      ARGV.shift
      stemming = true
    when "-stop", "--stopwords" then
      ARGV.shift
      stopwords = File.read(ARGV.shift).split(" ").map do |word|
        word.downcase.gsub(/[^a-z]/, '')
      end
    when /^-/, /^./ then
      puts "invalid option #{ARGV[0].inspect} (-h will show valid options)"
      print_usage
    else break
    end
  end
  return target, source, window, min_shared_words,
         min_word_length, ordered, stemming, stopwords
end

def print_usage
  puts "Usage: -t,    --target           <target file>"
  puts "       -s,    --source           <source file>"
  puts "       -w,    --window           <window>"
  puts "       -msw,  --min-shared-words <minimum shared words>"
  puts "       -mwl,  --min-word-length  <minimum word length>"
  puts "       -no,   --not-ordered"
  puts "       -stem,   --stemming"
  puts "       -stop, --stopwords        <stopword file>"
  exit
end
