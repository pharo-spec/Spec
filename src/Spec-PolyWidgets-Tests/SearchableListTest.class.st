Class {
	#name : #SearchableListTest,
	#superclass : #SpSmokeTestCase,
	#category : #'Spec-PolyWidgets-Tests'
}

{ #category : #running }
SearchableListTest >> classToTest [
	^ SearchableList
]

{ #category : #tests }
SearchableListTest >> testFiltering [
	presenter items: {'aa' . 'bb' . 'ab' . 'ba'}.
	presenter searchPresenter text: 'a'.
	self assertCollection: presenter listPresenter items hasSameElements: {'aa' . 'ab'}
]
