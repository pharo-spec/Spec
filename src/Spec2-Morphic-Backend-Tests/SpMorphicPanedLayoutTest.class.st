Class {
	#name : 'SpMorphicPanedLayoutTest',
	#superclass : 'TestCase',
	#instVars : [
		'instance'
	],
	#category : 'Spec2-Morphic-Backend-Tests',
	#package : 'Spec2-Morphic-Backend-Tests'
}

{ #category : 'running' }
SpMorphicPanedLayoutTest >> tearDown [

	instance ifNotNil: [ 
		instance window close.
		instance := nil ].
	super tearDown
]

{ #category : 'tests' }
SpMorphicPanedLayoutTest >> testClickSelectsTableRowWithFractionalPosition [
	"A fractional position (e.g. 750 * 35 percent = 525/2) was used as is: the first morph height (262) never equaled the position (262.5), so each layout set the height again and reset the rows of the table.
	A click, that triggers a layout, then found no row under the mouse and was ignored"

	| table paned hand rowCenter |
	(instance := SpPresenter new) layout: (SpPanedLayout newTopToBottom
			 positionOfSlider: 525 / 2;
			 add: (table := instance newTable);
			 add: instance newLabel;
			 yourself).
	table
		addColumn: (SpStringTableColumn evaluated: #printString);
		items: (1 to: 20) asArray.
	instance asWindow
		initialExtent: 400 @ 600;
		open.
	instance currentWorld doOneCycleNow.

	paned := table adapter widget owner.
	hand := instance currentWorld activeHand.
	rowCenter := (table adapter widget container exposedRows at: 3) bounds center.
	paned processEvent: (MouseButtonEvent new
			 setType: #mouseDown
			 position: rowCenter
			 which: MouseButtonEvent redButton
			 buttons: MouseButtonEvent redButton
			 hand: hand
			 stamp: Time millisecondClockValue).
	paned processEvent: (MouseButtonEvent new
			 setType: #mouseUp
			 position: rowCenter
			 which: MouseButtonEvent redButton
			 buttons: 0
			 hand: hand
			 stamp: Time millisecondClockValue).
	hand
		resetClickState;
		newMouseFocus: nil.

	self assert: table selection selectedIndex equals: 3
]

{ #category : 'tests' }
SpMorphicPanedLayoutTest >> testListTakesAssignedSpace [

	| list |
	(instance := SpPresenter new) layout: (SpPanedLayout newTopToBottom
			 add: (SpPanedLayout newLeftToRight
					  add: (list := instance newTree);
					  add: instance newLabel;
					  yourself);
			 add: instance newText;
			 yourself).

	list items: #( a ).

	instance open.

	self
		assert: list adapter widget container width
		equals: list adapter widget width
]

{ #category : 'tests' }
SpMorphicPanedLayoutTest >> testReplacePresenter [

	| presenter p1 p2 p3 widget |
	presenter := SpPresenter new.
	presenter application: SpApplication new.

	presenter layout: (SpPanedLayout newLeftToRight
			 first: (p1 := presenter newButton label: '1');
			 second: (p2 := presenter newButton label: '2');
			 yourself).

	[ presenter open ] ensure: [ presenter window close ].

	p3 := presenter newLabel label: 'Test'.

	presenter layout first: p3.

	widget := presenter adapter widget.
	self assert: widget submorphs size equals: 3. "one plus for the slider"
	self assert: widget submorphs first equals: p3 adapter widget
]
