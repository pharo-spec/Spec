Class {
	#name : #SpCodePresenterTest,
	#superclass : #SpTextPresenterTest,
	#category : #'Spec2-Tests-Core-Widgets'
}

{ #category : #tests }
SpCodePresenterTest >> testNilTestSelectedSelectorDoesNotBreakExecution [
	"Code presenter has nil text for some reason"

	| selector |
	presenter text: nil.
	selector := presenter selectedSelector.
	self assert: selector isNil.
]
