Class {
	#name : #SpAbstractTextAdapterTest,
	#superclass : #SpAbstractWidgetAdapterTest,
	#category : #'Spec2-Backend-Tests-Base'
}

{ #category : #testing }
SpAbstractTextAdapterTest class >> isAbstract [
	^ self = SpAbstractTextAdapterTest
]

{ #category : #testing }
SpAbstractTextAdapterTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #tests }
SpAbstractTextAdapterTest >> testBeNotEditableAfterOpenWorks [

	self openInstance.
	presenter beNotEditable.
	self assert: presenter text isEmpty.
	presenter type: 'x'.
	self assert: presenter text isEmpty	
]

{ #category : #tests }
SpAbstractTextAdapterTest >> testBeNotEditableWorks [

	presenter beNotEditable.
	
	self assert: presenter text isEmpty.
	presenter type: 'x'.
	self assert: presenter text isEmpty.
	
	"now open and try to type (since is different)"
	self openInstance.
	presenter type: 'x'.
	self assert: presenter text isEmpty
	
]

{ #category : #tests }
SpAbstractTextAdapterTest >> testChangePlaceholderTextUpdatesPresenter [
	presenter placeholder: 'some text'.
	self assert: self adapter placeHolderText equals: 'some text'
]

{ #category : #tests }
SpAbstractTextAdapterTest >> testPresenterPlaceholderIsSetInWidget [
	presenter placeholder: 'something'.
	self assert: self adapter placeHolderText equals: 'something'
]

{ #category : #tests }
SpAbstractTextAdapterTest >> testSelectionInterval [

	presenter text: 'test'.
	presenter selectionInterval: (1 to: 4).
	
	self openInstance.
	
	self 
		assert: presenter adapter selectionInterval
		equals: (1 to: 4)
]

{ #category : #tests }
SpAbstractTextAdapterTest >> testSelectionIntervalNilUnselectsEverything [

	presenter text: 'test'.
	presenter selectionInterval: nil.
	
	self openInstance.
	
	self 
		assert: presenter adapter selectionInterval
		equals: (1 to: 0)
]
