# frozen_string_literal:false

def secret_word(word_file)
  word_list = []
  File.foreach(word_file) do |line|
    word_list.append(line.chomp) if line.chomp.length > 5 && line.chomp.length < 13
  end
  word_list.sample
end

puts "-*-*-*-*-*-*-*-*-*-*- Let's Hang the Man -*-*-*-*-*-*-*-*-*-*-*-*-"
