Class {
	#name : #SpSearchableListTest,
	#superclass : #SpSmokeTestCase,
	#category : #'Spec-PolyWidgets-Tests'
}

{ #category : #running }
SpSearchableListTest >> classToTest [
	^ SearchableList
]

{ #category : #tests }
SpSearchableListTest >> testFiltering [
	presenter items: {'aa' . 'bb' . 'ab' . 'ba'}.
	presenter searchPresenter text: 'a'.
	self assertCollection: presenter listPresenter items hasSameElements: {'aa' . 'ab'}
]
