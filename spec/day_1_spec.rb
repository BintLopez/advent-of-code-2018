require 'spec_helper'
require_relative '../day_1'

describe 'Day 1 Problem' do
  # Problem:  https://adventofcode.com/2018/day/1

  let(:input_file_path) { "day_1_input.txt" }
  let(:start_value)     { 0 }

  it 'converts string to offset object' do
    offset = Offset.new("+42")
    expect(offset.operator).to eq(:+)
    expect(offset.value).to eq(42)
  end

  describe 'problem_1' do
    # +1, +1, +1 results in  3
    # +1, +1, -2 results in  0
    # -1, -2, -3 results in -6
    let(:test_data) do
      [
        { inputs: %w(+1 +1 +1), answer: 3    },
        { inputs: %w(+1 +1 -2), answer: 0    },
        { inputs: %w(-1 -2 -3), answer: -6 },
      ]
    end

    it 'finds the final value' do
      test_data.each do |td|
        expect(Transform.new(start_value, td[:inputs]).get_final_value).to eq(td[:answer])
      end
    end
  end

  describe 'problem 2' do
    # +1, -1 first reaches 0 twice.
    # +3, +3, +4, -2, -4 first reaches 10 twice.
    # -6, +3, +8, +5, -6 first reaches 5 twice.
    # +7, +7, -2, -7, -4 first reaches 14 twice.
    let(:test_data) do
      [
        { inputs: %w(+1 -1),           answer: 0  },
        { inputs: %w(+3, +3 +4 -2 -4), answer: 10 },
        { inputs: %w(-6 +3 +8 +5 -6),  answer: 5  },
        { inputs: %w(+7 +7 -2 -7 -4),  answer: 14 }
      ]
    end

    it 'finds the frequency first reached twice' do
      test_data.each do |td|
        expect(Transform.new(start_value, td[:inputs]).find_first_match).to eq(td[:answer])
      end
    end
  end
end