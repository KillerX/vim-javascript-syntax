" Vim syntax file
"      Language: Demandware Script
"    Maintainer: Matjaz Debelak <https://github.com/KillerX>
"       Version: 0.0.1
"       Changes: Go to https://github.com/KillerX/vim-javascript-syntax for
"                recent changes.
"       Credits: Zhao Yi, Claudio Fleiner, Scott Shattuck (This file is based
"                on their hard work), gumnos (From the #vim IRC Channel in
"                Freenode), https://github.com/jelera/vim-javascript-syntax

if !exists("main_syntax")
	if version < 600
		syntax clear
	elseif exists("b:current_syntax")
		finish
	endif
	let main_syntax = 'dwscript'
endif

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("dwScript_fold")
	unlet dwScript_fold
endif

"" Remove dollar sign from identifier when embedded in a PHP file
if &filetype == 'dwscript'
	setlocal iskeyword+=$
endif

syntax sync fromstart

"" syntax coloring for Node.js shebang line
syntax match shebang "^#!.*"
hi link shebang Comment

" Statement Keywords {{{
syntax keyword dwScriptSource         import export ImportPackage ImportScript
syntax keyword dwScriptIdentifier     arguments this let var void yield
syntax keyword dwScriptOperator       delete new instanceof typeof
syntax keyword dwScriptBoolean        true false
syntax keyword dwScriptNull           null undefined String Number Boolean Array List
syntax keyword dwScriptMessage        alert confirm prompt status
syntax keyword dwScriptGlobal         self top parent
syntax keyword dwScriptDeprecated     escape unescape all applets alinkColor bgColor fgColor linkColor vlinkColor xmlEncoding
syntax keyword dwScriptConditional    if else switch
syntax keyword dwScriptRepeat         do while for in
syntax keyword dwScriptBranch         break continue
syntax keyword dwScriptLabel          case default
syntax keyword dwScriptPrototype      prototype
syntax keyword dwScriptStatement      return with
syntax keyword dwScriptGlobalObjects  Date Function Math RegExp
syntax keyword dwScriptExceptions     try catch throw finally Error EvalError RangeError ReferenceError SyntaxError TypeError URIError
syntax keyword dwScriptReserved       abstract enum int short boolean export interface static byte extends long super char final native synchronized class float package throws const goto private transient debugger implements protected volatile double import public
"}}}
" Comments {{{
syntax keyword dwScriptCommentTodo      TODO FIXME XXX TBD contained
syntax match   dwScriptCommentTodo      "\(@input\|@output\)" contained containedin=dwScriptComment
syntax match   dwScriptLineComment      "\/\/.*" contains=@Spell,dwScriptCommentTodo,dwScriptCommentParam
syntax match   dwScriptCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syntax region  dwScriptComment          start="/\*"  end="\*/" contains=@Spell,dwScriptCommentTodo,dwScriptCommentParam
"}}}

"contained containedin=dwscriptVarGroup

syntax case match
"}}}
" Strings, Numbers and Regex Highlight {{{
syntax match   dwScriptSpecial          "\\\d\d\d\|\\."
syntax region  dwScriptString	          start=+"+  skip=+\\\\\|\\"+  end=+"\|$+	contains=dwScriptSpecial,@htmlPreproc
syntax region  dwScriptString	          start=+'+  skip=+\\\\\|\\'+  end=+'\|$+	contains=dwScriptSpecial,@htmlPreproc

syntax match   dwScriptSpecialCharacter "'\\.'"
syntax match   dwScriptNumber           "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syntax region  dwScriptRegexpString     start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gim]\{0,2\}\s*$+ end=+/[gim]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline
syntax match   dwScriptFloat          /\<-\=\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%([eE][+-]\=\d\+\)\=\>/
"}}}
"
syntax keyword dwScriptPropietaryObjects        session request customer pdict
syntax keyword dwScriptDomNodeConsts PIPELET_ERROR PIPELET_NEXT 

" Code blocks"{{{
syntax cluster dwScriptAll       contains=dwScriptComment,dwScriptLineComment,dwScriptString,dwScriptRegexpString,dwScriptNumber,dwScriptFloat,dwScriptLabel,dwScriptSource,dwScriptOperator,dwScriptBoolean,dwScriptNull,dwScriptFuncKeyword,dwScriptConditional,dwScriptGlobal,dwScriptRepeat,dwScriptBranch,dwScriptStatement,dwScriptGlobalObjects,dwScriptMessage,dwScriptIdentifier,dwScriptExceptions,dwScriptReserved,dwScriptDeprecated,dwScriptDomNodeConsts,dwScriptHtmlEvents,dwScriptDotNotation,dwScriptPropietaryObjects,dwScriptEventListenerMethods,dwScriptFuncArg

if main_syntax == "dwscript"
	syntax sync clear
	syntax sync ccomment dwScriptComment minlines=200
endif
"}}}
syntax match   dwScriptColon           ":"
" Function and arguments highlighting {{{
syntax keyword dwScriptFuncKeyword     function contained
syntax region  dwScriptFuncExp         start=/\w\+\s\==\s\=function\>/ end="\([^)]*\)" contains=dwScriptFuncEq,dwScriptFuncKeyword,dwScriptFuncArg keepend
syntax match   dwScriptFuncArg         "\(([^()]*)\)" contains=dwScriptParens,dwScriptFuncComma contained
syntax match   dwScriptColon           ":" contained containedin=dwScriptFuncArg
syntax match   dwScriptFunctType       ": \zs\([^ :=,]\+\)\ze" contained containedin=dwScriptFuncDef,dwScriptFuncArg
syntax match   dwScriptFuncComma       /,/ contained
syntax match   dwScriptFuncEq          /=/ contained
syntax region  dwScriptFuncDef         start="\<function\>" end="\([^)]*\)" contains=dwScriptFuncKeyword,dwScriptFuncArg keepend
"}}}
" Braces, Parens, symbols, colons {{{
syntax match dwScriptBraces       "[{}\[\]]"
syntax match dwScriptParens       "[()]"
syntax match dwScriptOpSymbols    "=\{1,3}\|!==\|!=\|<\|>\|>=\|<=\|++\|+=\|--\|-="
syntax match dwScriptEndColons    "[;,]"
syntax match dwScriptLogicSymbols "\(&&\)\|\(||\)"
"}}}
" JavaScriptFold Function {{{

function! DWScriptFold()
	setl foldmethod=syntax
	setl foldlevelstart=1
	syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend
endfunction

syntax match   dwScriptType             ": \?[^ :=?'\";()\[\]]\+" 
syntax match   dwScriptColon            ":" contained containedin=dwScriptType

" }}}
" Highlight links {{{
" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_javascript_syn_inits")
	if version < 508
		let did_javascript_syn_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi def link <args>
	endif
	HiLink dwScriptEndColons              Operator
	HiLink dwScriptOpSymbols              Operator
	HiLink dwScriptLogicSymbols           Boolean
	HiLink dwScriptBraces                 Function
	HiLink dwScriptColon                  Operator
	HiLink dwScriptParens                 Operator

	HiLink dwScriptComment                Comment
	HiLink dwScriptLineComment            Comment
	HiLink dwScriptCommentTodo            Todo

	HiLink dwScriptCommentParam			  Todo 
	HiLink dwScriptDocTags                Special
	HiLink dwScriptDocSeeTag              Function
	HiLink dwScriptDocParam               Function

	HiLink dwScriptString                 String
	HiLink dwScriptRegexpString           String

	HiLink dwScriptNumber                 Number
	HiLink dwScriptFloat                  Number

	HiLink dwScriptGlobal                 Constant
	HiLink dwScriptCharacter              Character
	HiLink dwScriptPrototype              Type
	HiLink dwScriptConditional            Conditional
	HiLink dwScriptBranch                 Conditional
	HiLink dwScriptIdentifier             Identifier
	HiLink dwScriptRepeat                 Repeat
	HiLink dwScriptStatement              Statement
	HiLink dwScriptMessage                Keyword
	HiLink dwScriptReserved               Keyword
	HiLink dwScriptOperator               Operator
	HiLink dwScriptNull                   Type
	HiLink dwScriptBoolean                Boolean
	HiLink dwScriptLabel                  Label
	HiLink dwScriptSpecial                Special
	HiLink dwScriptSource                 Special
	HiLink dwScriptGlobalObjects          Special
	HiLink dwScriptExceptions             Special

	HiLink dwScriptDeprecated             Exception

	HiLink dwScriptDomNodeConsts          Constant

	
	HiLink dwScriptFuncKeyword            Function
	HiLink dwScriptFuncDef                PreProc
	HiLink dwScriptFuncExp                Title
	HiLink dwScriptFuncArg               	Special
	HiLink dwScriptFunctType              Type
	HiLink dwScriptFuncComma              Operator
	HiLink dwScriptFuncEq                 Operator

	HiLink dwScriptHtmlEvents             Constant

	HiLink dwScriptPropietaryObjects      Constant

	HiLink dwScriptType                   Type

	delcommand HiLink
endif
" end Highlight links }}}

" Define the htmlJavaScript for HTML syntax html.vim
"syntax clear htmlJavaScript
"syntax clear javaScriptExpression
syntax cluster  dwScriptExpression contains=@dwScriptAll,dwScriptBracket,dwScriptParen,dwScriptBlock,dwScriptParenError,@htmlPreproc

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
	unlet main_syntax
endif
syntax region jsInJsdocExample matchgroup=Snip start="^\s*\* @example" end="\(^\s*\* [^[:space:]]\)\@=" containedin=@dwScriptComment contains=@dwScriptAll
hi link Snip SpecialComment

