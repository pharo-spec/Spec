Class {
	#name : 'SpAbstractTextPresenterTest',
	#superclass : 'SpSmokeTest',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'testing' }
SpAbstractTextPresenterTest class >> isAbstract [
	^ self = SpAbstractTextPresenterTest
]

{ #category : 'accessing' }
SpAbstractTextPresenterTest >> classToTest [
	^ self subclassResponsibility
]

{ #category : 'initialization' }
SpAbstractTextPresenterTest >> initializationText [
	presenter text: 'Text for tests.'
]

{ #category : 'tests' }
SpAbstractTextPresenterTest >> testClearContent [
	self initializationText.
	self denyEmpty: presenter text.
	presenter clearContent.
	self assertEmpty: presenter text
]

{ #category : 'tests' }
SpAbstractTextPresenterTest >> testClearSelection [
	self initializationText.
	self openInstance.
	presenter selectionInterval: (1 to: 10).
	self assert: presenter selectionInterval equals: (1 to: 10).
	presenter clearSelection.
	self assert: presenter selectionInterval isEmpty
]

{ #category : 'tests' }
SpAbstractTextPresenterTest >> testContextMenu [
	| menu changed |
	
	self assert: presenter contextMenu isNil.
	menu := SpMenuPresenter new.
	changed := false.
	presenter whenMenuChangedDo: [ 
		changed := true. ].
	presenter contextMenu: menu.
	self assert: presenter contextMenu equals: menu.
	self assert: changed
]

{ #category : 'tests' }
SpAbstractTextPresenterTest >> testCursorPositionIndex [

	presenter text: (String loremIpsum: 80).
	self openInstance. "cursor position does not works if instance is not opened"
	"If not defined, cursor is at begining"	
	self assert: presenter cursorPositionIndex equals: 1.
	"middle"
	presenter cursorPositionIndex: 20.
	self assert: presenter cursorPositionIndex equals: 20.
	"end"
	presenter cursorPositionIndex: 81.
	self assert: presenter cursorPositionIndex equals: 81

]

{ #category : 'tests' }
SpAbstractTextPresenterTest >> testPlaceholderIsSet [

	presenter placeholder: 'enter something...'.
	
	self assert: presenter placeholder equals: 'enter something...'
]

{ #category : 'tests' }
SpAbstractTextPresenterTest >> testSelectAll [
	self initializationText.
	self openInstance.
	presenter selectAll.
	self assert: presenter selectionInterval equals: (1 to: 15)
]

{ #category : 'tests' }
SpAbstractTextPresenterTest >> testWhenResetDo [
	| reseted |

	reseted := false.
	presenter whenResetDo: [ :aString | reseted := true ].
	
	self openInstance.
	
	self textInputAdapter
		keyDown: $l 
		shift: false
		meta: true 
		control: false 
		option: false.
		
	self assert: reseted
]

{ #category : 'tests' }
SpAbstractTextPresenterTest >> testWhenSubmitDo [
	| submitted |

	submitted := false.
	presenter whenSubmitDo: [ :aString | submitted := true ].
	
	self openInstance.
	
	self textInputAdapter
		keyDown: $s 
		shift: false
		meta: true 
		control: false 
		option: false.
		
	self assert: submitted
]

{ #category : 'tests' }
SpAbstractTextPresenterTest >> testWhenSubmitDoReceivesAString [
	| submitted |

	submitted := false.
	presenter whenSubmitDo: [ :aString | submitted := aString ].
	
	self openInstance.
	
	presenter type: 'abc'.
	
	self textInputAdapter
		keyDown: $s 
		shift: false
		meta: true 
		control: false 
		option: false.
		
	self assert: submitted equals: 'abc'
]

{ #category : 'private' }
SpAbstractTextPresenterTest >> textInputAdapter [
	
	^ presenter adapter
]
