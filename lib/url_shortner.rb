module UrlShortner

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze #character set for short code
  BASE = CHARACTERS.length

  def self.convert_integer_to_string(number)
    return CHARACTERS[0]  if number == 0
    short_code = ''
    while number > 0
      short_code << CHARACTERS[number%BASE]
      number /= BASE
    end
    short_code.reverse
  end

  def self.generate_short_code number
    UrlShortner.convert_integer_to_string(number)
  end

end#module
