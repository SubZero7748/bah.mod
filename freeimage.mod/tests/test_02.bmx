' TEST 2
'
' Load a jpg, modify the image, and display.

SuperStrict

Framework BaH.FreeImage
Import brl.glmax2d


' Load the image
Local img:TFreeImage = LoadFreeImage("logo.jpg")

' did the image load?
If img Then
	DebugLog("Loaded ok.")
Else
	DebugLog("Couldn't load...")
	End
End If


' do some manipulation...
img.flipHorizontal()

' for 32 bit images... it will also invert ALPHA !!! (making things invisible)
img.invert()

img = img.rotate(45)


' Display the image

Graphics 800,600,0

' get the Pixmap via the getPixmap() method.
Local image:TImage = LoadImage(img.getPixmap())

While Not KeyDown(key_escape)

	Cls
	
	DrawImage image, 400 - ImageWidth(image)/2, 300 - ImageHeight(image)/2
	
	Flip
	
Wend

End