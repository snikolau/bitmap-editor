class BitmapEditor
  attr_reader :bitmap

  def new_bitmap(width, height)
    @bitmap = Bitmap.new(width, height)
  end
end
