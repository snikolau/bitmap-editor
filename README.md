# Bitmap editor

There are 6 supported commands:
 - I M N - Create a new M x N image with all pixels coloured white (O).
 -  C - Clears the table, setting all pixels to white (O).
 - L X Y C - Colours the pixel (X,Y) with colour C.
 - V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1
and Y2 (inclusive).
-  H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns
X1 and X2 (inclusive).
-  S - Show the contents of the current image

# Running

`>bin/bitmap_editor examples/show.txt`

# Remarks
As this was not a main focus of this exercise, current implementation reads commands one by one, there is no optimisation on command scanning, to prevent unnecessary bitmap operations, like skip drawing if in the next step there is a command to clean bitmap. Additionally there could be a small optimisation made for loop execution to reduce amount of steps.
