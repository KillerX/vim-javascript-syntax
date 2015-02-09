" Vim syntax file
"      Language: Demandware Script
"    Maintainer: Matjaz Debelak <https://github.com/KillerX>
" Last Modified: Mon 09 Feb 2013 22:39:46 PM CST
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
syntax match   dwScriptLineComment      "\/\/.*" contains=@Spell,dwScriptCommentTodo
syntax match   dwScriptCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syntax region  dwScriptComment          start="/\*"  end="\*/" contains=@Spell,dwScriptCommentTodo
"}}}

syntax match   dwScriptType             ": \?\zs[^ :=]\+\ze \?=" 
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
"  DOM, Browser and Ajax Support   {{{
syntax keyword dwScriptBrowserObjects           window navigator screen history location

syntax keyword dwScriptDOMObjects               document event HTMLElement Anchor Area Base Body Button Form Frame Frameset Image Link Meta Option Select Style Table TableCell TableRow Textarea
syntax keyword dwScriptDOMMethods               createTextNode createElement insertBefore replaceChild removeChild appendChild  hasChildNodes  cloneNode  normalize  isSupported  hasAttributes  getAttribute  setAttribute  removeAttribute  getAttributeNode  setAttributeNode  removeAttributeNode  getElementsByTagName  hasAttribute  getElementById adoptNode close compareDocumentPosition createAttribute createCDATASection createComment createDocumentFragment createElementNS createEvent createExpression createNSResolver createProcessingInstruction createRange createTreeWalker elementFromPoint evaluate getBoxObjectFor getElementsByClassName getSelection getUserData hasFocus importNode
syntax keyword dwScriptDOMProperties            nodeName  nodeValue  nodeType  parentNode  childNodes  firstChild  lastChild  previousSibling  nextSibling  attributes  ownerDocument  namespaceURI  prefix  localName  tagName

syntax keyword dwScriptAjaxObjects              XMLHttpRequest
syntax keyword dwScriptAjaxProperties           readyState responseText responseXML statusText
syntax keyword dwScriptAjaxMethods              onreadystatechange abort getAllResponseHeaders getResponseHeader open send setRequestHeader

syntax keyword dwScriptPropietaryObjects        ActiveXObject
syntax keyword dwScriptPropietaryMethods        attachEvent detachEvent cancelBubble returnValue

syntax keyword dwScriptHtmlElemProperties       className  clientHeight  clientLeft  clientTop  clientWidth  dir  href  id  innerHTML  lang  length  offsetHeight  offsetLeft  offsetParent  offsetTop  offsetWidth  scrollHeight  scrollLeft  scrollTop  scrollWidth  style  tabIndex  target  title

syntax keyword dwScriptEventListenerKeywords    blur click focus mouseover mouseout load item

syntax keyword dwScriptEventListenerMethods     scrollIntoView  addEventListener  dispatchEvent  removeEventListener preventDefault stopPropagation
" }}}
" DOM/HTML5/CSS specified things {{{
	" Web API Interfaces (very long list of keywords) {{{
	syntax keyword dwScriptWebAPI  AbstractWorker AnalyserNode AnimationEvent App Apps ArrayBuffer ArrayBufferView Attr AudioBuffer AudioBufferSourceNode AudioContext AudioDestinationNode AudioListener AudioNode AudioParam AudioProcessingEvent BatteryManager BiquadFilterNode Blob BlobBuilder BlobEvent CallEvent CameraCapabilities CameraControl CameraManager CanvasGradient CanvasImageSource CanvasPattern CanvasPixelArray CanvasRenderingContext2D CaretPosition CDATASection ChannelMergerNode ChannelSplitterNode CharacterData ChildNode ChromeWorker ClipboardEvent CloseEvent Comment CompositionEvent Connection Console ContactManager ConvolverNode Coordinates CSS CSSConditionRule CSSGroupingRule CSSKeyframeRule CSSKeyframesRule CSSMediaRule CSSNamespaceRule CSSPageRule CSSRule CSSRuleList CSSStyleDeclaration CSSStyleRule CSSStyleSheet CSSSupportsRule CustomEvent
	syntax keyword dwScriptWebAPI  DataTransfer DataView DedicatedWorkerGlobalScope DelayNode DeviceAcceleration DeviceLightEvent DeviceMotionEvent DeviceOrientationEvent DeviceProximityEvent DeviceRotationRate DeviceStorage DeviceStorageChangeEvent DirectoryEntry DirectoryEntrySync DirectoryReader DirectoryReaderSync Document DocumentFragment DocumentTouch DocumentType DOMConfiguration DOMCursor DOMError DOMErrorHandler DOMException DOMHighResTimeStamp DOMImplementation DOMImplementationList DOMImplementationSource DOMLocator DOMObject DOMParser DOMRequest DOMString DOMStringList DOMStringMap DOMTimeStamp DOMTokenList DOMUserData DynamicsCompressorNode
	syntax keyword dwScriptWebAPI  Element ElementTraversal Entity EntityReference Entry EntrySync ErrorEvent Event EventListener EventSource EventTarget Extensions File FileEntry FileEntrySync FileError FileException FileList FileReader FileSystem FileSystemSync Float32Array Float64Array FMRadio FocusEvent FormData GainNode Geolocation History
	syntax keyword dwScriptWebAPI  HTMLAnchorElement HTMLAreaElement HTMLAudioElement HTMLBaseElement HTMLBaseFontElement HTMLBodyElement HTMLBRElement HTMLButtonElement HTMLCanvasElement HTMLCollection HTMLDataElement HTMLDataListElement HTMLDivElement HTMLDListElement HTMLDocument HTMLElement HTMLEmbedElement HTMLFieldSetElement HTMLFormControlsCollection HTMLFormElement HTMLHeadElement HTMLHeadingElement HTMLHRElement HTMLHtmlElement HTMLIFrameElement HTMLImageElement HTMLInputElement HTMLIsIndexElement HTMLKeygenElement HTMLLabelElement HTMLLegendElement HTMLLIElement HTMLLinkElement HTMLMapElement HTMLMediaElement HTMLMetaElement HTMLMeterElement HTMLModElement HTMLObjectElement HTMLOListElement HTMLOptGroupElement HTMLOptionElement HTMLOptionsCollection HTMLOutputElement HTMLParagraphElement HTMLParamElement HTMLPreElement HTMLProgressElement HTMLQuoteElement HTMLScriptElement HTMLSelectElement HTMLSourceElement HTMLSpanElement HTMLStyleElement HTMLTableCaptionElement HTMLTableCellElement HTMLTableColElement HTMLTableElement HTMLTableRowElement HTMLTableSectionElement HTMLTextAreaElement HTMLTimeElement HTMLTitleElement HTMLTrackElement HTMLUListElement HTMLUnknownElement HTMLVideoElement
	syntax keyword dwScriptWebAPI  IDBCursor IDBCursorWithValue IDBDatabase IDBDatabaseException IDBEnvironment IDBFactory IDBIndex IDBKeyRange IDBObjectStore IDBOpenDBRequest IDBRequest IDBTransaction IDBVersionChangeEvent ImageData Int16Array Int32Array Int8Array KeyboardEvent LinkStyle LocalFileSystem LocalFileSystemSync Location MediaQueryList MediaQueryListListener MediaSource MediaStream MediaStreamTrack MessageEvent MouseEvent MouseScrollEvent MouseWheelEvent MozActivity MozActivityOptions MozActivityRequestHandler MozAlarmsManager MozContact MozContactChangeEvent MozIccManager MozMmsEvent MozMmsMessage MozMobileCellInfo MozMobileCFInfo MozMobileConnection MozMobileConnectionInfo MozMobileICCInfo MozMobileMessageManager MozMobileMessageThread MozMobileNetworkInfo MozNetworkStats MozNetworkStatsData MozNetworkStatsManager MozSettingsEvent MozSmsEvent MozSmsFilter MozSmsManager MozSmsMessage MozSmsSegmentInfo MozTimeManager MozWifiConnectionInfoEvent MutationObserver
	syntax keyword dwScriptWebAPI  NamedNodeMap NameList Navigator NavigatorGeolocation NavigatorID NavigatorLanguage NavigatorOnLine NavigatorPlugins NetworkInformation Node NodeFilter NodeIterator NodeList Notation Notification NotifyAudioAvailableEvent OfflineAudioCompletionEvent OfflineAudioContext PannerNode ParentNode Performance PerformanceNavigation PerformanceTiming Plugin PluginArray Position PositionError PositionOptions PowerManager ProcessingInstruction ProgressEvent Promise PromiseResolver PushManager
	syntax keyword dwScriptWebAPI  Range ScriptProcessorNode Selection SettingsLock SettingsManager SharedWorker StyleSheet StyleSheetList SVGAElement SVGAngle SVGAnimateColorElement SVGAnimatedAngle SVGAnimatedBoolean SVGAnimatedEnumeration SVGAnimatedInteger SVGAnimatedLengthList SVGAnimatedNumber SVGAnimatedNumberList SVGAnimatedPoints SVGAnimatedPreserveAspectRatio SVGAnimatedRect SVGAnimatedString SVGAnimatedTransformList SVGAnimateElement SVGAnimateMotionElement SVGAnimateTransformElement SVGAnimationElement SVGCircleElement SVGClipPathElement SVGCursorElement SVGDefsElement SVGDescElement SVGElement SVGEllipseElement SVGFilterElement SVGFontElement SVGFontFaceElement SVGFontFaceFormatElement SVGFontFaceNameElement SVGFontFaceSrcElement SVGFontFaceUriElement
	syntax keyword dwScriptWebAPI  SVGForeignObjectElement SVGGElement SVGGlyphElement SVGGradientElement SVGHKernElement SVGImageElement SVGLength SVGLengthList SVGLinearGradientElement SVGLineElement SVGMaskElement SVGMatrix SVGMissingGlyphElement SVGMPathElement SVGNumber SVGNumberList SVGPathElement SVGPatternElement SVGPolygonElement SVGPolylineElement SVGPreserveAspectRatio SVGRadialGradientElement SVGRect SVGRectElement SVGScriptElement SVGSetElement SVGStopElement SVGStringList SVGStylable SVGStyleElement SVGSVGElement SVGSwitchElement SVGSymbolElement SVGTests SVGTextElement SVGTextPositioningElement SVGTitleElement SVGTransform SVGTransformable SVGTransformList SVGTRefElement SVGTSpanElement SVGUseElement SVGViewElement SVGVKernElement TCPSocket Telephony TelephonyCall Text TextDecoder TextEncoder TextMetrics TimeRanges Touch TouchEvent TouchList Transferable TransitionEvent TreeWalker TypeInfo UIEvent Uint16Array Uint32Array Uint8Array Uint8ClampedArray URL URLUtils URLUtilsReadOnly
	" }}}
	" DOM2 CONSTANT {{{
	syntax keyword dwScriptDomErrNo       INDEX_SIZE_ERR DOMSTRING_SIZE_ERR HIERARCHY_REQUEST_ERR WRONG_DOCUMENT_ERR INVALID_CHARACTER_ERR NO_DATA_ALLOWED_ERR NO_MODIFICATION_ALLOWED_ERR NOT_FOUND_ERR NOT_SUPPORTED_ERR INUSE_ATTRIBUTE_ERR INVALID_STATE_ERR SYNTAX_ERR INVALID_MODIFICATION_ERR NAMESPACE_ERR INVALID_ACCESS_ERR
	syntax keyword dwScriptDomNodeConsts  ELEMENT_NODE ATTRIBUTE_NODE TEXT_NODE CDATA_SECTION_NODE ENTITY_REFERENCE_NODE ENTITY_NODE PROCESSING_INSTRUCTION_NODE COMMENT_NODE DOCUMENT_NODE DOCUMENT_TYPE_NODE DOCUMENT_FRAGMENT_NODE NOTATION_NODE
	"}}}
	" HTML events and internal variables"{{{
	syntax case ignore
	syntax keyword dwScriptHtmlEvents     onblur onclick oncontextmenu ondblclick onfocus onkeydown onkeypress onkeyup onmousedown onmousemove onmouseout onmouseover onmouseup onresize onload onsubmit
	syntax case match
	"}}}

	" Follow stuff should be highligh within a special context
	" While it can't be handled with context depended with Regex based highlight
	" So, turn it off by default
	if exists("javascript_enable_domhtmlcss")
	" DOM2 things {{{
	syntax match dwScriptDomElemAttrs     contained /\%(nodeName\|nodeValue\|nodeType\|parentNode\|childNodes\|firstChild\|lastChild\|previousSibling\|nextSibling\|attributes\|ownerDocument\|namespaceURI\|prefix\|localName\|tagName\)\>/
	syntax match dwScriptDomElemFuncs     contained /\%(insertBefore\|replaceChild\|removeChild\|appendChild\|hasChildNodes\|cloneNode\|normalize\|isSupported\|hasAttributes\|getAttribute\|setAttribute\|removeAttribute\|getAttributeNode\|setAttributeNode\|removeAttributeNode\|getElementsByTagName\|getAttributeNS\|setAttributeNS\|removeAttributeNS\|getAttributeNodeNS\|setAttributeNodeNS\|getElementsByTagNameNS\|hasAttribute\|hasAttributeNS\)\>/ nextgroup=dwScriptParen skipwhite
	"}}}
	" HTML things {{{
	syntax match dwScriptHtmlElemAttrs    contained /\%(className\|clientHeight\|clientLeft\|clientTop\|clientWidth\|dir\|id\|innerHTML\|lang\|length\|offsetHeight\|offsetLeft\|offsetParent\|offsetTop\|offsetWidth\|scrollHeight\|scrollLeft\|scrollTop\|scrollWidth\|style\|tabIndex\|title\)\>/
	syntax match dwScriptHtmlElemFuncs    contained /\%(blur\|click\|focus\|scrollIntoView\|addEventListener\|dispatchEvent\|removeEventListener\|item\)\>/ nextgroup=dwScriptParen skipwhite
	"}}}
	" CSS Styles in JavaScript {{{
	syntax keyword dwScriptCssStyles      contained color font fontFamily fontSize fontSizeAdjust fontStretch fontStyle fontVariant fontWeight letterSpacing lineBreak lineHeight quotes rubyAlign rubyOverhang rubyPosition
	syntax keyword dwScriptCssStyles      contained textAlign textAlignLast textAutospace textDecoration textIndent textJustify textJustifyTrim textKashidaSpace textOverflowW6 textShadow textTransform textUnderlinePosition
	syntax keyword dwScriptCssStyles      contained unicodeBidi whiteSpace wordBreak wordSpacing wordWrap writingMode
	syntax keyword dwScriptCssStyles      contained bottom height left position right top width zIndex
	syntax keyword dwScriptCssStyles      contained border borderBottom borderLeft borderRight borderTop borderBottomColor borderLeftColor borderTopColor borderBottomStyle borderLeftStyle borderRightStyle borderTopStyle borderBottomWidth borderLeftWidth borderRightWidth borderTopWidth borderColor borderStyle borderWidth borderCollapse borderSpacing captionSide emptyCells tableLayout
	syntax keyword dwScriptCssStyles      contained margin marginBottom marginLeft marginRight marginTop outline outlineColor outlineStyle outlineWidth padding paddingBottom paddingLeft paddingRight paddingTop
	syntax keyword dwScriptCssStyles      contained listStyle listStyleImage listStylePosition listStyleType
	syntax keyword dwScriptCssStyles      contained background backgroundAttachment backgroundColor backgroundImage gackgroundPosition backgroundPositionX backgroundPositionY backgroundRepeat
	syntax keyword dwScriptCssStyles      contained clear clip clipBottom clipLeft clipRight clipTop content counterIncrement counterReset cssFloat cursor direction display filter layoutGrid layoutGridChar layoutGridLine layoutGridMode layoutGridType
	syntax keyword dwScriptCssStyles      contained marks maxHeight maxWidth minHeight minWidth opacity MozOpacity overflow overflowX overflowY verticalAlign visibility zoom cssText
	syntax keyword dwScriptCssStyles      contained scrollbar3dLightColor scrollbarArrowColor scrollbarBaseColor scrollbarDarkShadowColor scrollbarFaceColor scrollbarHighlightColor scrollbarShadowColor scrollbarTrackColor
	"}}}
	" Highlight ways {{{
	syntax match dwScriptDotNotation      "\." nextgroup=dwScriptPrototype,dwScriptDomElemAttrs,dwScriptDomElemFuncs,dwScriptHtmlElemAttrs,dwScriptHtmlElemFuncs
	syntax match dwScriptDotNotation      "\.style\." nextgroup=dwScriptCssStyles
	"}}}
	endif
" end DOM/HTML/CSS specified things }}}
" Code blocks"{{{
syntax cluster dwScriptAll       contains=dwScriptComment,dwScriptLineComment,dwScriptDocComment,dwScriptString,dwScriptRegexpString,dwScriptNumber,dwScriptFloat,dwScriptLabel,dwScriptSource,dwScriptWebAPI,dwScriptOperator,dwScriptBoolean,dwScriptNull,dwScriptFuncKeyword,dwScriptConditional,dwScriptGlobal,dwScriptRepeat,dwScriptBranch,dwScriptStatement,dwScriptGlobalObjects,dwScriptMessage,dwScriptIdentifier,dwScriptExceptions,dwScriptReserved,dwScriptDeprecated,dwScriptDomErrNo,dwScriptDomNodeConsts,dwScriptHtmlEvents,dwScriptDotNotation,dwScriptBrowserObjects,dwScriptDOMObjects,dwScriptAjaxObjects,dwScriptPropietaryObjects,dwScriptDOMMethods,dwScriptHtmlElemProperties,dwScriptDOMProperties,dwScriptEventListenerKeywords,dwScriptEventListenerMethods,dwScriptAjaxProperties,dwScriptAjaxMethods,dwScriptFuncArg

if main_syntax == "javascript"
	syntax sync clear
	syntax sync ccomment dwScriptComment minlines=200
	" syntax sync match javaScriptHighlight grouphere javaScriptBlock /{/
endif
"}}}
" Function and arguments highlighting {{{
syntax keyword dwScriptFuncKeyword     function contained
syntax region  dwScriptFuncExp         start=/\w\+\s\==\s\=function\>/ end="\([^)]*\)" contains=dwScriptFuncEq,dwScriptFuncKeyword,dwScriptFuncArg keepend
syntax match   dwScriptFuncArg         "\(([^()]*)\)" contains=dwScriptParens,dwScriptFuncComma contained
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

function! JavaScriptFold()
	setl foldmethod=syntax
	setl foldlevelstart=1
	syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend
endfunction

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
	HiLink dwScriptParens                 Operator

	HiLink dwScriptComment                Comment
	HiLink dwScriptLineComment            Comment
	HiLink dwScriptDocComment             Comment
	HiLink dwScriptCommentTodo            Todo

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
	HiLink dwScriptError                  Error
	HiLink dwScriptParensError            Error
	HiLink dwScriptParensErrA             Error
	HiLink dwScriptParensErrB             Error
	HiLink dwScriptParensErrC             Error
	HiLink dwScriptDomErrNo               Error

	HiLink dwScriptDomNodeConsts          Constant
	HiLink dwScriptDomElemAttrs           Label
	HiLink dwScriptDomElemFuncs           Type

	HiLink dwScriptWebAPI                 Type

	HiLink dwScriptHtmlElemAttrs          Label
	HiLink dwScriptHtmlElemFuncs          Type

	HiLink dwScriptCssStyles              Type

	HiLink dwScriptBrowserObjects         Constant

	HiLink dwScriptDOMObjects             Constant
	HiLink dwScriptDOMMethods             Type
	HiLink dwScriptDOMProperties          Label

	HiLink dwScriptAjaxObjects            Constant
	HiLink dwScriptAjaxMethods            Type
	HiLink dwScriptType                   Type
	HiLink dwScriptAjaxProperties         Label

	HiLink dwScriptFuncKeyword            Function
	HiLink dwScriptFuncDef                PreProc
	HiLink dwScriptFuncExp                Title
	HiLink dwScriptFuncArg               	Special
	HiLink dwScriptFuncComma              Operator
	HiLink dwScriptFuncEq                 Operator

	HiLink dwScriptHtmlEvents             Constant
	HiLink dwScriptHtmlElemProperties     Label

	HiLink dwScriptEventListenerKeywords  Type

	HiLink dwScriptPropietaryObjects      Constant

	delcommand HiLink
endif
" end Highlight links }}}

" Define the htmlJavaScript for HTML syntax html.vim
"syntax clear htmlJavaScript
"syntax clear javaScriptExpression
syntax cluster  htmlJavaScript contains=@dwScriptAll,dwScriptBracket,dwScriptParen,dwScriptBlock,dwScriptParenError
syntax cluster  dwScriptExpression contains=@dwScriptAll,dwScriptBracket,dwScriptParen,dwScriptBlock,dwScriptParenError,@htmlPreproc

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
	unlet main_syntax
endif
syntax region jsInJsdocExample matchgroup=Snip start="^\s*\* @example" end="\(^\s*\* [^[:space:]]\)\@=" containedin=@dwScriptComment contains=@dwScriptAll
hi link Snip SpecialComment

