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
SpVerticalBoxLayoutAdapterTest >> testAdapterHeightIsHeightOfSingleElementAndBorderWhenItHasABorder [

	| iconBarLayout iconBar layoutWidget borderWidth |
	borderWidth := 5.
	iconBarLayout := self newLayout
		borderWidth: borderWidth;
		yourself.
	self add16By16ImageTo: iconBarLayout.
	iconBar := SpPresenter new
		layout: iconBarLayout;
		yourself.
	layout
		vAlignCenter;
		hAlignCenter;
		add: iconBar expand: false.
	self openInstance.
	
	layoutWidget := iconBar adapter widget.
	layoutWidget borderColor: Color white. "In case the reader wants to inspect the result."
	self assert: layoutWidget width equals: borderWidth + 16 + borderWidth.
	self assert: layoutWidget height equals: borderWidth + 16 + borderWidth
]

{ #category : 'tests' }
SpVerticalBoxLayoutAdapterTest >> testAdapterHeightIsHeightOfSingleElementAndBorderWhenItHasSpacing [

	| iconBarLayout iconBar layoutWidget borderWidth |
	borderWidth := 5.
	iconBarLayout := self newLayout
		borderWidth: borderWidth;
		spacing: 10;
		yourself.
	self add16By16ImageTo: iconBarLayout.
	iconBar := SpPresenter new
		layout: iconBarLayout;
		yourself.
	layout
		vAlignCenter;
		hAlignCenter;
		add: iconBar expand: false.
	self openInstance.
	
	layoutWidget := iconBar adapter widget.
	layoutWidget borderColor: Color white. "In case the reader wants to inspect the result."
	self assert: layoutWidget width equals: borderWidth + 16 + borderWidth.
	self assert: layoutWidget height equals: borderWidth + 16 + borderWidth
]

{ #category : 'tests' }
SpVerticalBoxLayoutAdapterTest >> testAdapterHeightIsSumOfElementHeightsAndBorderWhenItHasABorder [

	| iconBarLayout iconBar layoutWidget borderWidth numberOfNestedImages |
	borderWidth := 5.
	iconBarLayout := self newLayout
		borderWidth: borderWidth;
		yourself.
	numberOfNestedImages := 3.
	1 to: numberOfNestedImages do: [ :index | self add16By16ImageTo: iconBarLayout ].
	iconBar := SpPresenter new
		layout: iconBarLayout;
		yourself.
	layout
		vAlignCenter;
		hAlignCenter;
		add: iconBar expand: false.
	self openInstance.
	
	layoutWidget := iconBar adapter widget.
	layoutWidget borderColor: Color white. "In case the reader wants to inspect the result."
	self assert: layoutWidget height equals: borderWidth + (numberOfNestedImages * 16) + borderWidth.
	self assert: layoutWidget width equals: borderWidth + 16 + borderWidth
]

{ #category : 'tests' }
SpVerticalBoxLayoutAdapterTest >> testAdapterHeightIsSumOfElementWidthsAndBorderAndSpacingWhenItHasSpacing [

	| iconBarLayout iconBar layoutWidget borderWidth numberOfNestedImages spacing |
	borderWidth := 5.
	spacing := 10.
	iconBarLayout := self newLayout
		borderWidth: borderWidth;
		spacing: spacing;
		yourself.
	numberOfNestedImages := 3.
	1 to: numberOfNestedImages do: [ :index | self add16By16ImageTo: iconBarLayout ].
	iconBar := SpPresenter new
		layout: iconBarLayout;
		yourself.
	layout
		vAlignCenter;
		hAlignCenter;
		add: iconBar expand: false.
	self openInstance.
	
	layoutWidget := iconBar adapter widget.
	layoutWidget borderColor: Color white. "In case the reader wants to inspect the result."
	self assert: layoutWidget width equals: borderWidth + 16 + borderWidth.
	self assert: layoutWidget height equals: borderWidth + (numberOfNestedImages * 16) + borderWidth + ((numberOfNestedImages - 1) * spacing).
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
