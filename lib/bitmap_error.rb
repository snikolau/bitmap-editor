module BitmapError
  BitmapException = Class.new(StandardError)
  NotInitialized = Class.new(BitmapException)
end
