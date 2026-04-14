def count_words(string)
  string.downcase.scan(/\b\w+\b/).each_with_object(Hash.new(0)) do |word, counts|
    counts[word] += 1
  end
end
