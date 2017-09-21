module BitmapEditor
  BitmapEditorError = Class.new(StandardError)
  InvalidCommand = Class.new(BitmapEditorError)
  BitmapNotInitialized = Class.new(BitmapEditorError)
  InvalidSize = Class.new(BitmapEditorError)
  InvalidColor = Class.new(BitmapEditorError)
  CoordinatesOutOfBounds = Class.new(BitmapEditorError)

  require 'bitmap_editor/null_bitmap'
  require 'bitmap_editor/bitmap'
  require 'bitmap_editor/editor'
  require 'bitmap_editor/command_parser'
end
