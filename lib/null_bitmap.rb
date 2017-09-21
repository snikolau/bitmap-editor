class NullBitmap
  def to_s
    "Bitmap is not initialized."
  end

  def color_pixel(_x, _y, _color)
    raise BitmapError::NotInitialized
  end

  def coordinate_within_bounds?(_x, _y)
    raise BitmapError::NotInitialized
  end

  def reset
    raise BitmapError::NotInitialized
  end
end
