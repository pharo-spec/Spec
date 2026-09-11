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
SpMorphicPanedLayoutTest >> testFixedPositionFromBottom [
	| panel m1 m2 layout |
	layout := SpMorphicPanedLayout new.
	layout position: -150.
	panel := PanelMorph new
		layoutPolicy: layout;
		listDirection: #topToBottom;
		bounds: (0@0 extent: 600@800);
		addMorphBack: (m1 := Morph new extent: 100@100; hResizing: #spaceFill; vResizing: #spaceFill; yourself);
		addMorphBack: SpPanedResizerMorph newVertical;
		addMorphBack: (m2 := Morph new extent: 100@100; hResizing: #spaceFill; vResizing: #spaceFill; yourself);
		yourself.
	panel fullBounds.

	self assert: m2 height equals: 150.
	self assert: m2 vResizing equals: #rigid.
	self assert: m1 vResizing equals: #spaceFill.

	panel extent: 600@1000.
	panel fullBounds.
	self assert: m2 height equals: 150.
]

{ #category : 'tests' }
SpMorphicPanedLayoutTest >> testFixedPositionFromRight [
	| panel m1 m2 layout |
	layout := SpMorphicPanedLayout new.
	layout position: -200.
	panel := PanelMorph new
		layoutPolicy: layout;
		listDirection: #leftToRight;
		bounds: (0@0 extent: 800@600);
		addMorphBack: (m1 := Morph new extent: 100@100; hResizing: #spaceFill; vResizing: #spaceFill; yourself);
		addMorphBack: SpPanedResizerMorph newHorizontal;
		addMorphBack: (m2 := Morph new extent: 100@100; hResizing: #spaceFill; vResizing: #spaceFill; yourself);
		yourself.
	panel fullBounds.

	self assert: m2 width equals: 200.
	self assert: m2 hResizing equals: #rigid.
	self assert: m1 hResizing equals: #spaceFill.

	"Resizing window: the right panel must retain its 200 px fixed width"
	panel extent: 1000@600.
	panel fullBounds.
	self assert: m2 width equals: 200
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
SpMorphicPanedLayoutTest >> testPresenterWithFixedPositionFromRight [
	| presenter leftBtn rightBtn |
	presenter := SpPresenter new.
	presenter application: SpApplication new.
	presenter layout: (SpPanedLayout newLeftToRight
		positionOfSlider: -200;
		first: (leftBtn := presenter newButton label: 'Left');
		second: (rightBtn := presenter newButton label: 'Right');
		yourself).

	[ 
		presenter open.
		presenter window extent: 800@600.
		presenter window adapter widget fullBounds.
		
		self assert: rightBtn adapter widget width equals: 200.
		self assert: rightBtn adapter widget hResizing equals: #rigid.
		self assert: leftBtn adapter widget hResizing equals: #spaceFill.
		
		"Resizing window: the right button must retain its 200 px fixed width"
		presenter window extent: 1000@600.
		presenter window adapter widget fullBounds.
		self assert: rightBtn adapter widget width equals: 200.
	] ensure: [ presenter window close ]
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

{ #category : 'tests' }
SpMorphicPanedLayoutTest >> testSplitterDragPreservesFixedPositionFromLeft [
	| panel resizer m1 m2 layout dragDelta startCenter endCenter |
	layout := SpMorphicPanedLayout new.
	layout position: 200.
	panel := PanelMorph new
		layoutPolicy: layout;
		listDirection: #leftToRight;
		bounds: (0@0 extent: 800@600);
		addMorphBack: (m1 := Morph new extent: 100@100; hResizing: #spaceFill; vResizing: #spaceFill; yourself);
		addMorphBack: (resizer := SpPanedResizerMorph newHorizontal);
		addMorphBack: (m2 := Morph new extent: 100@100; hResizing: #spaceFill; vResizing: #spaceFill; yourself);
		yourself.
	panel fullBounds.

	dragDelta := 50.
	startCenter := resizer center.
	endCenter := (startCenter x + dragDelta) @ startCenter y.

	resizer mouseDown: (MouseButtonEvent new
		setType: #mouseDown
		position: startCenter
		which: MouseButtonEvent redButton
		buttons: MouseButtonEvent redButton
		hand: HandMorph new
		stamp: Time millisecondClockValue).

	resizer mouseMove: (MouseMoveEvent new
		setType: #mouseMove
		startPoint: startCenter
		endPoint: endCenter
		trail: { startCenter. endCenter }
		buttons: MouseButtonEvent redButton
		hand: HandMorph new
		stamp: Time millisecondClockValue).

	resizer mouseUp: (MouseButtonEvent new
		setType: #mouseUp
		position: endCenter
		which: MouseButtonEvent redButton
		buttons: 0
		hand: HandMorph new
		stamp: Time millisecondClockValue).

	self assert: layout position isInteger.
	self assert: layout position equals: 250.
	self assert: m1 width equals: 250.

	"Resizing window: panel must retain 250 px and not convert to percentage"
	panel extent: 1000@600.
	panel fullBounds.
	self assert: m1 width equals: 250
]

{ #category : 'tests' }
SpMorphicPanedLayoutTest >> testSplitterDragPreservesFixedPositionFromRight [
	| panel resizer m1 m2 layout dragDelta startCenter endCenter |
	layout := SpMorphicPanedLayout new.
	layout position: -200.
	panel := PanelMorph new
		layoutPolicy: layout;
		listDirection: #leftToRight;
		bounds: (0@0 extent: 800@600);
		addMorphBack: (m1 := Morph new extent: 100@100; hResizing: #spaceFill; vResizing: #spaceFill; yourself);
		addMorphBack: (resizer := SpPanedResizerMorph newHorizontal);
		addMorphBack: (m2 := Morph new extent: 100@100; hResizing: #spaceFill; vResizing: #spaceFill; yourself);
		yourself.
	panel fullBounds.

	dragDelta := -50. "Dragging left expands the right morph m2"
	startCenter := resizer center.
	endCenter := (startCenter x + dragDelta) @ startCenter y.

	resizer mouseDown: (MouseButtonEvent new
		setType: #mouseDown
		position: startCenter
		which: MouseButtonEvent redButton
		buttons: MouseButtonEvent redButton
		hand: HandMorph new
		stamp: Time millisecondClockValue).

	resizer mouseMove: (MouseMoveEvent new
		setType: #mouseMove
		startPoint: startCenter
		endPoint: endCenter
		trail: { startCenter. endCenter }
		buttons: MouseButtonEvent redButton
		hand: HandMorph new
		stamp: Time millisecondClockValue).

	resizer mouseUp: (MouseButtonEvent new
		setType: #mouseUp
		position: endCenter
		which: MouseButtonEvent redButton
		buttons: 0
		hand: HandMorph new
		stamp: Time millisecondClockValue).

	self assert: layout position isInteger.
	self assert: layout position equals: -250.
	self assert: m2 width equals: 250.

	panel extent: 1000@600.
	panel fullBounds.
	self assert: m2 width equals: 250
]
