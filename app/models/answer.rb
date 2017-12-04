class Answer
  def initialize(raw)
    @raw = raw
  end

  def correct?(input)
    return true if input == @raw
    normalize(input) == normalize(@raw)
  end

  def to_s
    @raw
  end

  def empty?
    @raw.blank?
  end

  private

  def normalize(string)
    numbers = NumbersInWords.in_numbers(string, NumbersInWords.language, true)
    if numbers.is_a?(Float) || numbers.is_a?(Integer)
      number = (numbers.to_i == numbers) ? numbers.to_i : numbers
      word = NumbersInWords.in_words(number, NumbersInWords.language)
      normalized = string.gsub(word, number.to_s)
    elsif numbers.is_a? Array
      normalized = string
      numbers.each do |n|
        word = NumbersInWords.in_words(n, NumbersInWords.language)
        normalized = normalized.gsub(word, n.to_s)
      end
    end
    normalized
  end
end
