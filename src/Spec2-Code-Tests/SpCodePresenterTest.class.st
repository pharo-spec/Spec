Class {
	#name : #SpCodePresenterTest,
	#superclass : #SpTextPresenterTest,
	#category : #'Spec2-Code-Tests'
}

{ #category : #running }
SpCodePresenterTest >> classToTest [

	^ SpCodePresenter
]

{ #category : #testing }
SpCodePresenterTest >> expectedFailures [

	"This test do not pass on CI because headless image has display size = 0@0 and then 
	 morphic behaves weird. PropagateNaturalHeight/Width is weak on Morphic because of 
	 this (if not, see the algoritm I was forced to do), but for now passes (just, not on CI :)"
	Smalltalk isHeadless ifTrue: [ ^ #() ].

	"This test will not work on SpCodePresenter because it uses a monospaced font (and this 
	 fails in morphic)"
	^ #(testPropagateNaturalWidth)
]

{ #category : #tests }
SpCodePresenterTest >> testContextKeyBindings [
	| contextKeyBindings |
	
	contextKeyBindings := presenter contextKeyBindings.
	self assert: contextKeyBindings notNil.
	self assert: (contextKeyBindings isKindOf: KMCategory).
	
]

{ #category : #tests }
SpCodePresenterTest >> testContextMenu [
	| menu changed |
	
	self assert: presenter contextMenu isNotNil. "The code presenter comes with a menu by default"
	menu := SpMenuPresenter new.
	changed := false.
	presenter whenMenuChangedDo: [ 
		changed := true. ].
	presenter contextMenu: menu.
	self assert: changed
]

{ #category : #tests }
SpCodePresenterTest >> testEvaluateOnCompileErrorOnError [

	self 
		assert: (presenter evaluate: 'Obj { }}' onCompileError: [ #compile ] onError: [ :e | #error ])
		equals: #compile.
		
	self 
		assert: (presenter evaluate: 'nil text' onCompileError: [ #compile ] onError: [ :e | #error ])
		equals: #error.	
		
	self 
		assert: (presenter evaluate: '42' onCompileError: [ #compile ] onError: [ :e | #error ])
		equals: 42.		
]

{ #category : #tests }
SpCodePresenterTest >> testFindClassFrom [

	self assert: (presenter findClassFrom: '') equals: nil.
	self assert: (presenter findClassFrom: 'Object') equals: Object.
	self assert: (presenter findClassFrom: 'Object.') equals: Object.
	self assert: (presenter findClassFrom: '.Object.') equals: Object.
	self
		assert: (presenter findClassFrom: 'somethingBefore := 42.Object')
		equals: Object.
	self
		assert:
			(presenter
				findClassFrom: 'somethingBefore := 42.Object. somethingAfter := 11')
		equals: Object.
	self
		assert: (presenter findClassFrom: 'NonExistingClass.Object.')
		equals: Object
]

{ #category : #tests }
SpCodePresenterTest >> testSelectedSelector [

	"Testing border cases to avoid breaking execution. The selector extraction logic should be tested in the extractor class"

	"Code presenter has nil text for some reason"

	| selector |
	presenter text: nil.
	selector := presenter selectedSelector.
	self assert: selector isNil.

	"Code presenter is empty"
	presenter text: ''.
	selector := presenter selectedSelector.
	self assert: selector isNil.

	"Code has valid code"
	selector := presenter text: 'anObject do: 1 with: 2'.
	selector := presenter selectedSelector.
	self assert: selector equals: #do:with:.

	"Code has faulty code"
	selector := presenter text: 'anObject do : 1 with: 2'.
	selector := presenter selectedSelector.
	self assert: selector equals: #do.

	"Code has invalid code (no selectors at all)"
	selector := presenter text: 'anObjectdo : 2'.
	selector := presenter selectedSelector.
	self assert: selector equals: #noMethod
]

{ #category : #tests }
SpCodePresenterTest >> testSelectedSelectorWithPointerAtEnd [
	"Testing border cases to avoid breaking execution. The selector extraction logic should be tested in the extractor class"
	| selector string |

	self openInstance.

	"end of text with several posibilities"
	string := 'Smalltalk allClassesAndTraits reject: #hasComment'.
	presenter text: string.
	"move cursor to end"
	presenter cursorPositionIndex: string size + 1.
	"ensure there is no selection"
	presenter clearSelection.
	"for some reason, clear selection also moved the pointer back to first position. 
	 IMO trhat should not happen, but seems to be a rubric problem. I hacke the selection by 
	 respecting the position wiyh next line."
	presenter selectionInterval: ((string size + 1) to: string size).
	selector := presenter selectedSelector.
	self assert: selector equals: #hasComment.

	"end of text with several lines"	
	string := '42 factorial.
Smalltalk allClassesAndTraits reject: #hasComment'.
	presenter text: string.
	"move cursor to end"
	presenter cursorPositionIndex: string size + 1.
	"ensure there is no selection"
	"ensure there is no selection"
	presenter clearSelection.
	presenter selectionInterval: ((string size + 1) to: string size).
	selector := presenter selectedSelector.
	self assert: selector equals: #hasComment
]

{ #category : #tests }
SpCodePresenterTest >> testWhenSyntaxHighlightChangedDo [
	| count result |
	count := 0.
	result := true.
	presenter
		whenSyntaxHighlightChangedDo: [ :syntaxHighlight | 
			count := count + 1.
			result := syntaxHighlight ].
	presenter withoutSyntaxHighlight.
	self assert: count equals: 1.
	self deny: result
]
