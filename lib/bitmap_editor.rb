class BitmapEditor
  attr_reader :bitmap

  def new_bitmap(width, height)
    @bitmap = Bitmap.new(width, height)
  end

  def color_pixel(x, y, color)
    bitmap.color_pixel(x, y, color)
  end
end
