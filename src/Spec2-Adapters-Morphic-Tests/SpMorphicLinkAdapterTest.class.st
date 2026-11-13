Class {
	#name : 'SpMorphicLinkAdapterTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Adapters-Morphic-Tests',
	#package : 'Spec2-Adapters-Morphic-Tests'
}

{ #category : 'tests' }
SpMorphicLinkAdapterTest >> testChangedHelpIsTheBalloonText [
	"The balloon text was only set when building the morph"

	| link |
	link := SpLinkPresenter new
		        label: 'location';
		        yourself.
	link build.

	link help: '/a/location'.

	self assert: link adapter widget balloonText equals: '/a/location'
]

{ #category : 'tests' }
SpMorphicLinkAdapterTest >> testEmptyHelpHasNoBalloon [
	"An empty help displayed an empty balloon"

	| link |
	link := SpLinkPresenter new
		        label: 'location';
		        help: '';
		        yourself.

	link build.

	self deny: link adapter widget wantsBalloon
]
