class Bitmap
  DEFAULT_FILL = 'O'.freeze
  MAX_SIZE = 250
  BitmapError = Class.new(StandardError)
  InvalidSize = Class.new(BitmapError)
  CoordinatesOutOfBounds = Class.new(BitmapError)

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

  def color_pixel(x, y, color)
    unless coordinate_within_bounds?(x, y)
      raise CoordinatesOutOfBounds, "x, y (#{x}, #{y}), bitmap bounds (#{width}, #{height})"
    end

    data[y][x] = color
  end

  def coordinate_within_bounds?(x, y)
    x.between?(0, width - 1) && y.between?(0, height - 1)
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
