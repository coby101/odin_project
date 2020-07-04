
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(str, dict)
  result = {}
  count = 0
  test_str = str.downcase
  dict.each do |sub_str|
    count = times_found sub_str, test_str
    unless count == 0
      result[sub_str] = count
    end
  end
  result
end

def times_found(sub_str, str)
  (str.scan sub_str).length
end


def test_substrings(dict)
  test_data = { # test_str => expected_result
    "below" => { "below" => 1, "low" => 1 },
    "Howdy partner, sit down! How's it going?" => { "down" => 1, "how" => 2, "howdy" => 1,"go" => 1, "going" => 1, "it" => 2, "i" => 3, "own" => 1,"part" => 1,"partner" => 1,"sit" => 1 }
  }
  results = []
  test_data.all? { |test, result| results.push result == substrings(test, dict) }
  if results.all? then "good" else "bad" end
end
