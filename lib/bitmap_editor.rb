class BitmapEditor
  attr_reader :bitmap

  def initialize(bitmap = nil)
    @bitmap = bitmap
  end

  def new_bitmap(width, height)
    @bitmap = Bitmap.new(width, height)
  end

  def color_pixel(x, y, color)
    bitmap.color_pixel(x, y, color)
  end

  def draw_vertical_segment(x, y1, y2, color)
    unless vertical_line_in_bounds?(x, y1, y2)
      raise Bitmap::CoordinatesOutOfBounds,
            "x, from_y, to_y(#{x}, #{y1}, #{y2})," \
            "bitmap bounds(#{bitmap.width}, #{bitmap.height})"
    end

    Range.new(*[y1,y2].sort).each do |y_i|
      color_pixel(x, y_i, color)
    end
  end

  private

  def vertical_line_in_bounds?(x, y1, y2)
    bitmap.coordinate_within_bounds?(x, y1) &&
      bitmap.coordinate_within_bounds?(x, y2)
  end
end
