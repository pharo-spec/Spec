"
I am a test class for the SpMorphicProgressBarAdapter.
"
Class {
	#name : 'SpMorphicProgressBarAdapterTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Morphic-Backend-Tests',
	#package : 'Spec2-Morphic-Backend-Tests'
}

{ #category : 'tests' }
SpMorphicProgressBarAdapterTest >> testApplyingStyleKeepsLabelFittingItsContents [
	"The label took the height of the whole widget: the bar was laid out outside of it, not visible"

	| presenter label styledHeight |
	presenter := SpProgressBarPresenter new.
	presenter indeterminate.
	presenter build.
	label := presenter adapter widget submorphs first.

	presenter adapter applyStyle.
	styledHeight := label height.

	label fitContents.
	self assert: styledHeight equals: label height
]
