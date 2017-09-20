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

  def draw_horizontal_segment(x1, x2, y, color)
    unless horizontal_line_in_bounds?(x1, x2, y)
      raise Bitmap::CoordinatesOutOfBounds,
            "x, from_y, to_y(#{x1}, #{x2}, #{y})," \
            "bitmap bounds(#{bitmap.width}, #{bitmap.height})"
    end

    Range.new(*[x1,x2].sort).each do |x_i|
      color_pixel(x_i, y, color)
    end
  end

  def clean_bitmap
    bitmap.reset
  end

  private

  def vertical_line_in_bounds?(x, y1, y2)
    bitmap.coordinate_within_bounds?(x, y1) &&
      bitmap.coordinate_within_bounds?(x, y2)
  end

  def horizontal_line_in_bounds?(x1, x2, y)
    bitmap.coordinate_within_bounds?(x1, y) &&
      bitmap.coordinate_within_bounds?(x2, y)
  end
end
