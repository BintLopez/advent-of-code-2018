require 'spec_helper'
require_relative '../day_2'

describe 'Day 2' do
  describe 'Problem 1' do
    # Late at night, you sneak to the warehouse - who knows what kinds of paradoxes you could cause if you were discovered - and use your fancy wrist device to quickly scan every box and produce a list of the likely candidates (your puzzle input).

    # To make sure you didn't miss any, you scan the likely candidate boxes again, counting the number that have an ID containing exactly two of any letter and then separately counting those with exactly three of any letter. You can multiply those two counts together to get a rudimentary checksum and compare it to what your device predicts.

    # For example, if you see the following box IDs:

    # abcdef contains no letters that appear exactly two or three times.
    # bababc contains two a and three b, so it counts for both.
    # abbcde contains two b, but no letter appears exactly three times.
    # abcccd contains three c, but no letter appears exactly two times.
    # aabcdd contains two a and two d, but it only counts once.
    # abcdee contains two e.
    # ababab contains three a and three b, but it only counts once.
    # Of these box IDs, four of them contain a letter which appears exactly twice, and three of them contain a letter which appears exactly three times. Multiplying these together produces a checksum of 4 * 3 = 12.

    # What is the checksum for your list of box IDs?
    let(:input) do
      %w(
        abcdef
        bababc 
        abbcde
        abcccd
        aabcdd 
        abcdee
        ababab
      )
    end

    it 'finds all the ids where a digit appears exactly twice' do
      result = Day2.new(input).find_two_matching
      expect(result.count).to eq(4)
      expect(result).to contain_exactly('bababc','abbcde','aabcdd','abcdee')
    end

    it 'finds all the ides where a digit apprears exactly 3 times' do
      result = Day2.new(input).find_three_matching
      expect(Day2.new(input).find_three_matching.count).to eq(3)
      expect(result).to contain_exactly('bababc','ababab','abcccd')
    end

    it "calculates the correct checksum" do
      expect(Day2.new(input).checksum).to eq(12)
    end
  end

  describe 'Problem 2' do
    # Confident that your list of box IDs is complete, you're ready to find the boxes full of prototype fabric.

    # The boxes will have IDs which differ by exactly one character at the same position in both strings. For example, given the following box IDs:

    # abcde
    # fghij
    # klmno
    # pqrst
    # fguij
    # axcye
    # wvxyz
    # The IDs abcde and axcye are close, but they differ by two characters (the second and fourth). However, the IDs fghij and fguij differ by exactly one character, the third (h and u). Those must be the correct boxes.

    # What letters are common between the two correct box IDs? (In the example above, this is found by removing the differing character from either ID, producing fgij.)

    let(:input) do
      %w(
        abcde
        fghij
        klmno
        pqrst
        fguij
        axcye
        wvxyz
      )
    end

    subject { Day2.new(input) }

    it 'finds near identical ids' do
      expect(subject.near_match).to contain_exactly('fghij', 'fguij')
    end

    it 'returns the similar letters between them' do
      expect(subject.shared_chars_for_near_match).to eq('fgij')
    end
  end
end