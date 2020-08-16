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
    short_code
  end

  def self.generate_short_code number
    begin
      short_code = UrlShortner.convert_integer_to_string(number)
    end while ShortUrl.exists?(short_code: short_code)
    short_code
  end

end#module
