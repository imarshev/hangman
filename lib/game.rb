class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.upcase.chars
    @user_guesses = []
  end

  def errors_made
    errors.length
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    result = @letters.map do |letter|
      letter if @user_guesses.include?(normalize_letter(letter))
    end
  end

  def errors
    @user_guesses - normalized_letters
  end

  def over?
    won? || lost?
  end

  def play!(letter)
    normalized_letter = normalize_letter(letter)
    if !over? && !@user_guesses.include?(normalized_letter)
      @user_guesses << normalized_letter
    end
  end

  def word
    @letters.join
  end

  def won?
    (normalized_letters - @user_guesses).empty?
  end

  def lost?
    errors_allowed == 0
  end

  def normalize_letter(letter)
    if letter == 'Ё'
      'Е'
    elsif letter == 'Й'
      'И'
    else
      letter
    end
  end

  def normalized_letters
    @letters.map { |letter| normalize_letter(letter) }
  end
end
