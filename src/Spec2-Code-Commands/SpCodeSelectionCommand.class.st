"
I'm a code presenter command who's actions depends on the selected text.
In case no text is selected, the commands will take the text from cursor position to begining of line as an ""ad hoc"" selection.

""context"" needs to conform a certain api to be used here: 

- selectedText
- selectedTextOrLine
- doItReceiver
- doItContext
"
Class {
	#name : 'SpCodeSelectionCommand',
	#superclass : 'SpToolCommand',
	#category : 'Spec2-Code-Commands-Base',
	#package : 'Spec2-Code-Commands',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpCodeSelectionCommand class >> allOrdered [

	^ self allSubclasses sorted: #order ascending
]

{ #category : 'documentation' }
SpCodeSelectionCommand class >> documentContextRequiredSelectors [

	^ super documentContextRequiredSelectors, #(selectedTextOrLine)
]

{ #category : 'accessing' }
SpCodeSelectionCommand class >> order [
	"At last by default"
	^ 999
]

{ #category : 'converting' }
SpCodeSelectionCommand >> asSpecCommand [

	^ SpToolCurrentApplicationCommand decorate: super asSpecCommand
]

{ #category : 'private' }
SpCodeSelectionCommand >> compile: aStream for: anObject in: evalContext [

	| methodClass |
	methodClass := evalContext
		               ifNil: [ anObject class ]
		               ifNotNil: [ evalContext methodClass ].

	^ context class compiler
		  source: aStream;
		  class: methodClass;
		  context: evalContext;
		  requestor: context; "it should enable a visibility of current tool variables in new debugger"
		  isScripting: true;
		  failBlock: [ ^ nil ];
		  compile
]

{ #category : 'private' }
SpCodeSelectionCommand >> evaluate: aString andDo: aBlock [
	"Treat the current selection as an expression; evaluate it and invoke 
	 aBlock with the result."

	aBlock value: (self context 
		evaluate: aString
		onCompileError: [ ^ self ]
		onError: [ :e | e pass ]).
]

{ #category : 'private' }
SpCodeSelectionCommand >> evaluateSelectionAndDo: aBlock [
	"Treat the current selection as an expression; evaluate it and invoke aBlock with the result.
	If no selection is present select the current line."
	| selection |
	
	selection := self selectedTextOrLine.
	selection ifEmpty: [ ^ '' ].
	
	^ self 
		evaluate: selection 
		andDo: aBlock
]

{ #category : 'accessing' }
SpCodeSelectionCommand >> selectedTextOrLine [

	^ self context selectedTextOrLine
]
