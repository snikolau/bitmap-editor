module BitmapEditor
  class Bitmap
    COLOR_REGEX = /\A[A-Z]\z/
    DEFAULT_FILL = 'O'.freeze
    MAX_SIZE = 250

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
      validate_bounds(x, y)
      validate_color(color)

      data[y][x] = color
    end

    def coordinate_within_bounds?(x, y)
      x.between?(0, width - 1) && y.between?(0, height - 1)
    end

    def reset
      @data = clean_data
    end

    private

    def validate_size
      if !height.between?(1, MAX_SIZE) || !width.between?(1, MAX_SIZE)
        raise InvalidSize, "Bitmap size should be between (1, #{MAX_SIZE})"
      end
    end

    def validate_bounds(x, y)
      unless coordinate_within_bounds?(x, y)
        raise CoordinatesOutOfBounds, "x, y (#{x}, #{y}), bitmap bounds (#{width}, #{height})"
      end
    end

    def validate_color(color)
      raise InvalidColor unless color =~ COLOR_REGEX
    end

    def data
      @data ||= clean_data
    end

    def clean_data
      Array.new(height) { Array.new(width, DEFAULT_FILL) }
    end
  end
end
