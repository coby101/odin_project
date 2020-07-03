###############################################
#
# Get a message and a Ceasar Cipher key (integer offset) from the user and code or decode a message:
#  - shift each letter forwards in the alphabet by the Cipher key value
#      - negative offsets are allowed
#      - arbitrarily large offsets are allowed
#      - if the offset shifts a letter past the end or beginning of the alphabet it will wrap around to the other end
#  - preserve letter case
#  - do not alter any non-alpha characters
#  - there are no message length constraints
#     - long messages may not present that nicely
#
################################################            

require 'readline'

# constants
ALPHA_SIZE = 26
CAP_A = 65
CAP_Z = 90
SML_A = 97
SML_Z = 122

# User interface

# little utility for getting user input without moving to a new line
#   credit: ma11hew28 on https://stackoverflow.com/questions/2889720/
def get_input(prompt="", newline=false)
  prompt += "\n" if newline
  Readline.readline(prompt, true).squeeze(" ").strip
end

def create_secret_message ()
  message = get_input("Enter the message you want to encode: ")
  key = get_input("Enter the cipher key (an integer value): ")
  until key.to_i.to_s == key
    key = get_input("The cipher key must be an integer value: ")
  end
  puts "This is your coded message:  \"#{encode_ceasar_cipher(message, key.to_i)}\""
end

def decode_secret_message ()
  message = get_input("Enter the message you want to decode: ") 
  key = get_input("Enter the cipher key (an integer value): ")
  until key.to_i.to_s == key
    key = get_input("The cipher key must be an integer value: ")
  end
  puts "The secret message is:  \"#{decode_ceasar_cipher(message, key.to_i)}\""
end

def circular_shift(value, range, shift)
  shifted_value = value + (shift % range.size)
  (range.include? shifted_value) ? shifted_value : shifted_value - range.size
end

# Cipher encoder
def encode_ceasar_cipher (str, offset)
  normalized_offset = offset % ALPHA_SIZE
  coded_chars = []
  str.each_byte do |c|
    coded_chars.push case
                     when c.between?(SML_A, SML_Z) then circular_shift(c, SML_A..SML_Z, offset)
                     when c.between?(CAP_A, CAP_Z) then circular_shift(c, CAP_A..CAP_Z, offset)
                     else c
                     end
  end
  coded_chars.pack("c*")
end

def decode_ceasar_cipher (str, offset)
  encode_ceasar_cipher(str, -offset)
end


# test code
def test_cipher ()
  test_string = "ABCDWXYZ abcdwxyz 1234567890 ,::<>?\"':=\t!@#$%"
  results = []
  for i in -100..100 do
    results.push test_string == decode_ceasar_cipher(encode_ceasar_cipher(test_string, i), i)
  end
  if results.all? {|elt| elt} then puts "All good" else "houston, we have a problem" end
end

