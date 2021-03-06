' Copyright (c) 2008-2019 Bruce A Henderson
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

Rem
bbdoc: Mathematical expressions parser.
End Rem
Module BaH.muParser

ModuleInfo "Version: 1.04"
ModuleInfo "License: MIT"
ModuleInfo "Copyright: Wrapper - 2008-2019 Bruce A Henderson"
ModuleInfo "Copyright: muParser - 2004-2013 Ingo Berg"

ModuleInfo "History: 1.04"
ModuleInfo "History: Updated to muParser 2.2.6.96e64b2"
ModuleInfo "History: 1.03"
ModuleInfo "History: Updated for NG."
ModuleInfo "History: 1.02"
ModuleInfo "History: Added -fpermissive for Mac build."
ModuleInfo "History: 1.01"
ModuleInfo "History: Updated to muParser 2.2.3."
ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release (muparser 1.30 svn 20081110)"

ModuleInfo "CC_OPTS: -fexceptions -DMUPARSER_STATIC"' -D_UNICODE"
?macos
ModuleInfo "CC_OPTS: -fpermissive"
?

Import "common.bmx"

'
' Notes :
'
' Modified muParser.cpp
'   Added Degree/Radian conversions for trig functions.
'   Changed constant _pi to pi.
'
' muParserBytecode.h
'   Defined m_iMaxStackSize as std::size_t.
'

Rem
bbdoc: Mathematical expressions parser.
about: Standard implementation of the mathematical expressions parser.
End Rem
Type TmuParser Extends TmuParserBase

	Method New()
		parserPtr = bmx_muparser_parser_new()
	End Method

	Method Delete()
		If parserPtr Then
			bmx_muparser_parser_delete(parserPtr)
			parserPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: Mathematical expressions parser. (base engine)
about: This is the implementation of a bytecode based mathematical expressions parser. The formula will be parsed
from string and converted into a bytecode. Future calculations will be done with the bytecode instead the formula
string resulting in a significant performance increase. Complementary to a set of internally implemented functions
the parser is able to handle user defined functions and variables.
End Rem
Type TmuParserBase

	Field parserPtr:Byte Ptr
	
	Field varFactoryCallback:Double Ptr(name:String, userData:Object)
	Field vfUserData:Object

	Rem
	bbdoc: Calculates the result.
	End Rem
	Method Eval:Double()
		Return bmx_muparser_parserbase_eval(parserPtr)
	End Method

	Rem
	bbdoc: Sets the formula.
	about: Triggers first time calculation thus the creation of the bytecode and scanning of used variables.
	End Rem
	Method SetExpr(expr:String)
		bmx_muparser_parserbase_setexpr(parserPtr, expr)
	End Method
	
	Rem
	bbdoc: Adds a user defined variable.
	End Rem
	Method DefineVar(name:String, value:Double Var)
		bmx_muparser_parserbase_definevar(parserPtr, name, Varptr value)
	End Method
	
	Rem
	bbdoc: Adds a user defined constant.
	End Rem
	Method DefineConst(name:String, value:Double)
		bmx_muparser_parserbase_defineconst(parserPtr, name, value)
	End Method
	
	Rem
	bbdoc: Defines a new string constant.
	End Rem
	Method DefineStrConst(name:String, value:String)
		bmx_muparser_parserbase_definestrconst(parserPtr, name, value)
	End Method
	
	Rem
	bbdoc: Removes a variable from internal storage.
	about: Removes a variable if it exists. If the Variable does not exist nothing will be done.
	End Rem
	Method RemoveVar(name:String)
		bmx_muparser_parserbase_removevar(parserPtr, name)
	End Method

	Rem
	bbdoc: Enables or disables the formula optimization feature.
	End Rem
	Method EnableOptimizer(isOn:Int = True)
		bmx_muparser_parserbase_enableoptimizer(parserPtr, isOn)
	End Method
	
	Rem
	bbdoc: Enables or disables the built in binary operators.
	about: If you disable the built in binary operators there will be no binary operators defined. Thus you
	must add them manually one by one. It is not possible to disable built in operators selectively. This
	method will Reinitialize the parser by calling ReInit().
	End Rem
	Method EnableBuiltInOprt(isOn:Int = True)
		bmx_muparser_parserbase_enablebuiltintoprt(parserPtr, isOn)
	End Method
	
	Rem
	bbdoc: Queries status of built in variables.
	End Rem
	Method HasBuiltInOprt:Int()
		Return bmx_muparser_parserbase_hasbuiltinoprt(parserPtr)
	End Method
	
	Rem
	bbdoc: Clears all user defined variables.
	End Rem
	Method ClearVar()
		bmx_muparser_parserbase_clearvar(parserPtr)
	End Method

	Rem
	bbdoc: Clears all functions.
	End Rem
	Method ClearFun()
		bmx_muparser_parserbase_clearfun(parserPtr)
	End Method

	Rem
	bbdoc: Clears all user defined constants.
	about: Both numeric and string constants will be removed from the internal storage.
	End Rem
	Method ClearConst()
		bmx_muparser_parserbase_clearconst(parserPtr)
	End Method

	Rem
	bbdoc: Clears the user defined Prefix operators.
	End Rem
	Method ClearInfixOprt()
		bmx_muparser_parserbase_clearinfixoprt(parserPtr)
	End Method

	Rem
	bbdoc: Clears all user defined postfix operators.
	End Rem
	Method ClearPostfixOprt()
		bmx_muparser_parserbase_clearpostfixoprt(parserPtr)
	End Method

	Rem
	bbdoc: Clears all user defined binary operators.
	End Rem
	Method ClearOprt()
		bmx_muparser_parserbase_clearoprt(parserPtr)
	End Method

	Rem
	bbdoc: Defines a parser function without arguments.
	End Rem
	Method DefineFun0(name:String, callback:Double(), allowOpt:Int = True)
		bmx_muparser_parserbase_definefun0(parserPtr, name, callback, allowOpt)
	End Method
	
	Rem
	bbdoc: Defines a parser function with 1 argument.
	End Rem
	Method DefineFun1(name:String, callback:Double(val:Double), allowOpt:Int = True)
		bmx_muparser_parserbase_definefun1(parserPtr, name, callback, allowOpt)
	End Method
	
	Rem
	bbdoc: Defines a parser function with 2 arguments.
	End Rem
	Method DefineFun2(name:String, callback:Double(val1:Double, val2:Double), allowOpt:Int = True)
		bmx_muparser_parserbase_definefun2(parserPtr, name, callback, allowOpt)
	End Method
	
	Rem
	bbdoc: Defines a parser function with 3 arguments.
	End Rem
	Method DefineFun3(name:String, callback:Double(val1:Double, val2:Double, val3:Double), allowOpt:Int = True)
		bmx_muparser_parserbase_definefun3(parserPtr, name, callback, allowOpt)
	End Method
	
	Rem
	bbdoc: Defines a parser function with 4 arguments.
	End Rem
	Method DefineFun4(name:String, callback:Double(val1:Double, val2:Double, val3:Double, val4:Double), allowOpt:Int = True)
		bmx_muparser_parserbase_definefun4(parserPtr, name, callback, allowOpt)
	End Method
	
	Rem
	bbdoc: Defines a parser function with 5 arguments.
	End Rem
	Method DefineFun5(name:String, callback:Double(val1:Double, val2:Double, val3:Double, val4:Double, val5:Double), allowOpt:Int = True)
		bmx_muparser_parserbase_definefun5(parserPtr, name, callback, allowOpt)
	End Method

	Rem
	bbdoc: Defines a parser function with variable argument list.
	End Rem
	Method DefineMultFun(name:String, callback:Double(val:Double Ptr, size:Int), allowOpt:Int = True)
		bmx_muparser_parserbase_definemultfun(parserPtr, name, callback, allowOpt)
	End Method
	
	Rem
	bbdoc: Defines a binary operator.
	about: Binary operators can be defined in order to supplement or replace the built in binary operators they
	require an additional parameter, the operator priority.
	End Rem
	Method DefineOprt(name:String, callback:Double(val1:Double, val2:Double), priority:Int = 0, associativity:Int = oaLEFT, allowOpt:Int = False)
		bmx_muparser_parserbase_defineoprt(parserPtr, name, callback, priority, associativity, allowOpt)
	End Method

	Rem
	bbdoc: Adds a user defined operator.
	about: Postfix operators are operators that succeed values. For instance the factorial operator (a! = a*(a-1)...*2*1).
	Another application for postfix operators is their use as multipliers that can be used for implementing units.
	End Rem
	Method DefinePostfixOprt(name:String, callback:Double(val:Double), allowOpt:Int = False)
		bmx_muparser_parserbase_definepostfixoprt(parserPtr, name, callback, allowOpt)
	End Method

	Rem
	bbdoc: Adds a user defined operator.
	about: Infix operators are operators like the unary minus which serves as a sign or the logical not "!(a&lt;9)".
	End Rem
	Method DefineInfixOprt(name:String, callback:Double(val:Double), precidence:Int = prINFIX, allowOpt:Int = False)
		bmx_muparser_parserbase_defineinfixoprt(parserPtr, name, callback, precidence, allowOpt)
	End Method
	
	Rem
	bbdoc: Sets a function that can create a variable pointer for unknown expression variables.
	End Rem
	Method SetVarFactory(callback:Double Ptr(name:String, userData:Object), userData:Object)
		varFactoryCallback = callback
		vfUserData = userData
		bmx_muparser_parserbase_setvarfactory(parserPtr, _vfCallback, Self)
	End Method
	
	Function _vfCallback:Double Ptr(name:Byte Ptr, userData:Object) { nomangle }
		Return TmuParserBase(userData).varFactoryCallback(String.FromCString(name), TmuParserBase(userData).vfUserData)
	End Function
	
	Rem
	bbdoc: Returns an array of all variables.
	End Rem
	Method GetVar:TmuParserVariable[]()
		Return bmx_muparser_parserbase_getvar(parserPtr)
	End Method

	Rem
	bbdoc: Returns an array of only used variables.
	End Rem
	Method GetUsedVar:TmuParserVariable[]()
		Return bmx_muparser_parserbase_getusedvar(parserPtr)
	End Method
	
	Function _newVarArray:TmuParserVariable[](size:Int) { nomangle }
		Return New TmuParserVariable[size]
	End Function
	
	Function _setVarArray(vars:TmuParserVariable[], index:Int, name:String, variable:Double Ptr) { nomangle }
		vars[index] = TmuParserVariable._create(name, variable)
	End Function

	Rem
	bbdoc: Returns an array of all constants.
	End Rem
	Method GetConst:TmuParserConstant[]()
		Return bmx_muparser_parserbase_getconst(parserPtr)
	End Method

	Function _newConstArray:TmuParserConstant[](size:Int) { nomangle }
		Return New TmuParserConstant[size]
	End Function
	
	Function _setConstArray(consts:TmuParserConstant[], index:Int, name:String, value:Double) { nomangle }
		consts[index] = TmuParserConstant._create(name, value)
	End Function

End Type

Extern
	Function bmx_muparser_parserbase_getvar:TmuParserVariable[](handle:Byte Ptr)
	Function bmx_muparser_parserbase_getusedvar:TmuParserVariable[](handle:Byte Ptr)
	Function bmx_muparser_parserbase_getconst:TmuParserConstant[](handle:Byte Ptr)
End Extern

Rem
bbdoc: A variable, as returned by GetVar() and GetUsedVar().
End Rem
Type TmuParserVariable

	Rem
	bbdoc: The variable name.
	End Rem
	Field name:String
	Rem
	bbdoc: The variable address
	about: Retrieve the current value with variable[0].
	End Rem
	Field variable:Double Ptr
	
	Function _create:TmuParserVariable(name:String, variable:Double Ptr)
		Local this:TmuParserVariable = New TmuParserVariable
		this.name = name
		this.variable = variable
		Return this
	End Function

End Type

Rem
bbdoc: A constant, as returned by GetConst()
End Rem
Type TmuParserConstant

	Rem
	bbdoc: The constant name.
	End Rem
	Field name:String
	Rem
	bbdoc: The constant value
	End Rem
	Field value:Double
	
	Function _create:TmuParserConstant(name:String, value:Double)
		Local this:TmuParserConstant = New TmuParserConstant
		this.name = name
		this.value = value
		Return this
	End Function

End Type

Rem
bbdoc: A parser exception
End Rem
Type TmuParserException Extends TRuntimeException

	Rem
	bbdoc: The error code.
	End Rem
	Field errorCode:Int
	Rem
	bbdoc: The message string for this error. 
	End Rem
	Field message:String
	Rem
	bbdoc: The expression related tp this error. 
	End Rem
	Field expression:String
	Rem
	bbdoc: The formula position related to the error.
	End Rem
	Field pos:Int
	
	Function _create:TmuParserException(errorCode:Int, message:String, expression:String, pos:Int) { nomangle }
		Local this:TmuParserException = New TmuParserException
		this.errorCode = errorCode
		this.message = message
		this.expression = expression
		this.pos = pos
		Return this
	End Function

End Type


