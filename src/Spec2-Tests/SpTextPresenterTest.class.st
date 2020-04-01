Class {
	#name : #SpTextPresenterTest,
	#superclass : #SpAbstractTextPresenterTest,
	#category : #'Spec2-Tests-Core-Widgets'
}

{ #category : #running }
SpTextPresenterTest >> classToTest [
	^ SpTextPresenter
]

{ #category : #tests }
SpTextPresenterTest >> testInsertAt [
	
	self initializationText.
	self openInstance.
	presenter insert: 'insertion ' at: 9.
	self assert: presenter text equals: 'Text for insertion tests.'
]

{ #category : #tests }
SpTextPresenterTest >> testPropagateNaturalHeight [

	presenter text: String loremIpsum.
	presenter propagateNaturalHeight: true. 
	self openInstance.
	self assert: presenter adapter widget height >= String loremIpsum asMorph height.
]

{ #category : #tests }
SpTextPresenterTest >> testPropagateNaturalWidth [

	presenter text: String loremIpsum.
	presenter propagateNaturalWidth: true. 
	self openInstance.
	self assert: presenter adapter widget width >= String loremIpsum asMorph width.
]

{ #category : #tests }
SpTextPresenterTest >> testSelectLine [
	self initializationText.
	self openInstance.
	presenter selectLine.
	self assert: presenter selectionInterval equals: (1 to: 15)
]
