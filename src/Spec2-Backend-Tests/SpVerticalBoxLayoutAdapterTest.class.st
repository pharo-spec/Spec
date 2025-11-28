Class {
	#name : 'SpVerticalBoxLayoutAdapterTest',
	#superclass : 'SpBoxLayoutAdapterTest',
	#category : 'Spec2-Backend-Tests-Layout',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Layout'
}

{ #category : 'accessing' }
SpVerticalBoxLayoutAdapterTest >> newLayout [

	^ SpBoxLayout newTopToBottom
]

{ #category : 'tests' }
SpVerticalBoxLayoutAdapterTest >> testAddingElementsToFixedHeightLayoutDoesNotImpactTheHeightOfTheAdapter [

	| firstButton secondButton nestedLayout nestedPresenter layoutWidget fixedHeight |
	fixedHeight := 250.
	firstButton := SpButtonPresenter new.
	secondButton := SpButtonPresenter new.
	nestedPresenter := presenter newPresenter.
	nestedLayout := self newLayout.
	nestedPresenter layout: nestedLayout.
	layout add: nestedPresenter height: fixedHeight.
	self openInstance.
	layoutWidget := nestedLayout adapter widget.
	self assert: layoutWidget height equals: fixedHeight.

	nestedLayout add: firstButton.
	self assert: layoutWidget height equals: fixedHeight.

	nestedLayout add: secondButton.
	self assert: layoutWidget height equals: fixedHeight.

	nestedLayout remove: secondButton.
	self assert: layoutWidget height equals: fixedHeight.

	nestedLayout add: secondButton.
	self assert: layoutWidget height equals: fixedHeight.

	nestedLayout remove: firstButton.
	self assert: layoutWidget height equals: fixedHeight.

	nestedLayout remove: secondButton.
	self assert: layoutWidget height equals: fixedHeight
]
