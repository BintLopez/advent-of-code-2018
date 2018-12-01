class Day1

  def self.problem_1(start_value, input_path)
    inputs_array = FileProcessing.parse(input_path)
    transformation = Transform.new(start_value, inputs_array)
    transformation.get_final_value
  end
  
  def self.problem_2(start_value, input_path)
    # results = [start_value]

    # input.each do |offset_raw|
    #   offset = Offset.new(offset_raw)
    #   start_value = start_value.send(offset.operator, offset.value)
    #   return start_value if results.include?(start_value)
    #   results << start_value
    # end

    inputs_array = FileProcessing.parse(input_path)
    Transform.new(start_value, inputs_array).find_first_match
  end

end

class FileProcessing
  def self.parse(input_file_path)
    File.read(input_file_path).split("\n")
  end
end

class Transform
  attr_reader :inputs, :start_value

  def initialize(start_value, inputs)
    @start_value = start_value
    @inputs = inputs
  end

  def get_final_value
    transformed = start_value

    inputs.each do |offset_raw|
      offset = Offset.new(offset_raw)
      transformed = transformed.send(offset.operator, offset.value)
    end

    transformed
  end

  def find_first_match(find_match_start=start_value, results=[start_value])
    inputs.each do |offset_raw|
      offset = Offset.new(offset_raw)
      find_match_start = find_match_start.send(offset.operator, offset.value)
      return find_match_start if results.include?(find_match_start)
      results << find_match_start
    end
    find_first_match(find_match_start, results)
  end
end

class Offset
  attr_reader :operator, :value, :raw

  def initialize(raw)
    @raw = raw
    @operator = get_operator
    @value = get_value
  end

  def get_operator
    /\D/.match(raw)[0].to_sym
  end

  def get_value
    /\d{1,}/.match(raw)[0].to_i
  end
end