Class {
	#name : 'SpVerticalBoxLayoutAdapterTest',
	#superclass : 'SpBoxLayoutAdapterTest',
	#category : 'Spec2-Backend-Tests-Layout',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Layout'
}

{ #category : 'helpers' }
SpVerticalBoxLayoutAdapterTest >> layOutWindow [
	"We need to lay out twice. As this is a wrapping morph, when the width changes, the height may change too (because of the wrapping, narrowing it can make it larger). We need to lay out twice to apply the changes to the height, too."

	self window adapter widget fullBounds.
	"a wrapping label whose height changed asks its owner to lay out again, in the next UI cycle"
	self adapter.
	self window adapter widget fullBounds
]

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

{ #category : 'tests' }
SpVerticalBoxLayoutAdapterTest >> testWrappingLabelKeepsTheElementBelowNextToItWhenResized [

	| label below |
	label := SpLabelPresenter new
		         label: 'A long label that cannot fit on one line in a narrow window';
		         beWrap;
		         yourself.
	below := SpButtonPresenter new
		         label: 'Below';
		         yourself.
	layout
		add: label expand: false;
		add: below expand: false.
	self openInstance.

	"Narrower: the label takes more lines, the button must not overlap it"
	self window resize: 150 @ 300.
	self layOutWindow.
	self assert: label adapter numberOfLines > 1.
	self assert: below adapter widget top equals: label adapter widget bottom.

	"Wider: the label takes one line, the button must not stay where the lines ended"
	self window resize: 700 @ 300.
	self layOutWindow.
	self assert: label adapter numberOfLines equals: 1.
	self assert: below adapter widget top equals: label adapter widget bottom
]
