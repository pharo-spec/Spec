Class {
	#name : #SearchableListTest,
	#superclass : #SpecSmokeTestCase,
	#category : #'Spec-Tests-PolyWidgets-ListAndTree'
}

{ #category : #running }
SearchableListTest >> classToTest [
	^ SearchableList
]

{ #category : #tests }
SearchableListTest >> testFiltering [
	testedInstance listPresenter items: {'aa' . 'bb' . 'ab' . 'ba'}.
	testedInstance searchPresenter text: 'a'.
	self assert: testedInstance listPresenter model shownItems asArray equals: {'aa' . 'ab'}
]
