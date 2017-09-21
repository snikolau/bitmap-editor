module BitmapEditor
  BitmapEditorError = Class.new(StandardError)
  InvalidCommand = Class.new(BitmapEditorError)
  BitmapNotInitialized = Class.new(BitmapEditorError)
  InvalidSize = Class.new(BitmapEditorError)
  InvalidColor = Class.new(BitmapEditorError)
  CoordinatesOutOfBounds = Class.new(BitmapEditorError)

  require_relative 'bitmap_editor/null_bitmap'
  require_relative 'bitmap_editor/bitmap'
  require_relative 'bitmap_editor/editor'
  require_relative 'bitmap_editor/command_parser'
end
