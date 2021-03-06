SuperStrict

Framework BaH.RTL
Import BRL.GLMax2D
Import BRL.FreeTypeFont

Local text:String = "العربية"

Graphics 800, 600, 0

SetBlend ALPHABLEND

Local arabFont:TImageFont = LoadImageFont("cyberbase.ttf", 35)
Local font:TImageFont = LoadImageFont("cyberbase.ttf", 20)

While Not KeyDown(KEY_ESCAPE)

	Cls
	
	SetImageFont(arabFont)

	DrawText text, 100, 130
	
	' Note : you probably DON'T want to format the string on every loop, since it has potentially
	' a lot of conversion to do. Ideally you store the changes elsewhere so you simply have to draw the string.
	DrawText FormatStringRTL(text), 100, 180

	SetImageFont(font)
	DrawText "<-- Incorrect (default)", 300, 150
	DrawText "<-- Properly formatted (BaH.RTL)", 300, 190
	
	Flip

Wend

