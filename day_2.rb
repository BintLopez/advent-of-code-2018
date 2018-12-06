require 'pry'

class Day2
  attr_reader :inputs

  def self.problem_1(input_file_path)
    file_inputs = File.read(input_file_path).split("\n")
    new(file_inputs).checksum
  end

  def self.problem_2(input_file_path)
    file_inputs = File.read(input_file_path).split("\n")
    instance = new(file_inputs)
    binding.pry
    instance.shared_chars_for_near_match
  end

  def initialize(inputs)
    @inputs = inputs
  end

  def shared_chars_for_near_match
    compare_strings(near_match.first, near_match.last).compact.join('')
  end

  def near_match
    @near_match ||= begin
      inputs.each_with_object(inputs) do |str, to_compare|
        to_compare -= [str]
        near_match = to_compare.detect do |compare_str|
          arr = compare_strings(str, compare_str)
          arr.compact.count == str.split('').count - 1
        end

        return [str, near_match] if near_match
        to_compare
      end
    end
  end

  def compare_strings(str1, str2)
    str1_arr = str1.split('')
    str2_arr = str2.split('')
    
    results = []

    str1_arr.each_with_index do |char, i|
      if char == str2_arr[i]
        results << char
      else
        results << nil
      end
    end

    results
  end

  def checksum
    find_two_matching.count * find_three_matching.count
  end

  def find_two_matching
    character_frequencies[:two_matching_chars]
  end

  def find_three_matching
    character_frequencies[:three_matching_chars]
  end

  def character_frequencies
    @processed_inputs ||= begin
      inputs.each_with_object(Hash.new([])) do |str, hash|
        char_counts = matching_chars_lookup(str.split(''))

        char_counts.values.each do |char_freq|
          hash[:two_matching_chars] += [str] if char_freq == 2
          hash[:three_matching_chars] += [str] if char_freq == 3
        end

        hash
      end.tap do |freqs_with_dupes|
        freqs_with_dupes.values.each(&:uniq!)
      end
    end
  end

  def matching_chars_lookup(characters)
    characters.each_with_object(Hash.new(0)) do |char, hash|
      hash[char] += 1
    end
  end
end