"
This presenter contains two presenters provided by the user. The first presenter is fixed and can be expanded or splitted. The second presenter is dynamic and can be shown split or hidden. Split can be done horizontally or vertically.

## Structure

It consists of two main presenters, each containing a toggle button and a customizable content area. The content area can host various presenters such as text fields, lists, or other common UI elements. By default, both presenters occupy equal space within the container.

## Behavior

- Initially, both subpresenter are visible and equally sized.
- Clicking a toggle button in either subwidget triggers an expansion/collapse action:
  * The clicked subpresenter collapses and becomes hidden.
  * The other subpresenter expands to fill the entire container.
- Clicking the toggle button again reverses this action, restoring both subwidgets to their original, equally-sized state.

This presenter provides a flexible way to manage space in UIs where two components need to alternately occupy the same area, allowing for dynamic content presentation and improved space utilization.

## Example

```smalltalk
togglePresenter := SpToggleSplitPresenter new.
togglePresenter first: SpTextInputFieldPresenter new.
togglePresenter second: SpListPresenter new.
togglePresenter open.
```

See more examples in the class side.

"
Class {
	#name : 'SpToggleSplitPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'first',
		'second',
		'toggleButton',
		'showString',
		'hideString',
		'layoutDirection',
		'positionOfSlider'
	],
	#category : 'Spec2-CommonWidgets-Core',
	#package : 'Spec2-CommonWidgets',
	#tag : 'Core'
}

{ #category : 'examples' }
SpToggleSplitPresenter class >> example [

	self exampleOpenHidden
]

{ #category : 'examples' }
SpToggleSplitPresenter class >> exampleOpenHidden [

	| list text |
	
	text := SpTextPresenter new text: String loremIpsum.
	list := SpListPresenter new items: (1 to: 10); yourself.
	^ self new
		first: text label: 'Show list';
		second: list label: 'Hide list';
		setHiddenInitialState;
		open.
]

{ #category : 'examples' }
SpToggleSplitPresenter class >> exampleOpenSplitted [

	| list text |
	
	text := SpTextPresenter new text: String loremIpsum.
	list := SpListPresenter new items: (1 to: 10); yourself.
	^ self new
		first: text label: 'Show list';
		second: list label: 'Hide list';
		setSplittedInitialState;
		open.
]

{ #category : 'examples' }
SpToggleSplitPresenter class >> exampleOpenVerticalCustomProportionSplit [

	| list text |
	
	text := SpTextPresenter new text: String loremIpsum.
	list := SpListPresenter new items: (1 to: 10); yourself.
	^ self new
		layoutDirection: #newLeftToRight;
		positionOfSlider: 30 percent;
		first: text label: 'Show list';
		second: list label: 'Hide list';
		setSplittedInitialState;
		open.
]

{ #category : 'examples' }
SpToggleSplitPresenter class >> exampleOpenVerticalSplit [

	| list text |
	
	text := SpTextPresenter new text: String loremIpsum.
	list := SpListPresenter new items: (1 to: 10); yourself.
	^ self new
		layoutDirection: #newLeftToRight;
		first: text label: 'Show list';
		second: list label: 'Hide list';
		setSplittedInitialState;
		open.
]

{ #category : 'layout' }
SpToggleSplitPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom 
		add: toggleButton expand: false;
		add: self switchLayout;
		yourself.
]

{ #category : 'initialization' }
SpToggleSplitPresenter >> defaultSliderPosition [

	^ 50 percent
]

{ #category : 'accessing' }
SpToggleSplitPresenter >> first [

	^ first
]

{ #category : 'accessing' }
SpToggleSplitPresenter >> first: anObject label: showLabelString [

	first := anObject.
	showString := showLabelString
]

{ #category : 'accessing' }
SpToggleSplitPresenter >> hideString: anObject [

	hideString := anObject
]

{ #category : 'initialization' }
SpToggleSplitPresenter >> initializePresenters [

	toggleButton := self newToggleButton 
		whenDeactivatedDo: [ 
			self layout: self defaultLayout.
			toggleButton label: hideString.
			second show ];
		whenActivatedDo: [ 
			second hide.
			toggleButton label: showString.
			self layout: self defaultLayout ];
		yourself.

]

{ #category : 'initialization' }
SpToggleSplitPresenter >> layoutDirection [

	^ layoutDirection
		ifNil: [ layoutDirection := #newTopToBottom ]
]

{ #category : 'accessing' }
SpToggleSplitPresenter >> layoutDirection: anObject [

	layoutDirection := anObject
]

{ #category : 'initialization' }
SpToggleSplitPresenter >> positionOfSlider [
	"Answer a <Number> representing the position where the slider will be placed in the pane."
	
	^ positionOfSlider
		ifNil: [ positionOfSlider := self defaultSliderPosition ]
]

{ #category : 'accessing' }
SpToggleSplitPresenter >> positionOfSlider: anObject [

	positionOfSlider := anObject
]

{ #category : 'accessing' }
SpToggleSplitPresenter >> second [

	^ second
]

{ #category : 'accessing' }
SpToggleSplitPresenter >> second: anObject label: secondLabelString [

	second := anObject.
	hideString := secondLabelString.
]

{ #category : 'initialization' }
SpToggleSplitPresenter >> setHiddenInitialState [
	"Set the receiver to show both presenters when opened"
	
	toggleButton 
		label: showString;
		click
]

{ #category : 'initialization' }
SpToggleSplitPresenter >> setSplittedInitialState [
	"Set the receiver to show both presenters when opened"
	
	toggleButton 
		label: hideString 
]

{ #category : 'accessing' }
SpToggleSplitPresenter >> showString: anObject [

	showString := anObject
]

{ #category : 'initialization' }
SpToggleSplitPresenter >> switchLayout [

	^ toggleButton state
		  ifTrue: [
			  SpBoxLayout newTopToBottom
				  add: first;
				  yourself ]
		  ifFalse: [
			  (SpPanedLayout perform: self layoutDirection)
				  positionOfSlider: self positionOfSlider;
				  add: first;
				  add: second;
				  yourself ]
]
