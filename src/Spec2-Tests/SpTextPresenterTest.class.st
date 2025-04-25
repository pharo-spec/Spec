Class {
	#name : 'SpTextPresenterTest',
	#superclass : 'SpAbstractTextPresenterTest',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'accessing' }
SpTextPresenterTest >> classToTest [
	^ SpTextPresenter
]

{ #category : 'tests' }
SpTextPresenterTest >> testAppendText [

	self openInstance.
	
	self assert: presenter text isEmpty.
	presenter appendText: 'Test'.
	self assert: presenter text equals: 'Test'.
	presenter appendText: 'Final'.
	self assert: presenter text equals: 'TestFinal'	
]

{ #category : 'tests' }
SpTextPresenterTest >> testEditable [

	presenter beNotEditable.
	self openInstance.
	
	presenter adapter 
		keyDown: $x asciiValue
		shift: false 
		meta: false 
		control: false 
		option: false.
	
	self assert: presenter text equals: ''.
	
	presenter beEditable.
	
	presenter adapter 
		keyPressed: $x 
		shift: false 
		meta: false 
		control: false 
		option: false.
	
	self assert: presenter text equals: 'x'.

]

{ #category : 'tests' }
SpTextPresenterTest >> testInsertAt [
	
	self initializationText.
	self openInstance.
	presenter insert: 'insertion ' at: 9.
	self assert: presenter text equals: 'Text for insertion tests.'
]

{ #category : 'tests' }
SpTextPresenterTest >> testPropagateNaturalHeight [


	"This test do not pass on CI because headless image has display size = 0@0 and then 
	 morphic behaves weird. PropagateNaturalHeight/Width is weak on Morphic because of 
	 this (if not, see the algoritm I was forced to do), but for now passes (just, not on CI :)"
	Smalltalk isHeadless ifTrue: [ ^ self skip ].

	presenter text: String loremIpsum.
	presenter propagateNaturalHeight: true. 
	self openInstance.
	self assert: presenter adapter widget height >= String loremIpsum asMorph height.
]

{ #category : 'tests' }
SpTextPresenterTest >> testPropagateNaturalHeightWithMultipleLines [
	| string |

	"This test do not pass on CI because headless image has display size = 0@0 and then 
	 morphic behaves weird. PropagateNaturalHeight/Width is weak on Morphic because of 
	 this (if not, see the algoritm I was forced to do), but for now passes (just, not on CI :)"
	Smalltalk isHeadless ifTrue: [ ^ self skip ].
 
	string := String loremIpsum withNoLineLongerThan: 80.
	presenter text: string.
	presenter propagateNaturalHeight: true. 
	self openInstance.
	self assert: presenter adapter widget height >= (string lines size * string asMorph height).
]

{ #category : 'tests' }
SpTextPresenterTest >> testPropagateNaturalWidth [
	| lipsum stringMorph expectedWidth |

	"This test do not pass on CI because headless image has display size = 0@0 and then 
	 morphic behaves weird. PropagateNaturalHeight/Width is weak on Morphic because of 
	 this (if not, see the algoritm I was forced to do), but for now passes (just, not on CI :)"
	Smalltalk isHeadless ifTrue: [ ^ self skip ].

	lipsum := String loremIpsum withNoLineLongerThan: 50.

	presenter text: lipsum.
	presenter propagateNaturalWidth: true. 
	self openInstance.
	
	stringMorph := RubEditingArea new 
		font: presenter adapter widget font;
		updateTextWith: lipsum.

	expectedWidth := stringMorph width + 12 min: self currentWorld width / 3.
	
	
	self assert: presenter adapter widget width >= expectedWidth.
	
	
]

{ #category : 'tests' }
SpTextPresenterTest >> testSelectLine [

	presenter text: 'Text for tests.
with multiple
lines'.
	self openInstance.
	presenter cursorPositionIndex: 1.
	presenter selectLine.
	self assert: presenter selectionInterval equals: (1 to: 15)
]

{ #category : 'tests' }
SpTextPresenterTest >> testSelectLineSecondLine [

	presenter text: 'Text for tests.
with multiple
lines'.
	self openInstance.
	presenter cursorPositionIndex: 17.
	presenter selectLine.
	self assert: presenter selectionInterval equals: (17 to: 29)
]
