' Copyright (c) 2009-2015 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Import BRL.Blitz
Import Pub.ZLib
'Import BaH.FreeImage

Import "../../pub.mod/zlib.mod/*.h"
Import "src/*.h"

Import "src/adaptmap.c"
Import "src/affine.c"
Import "src/affinecompose.c"
Import "src/arithlow.c"
Import "src/arrayaccess.c"
Import "src/bardecode.c"
Import "src/baseline.c"
Import "src/bbuffer.c"
Import "src/bilinear.c"
Import "src/binarize.c"
Import "src/binexpand.c"
Import "src/binexpandlow.c"
Import "src/binreduce.c"
Import "src/binreducelow.c"
Import "src/blend.c"
Import "src/bmf.c"
Import "src/bmpiostub.c"
Import "src/boxbasic.c"
Import "src/boxfunc1.c"
Import "src/boxfunc2.c"
Import "src/boxfunc3.c"
Import "src/boxfunc4.c"
Import "src/bytearray.c"
Import "src/ccbord.c"
Import "src/ccthin.c"
Import "src/classapp.c"
Import "src/colorcontent.c"
Import "src/coloring.c"
Import "src/colormap.c"
Import "src/colormorph.c"
Import "src/colorquant1.c"
Import "src/colorquant2.c"
Import "src/colorseg.c"
Import "src/colorspace.c"
Import "src/compare.c"
Import "src/conncomp.c"
Import "src/convolve.c"
Import "src/convolvelow.c"
Import "src/correlscore.c"
Import "src/dnabasic.c"
Import "src/dwacomb.2.c"
Import "src/dwacomblow.2.c"
Import "src/edge.c"
Import "src/enhance.c"
Import "src/fhmtauto.c"
Import "src/fhmtgen.1.c"
Import "src/fhmtgenlow.1.c"
Import "src/finditalic.c"
Import "src/flipdetect.c"
Import "src/fliphmtgen.c"
Import "src/fmorphauto.c"
Import "src/fmorphgen.1.c"
Import "src/fmorphgenlow.1.c"
Import "src/fpix1.c"
Import "src/fpix2.c"
Import "src/gifiostub.c"
Import "src/gplot.c"
Import "src/graphics.c"
Import "src/graymorph.c"
Import "src/graymorphlow.c"
Import "src/grayquant.c"
Import "src/grayquantlow.c"
Import "src/heap.c"
Import "src/jbclass.c"
Import "src/jpegiostub.c"
Import "src/kernel.c"
Import "src/libversions.c"
Import "src/list.c"
Import "src/maze.c"
Import "src/morphapp.c"
Import "src/morph.c"
Import "src/morphdwa.c"
Import "src/morphseq.c"
Import "src/numabasic.c"
Import "src/numafunc1.c"
Import "src/numafunc2.c"
Import "src/pageseg.c"
Import "src/paintcmap.c"
Import "src/parseprotos.c"
Import "src/partition.c"
Import "src/pdfiostub.c"
'Import "src/pngio.c"
Import "src/pngiostub.c"
Import "src/pix1.c"
Import "src/pix2.c"
Import "src/pix3.c"
Import "src/pix4.c"
Import "src/pix5.c"
Import "src/pixabasic.c"
Import "src/pixacc.c"
Import "src/pixafunc1.c"
Import "src/pixafunc2.c"
Import "src/pixalloc.c"
Import "src/pixarith.c"
Import "src/pixcomp.c"
Import "src/pixconv.c"
Import "src/pixtiling.c"
Import "src/pnmiostub.c"
Import "src/projective.c"
'Import "src/psio1.c"
Import "src/psio1stub.c"
'Import "src/psio2.c"
Import "src/psio2stub.c"
Import "src/ptabasic.c"
Import "src/ptafunc1.c"
Import "src/ptra.c"
'Import "src/pts.c"
Import "src/quadtree.c"
Import "src/queue.c"
Import "src/rank.c"
Import "src/readbarcode.c"
Import "src/readfile.c"
Import "src/rop.c"
Import "src/ropiplow.c"
Import "src/roplow.c"
Import "src/rotateam.c"
Import "src/rotateamlow.c"
Import "src/rotate.c"
Import "src/rotateorth.c"
Import "src/rotateorthlow.c"
Import "src/rotateshear.c"
Import "src/runlength.c"
Import "src/sarray.c"
Import "src/scale.c"
Import "src/scalelow.c"
Import "src/seedfill.c"
Import "src/seedfilllow.c"
Import "src/sel1.c"
Import "src/sel2.c"
Import "src/selgen.c"
Import "src/shear.c"
Import "src/skew.c"
Import "src/spixio.c"
Import "src/stack.c"
Import "src/textops.c"
Import "src/tiffiostub.c"
Import "src/utils.c"
Import "src/viewfiles.c"
Import "src/warper.c"
Import "src/watershed.c"
Import "src/webpiostub.c"
Import "src/writefile.c"
Import "src/zlibmem.c"
Import "src/zlibmemstub.c"

Import "*.h"
Import "glue.cpp"

