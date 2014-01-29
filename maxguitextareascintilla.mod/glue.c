/*
 Copyright (c) 2014 Bruce A Henderson
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
*/
#include <gtk/gtk.h>
#include <Scintilla.h>
#include <SciLexer.h>
#include <ScintillaWidget.h>

#include "blitz.h"

ScintillaObject * bmx_mgta_scintilla_getsci(GtkWidget * editor, int id) {
	ScintillaObject * obj = SCINTILLA(editor);
	scintilla_set_id(obj, id);
	return obj;
}

BBString * bmx_mgta_scintilla_gettext(ScintillaObject * sci) {
	int len = scintilla_send_message(sci, SCI_GETLENGTH, 0, 0);
	
	char * buffer = malloc(len + 1);
	
	scintilla_send_message(sci, SCI_GETTEXT, len, buffer);
	
	BBString * s = bbStringFromCString(buffer);
	
	free(buffer);

	return s;
}

void bmx_mgta_scintilla_settext(ScintillaObject * sci, BBString * text) {

	char * t = bbStringToUTF8String(text);

	scintilla_send_message(sci, SCI_SETTEXT, 0, t);
	
	bbMemFree(t);
}

void bmx_mgta_scintilla_setfont(ScintillaObject * sci, BBString * name, int size) {
	int style;

	char * n = bbStringToUTF8String(name);

	/* make sure all the styles are changed */
	for (style = 0; style < STYLE_MAX; style++) {
		scintilla_send_message(sci, SCI_STYLESETFONT, style, n);
		scintilla_send_message(sci, SCI_STYLESETSIZE, style, size);
	}
	
	bbMemFree(n);
}

int bmx_mgta_scintilla_positionfromline(ScintillaObject * sci, int line) {
	return scintilla_send_message(sci, SCI_POSITIONFROMLINE, line, 0);
}

void bmx_mgta_scintilla_setselectionstart(ScintillaObject * sci, int pos) {
	scintilla_send_message(sci, SCI_SETSELECTIONSTART, pos, 0);
}

void bmx_mgta_scintilla_setselectionend(ScintillaObject * sci, int pos) {
	scintilla_send_message(sci, SCI_SETSELECTIONEND, pos, 0);
}

void bmx_mgta_scintilla_scrollcaret(ScintillaObject * sci) {
	scintilla_send_message(sci, SCI_SCROLLCARET, 0, 0);
}

void bmx_mgta_scintilla_setselel(ScintillaObject * sci, int startPos, int endPos) {
	scintilla_send_message(sci, SCI_SETSEL, startPos, endPos);
}

void bmx_mgta_scintilla_replacesel(ScintillaObject * sci, const char * text) {
	scintilla_send_message(sci, SCI_REPLACESEL, 0, text);
}

void bmx_mgta_scintilla_stylesetback(ScintillaObject * sci, int col) {
	int style;
	
	for (style = 0; style < STYLE_MAX; style++) {
		scintilla_send_message(sci, SCI_STYLESETBACK, style, col);
	}
}

void bmx_mgta_scintilla_stylesetfore(ScintillaObject * sci, int style, int color) {
	scintilla_send_message(sci, SCI_STYLESETFORE, style, color);
}

void bmx_mgta_scintilla_stylesetitalic(ScintillaObject * sci, int style, int value) {
	scintilla_send_message(sci, SCI_STYLESETITALIC, style, value);
}

void bmx_mgta_scintilla_stylesetbold(ScintillaObject * sci, int style, int value) {
	scintilla_send_message(sci, SCI_STYLESETBOLD, style, value);
}

void bmx_mgta_scintilla_stylesetunderline(ScintillaObject * sci, int style, int value) {
	scintilla_send_message(sci, SCI_STYLESETUNDERLINE, style, value);
}

void bmx_mgta_scintilla_startstyling(ScintillaObject * sci, int startPos, int style) {
	scintilla_send_message(sci, SCI_STARTSTYLING, startPos, style);
}

void bmx_mgta_scintilla_setstyling(ScintillaObject * sci, int realLength, int style) {
	if (realLength == -1) {
		realLength = scintilla_send_message(sci, SCI_GETLENGTH, 0, 0);
	}
	scintilla_send_message(sci, SCI_SETSTYLING, realLength, style);
}

BBString * bmx_mgta_scintilla_gettextrange(ScintillaObject * sci, int startPos, int endPos) {
	if (endPos == -1) {
		endPos = scintilla_send_message(sci, SCI_GETLENGTH, 0, 0);
	}

	struct Sci_TextRange range;
	range.chrg.cpMin = startPos;
	range.chrg.cpMax = endPos;
	
	range.lpstrText = malloc(endPos - startPos + 1);
	
	int len = scintilla_send_message(sci, SCI_GETTEXTRANGE, 0, &range);
	
	BBString * s = bbStringFromUTF8String(range.lpstrText);
	free(range.lpstrText);
	return s;
}