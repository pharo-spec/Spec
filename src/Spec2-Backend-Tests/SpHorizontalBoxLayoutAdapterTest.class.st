Class {
	#name : 'SpHorizontalBoxLayoutAdapterTest',
	#superclass : 'SpBoxLayoutAdapterTest',
	#category : 'Spec2-Backend-Tests-Layout',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Layout'
}

{ #category : 'accessing' }
SpHorizontalBoxLayoutAdapterTest >> newLayout [

	^ SpBoxLayout newLeftToRight
]

{ #category : 'tests' }
SpHorizontalBoxLayoutAdapterTest >> testAddingElementsToFixedWidthLayoutDoesNotImpactTheWidthOfTheAdapter [

	| firstButton secondButton nestedLayout nestedPresenter layoutWidget fixedWidth |
	fixedWidth := 250.
	firstButton := SpButtonPresenter new.
	secondButton := SpButtonPresenter new.
	nestedPresenter := presenter newPresenter.
	nestedLayout := self newLayout.
	nestedPresenter layout: nestedLayout.
	layout add: nestedPresenter width: fixedWidth.
	self openInstance.
	layoutWidget := nestedLayout adapter widget.
	self assert: layoutWidget width equals: fixedWidth.

	nestedLayout add: firstButton.
	self assert: layoutWidget width equals: fixedWidth.

	nestedLayout add: secondButton.
	self assert: layoutWidget width equals: fixedWidth.

	nestedLayout remove: secondButton.
	self assert: layoutWidget width equals: fixedWidth.

	nestedLayout add: secondButton.
	self assert: layoutWidget width equals: fixedWidth.

	nestedLayout remove: firstButton.
	self assert: layoutWidget width equals: fixedWidth.

	nestedLayout remove: secondButton.
	self assert: layoutWidget width equals: fixedWidth
]
