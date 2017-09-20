class Bitmap
  DEFAULT_FILL = 'O'.freeze
  MAX_SIZE = 250
  InvalidSize = Class.new(StandardError)

  attr_reader :width, :height

  def initialize(width, height)
    @width = width
    @height = height
    validate_size
  end

  def to_s
    data.inject('') do |output, row|
      output << row.join(' ') << "\n"
    end
  end

  private

  def validate_size
    if !height.between?(1, MAX_SIZE) || !width.between?(1, MAX_SIZE)
      raise InvalidSize, "Bitmap size should be between (0, #{MAX_SIZE})"
    end
  end

  def data
    @data ||= Array.new(height) { Array.new(width, DEFAULT_FILL) }
  end
end
