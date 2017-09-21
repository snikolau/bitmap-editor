module BitmapEditor
  class NullBitmap
    def to_s
      "Bitmap is not initialized."
    end

    def color_pixel(_x, _y, _color)
      raise BitmapNotInitialized
    end

    def coordinate_within_bounds?(_x, _y)
      raise BitmapNotInitialized
    end

    def reset
      raise BitmapNotInitialized
    end
  end
end
