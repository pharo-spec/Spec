Extension { #name : 'SpPanedLayout' }

{ #category : '*Spec2-Examples' }
SpPanedLayout class >> exampleFixedFromEnd [
	<example>
	| presenter text form |
	presenter := SpPresenter new.
	presenter layout: (SpPanedLayout newLeftToRight
		positionOfSlider: -260;
		add: (text := presenter newText);
		add: (form := presenter newList);
		yourself).

	text text: 'Fixed end layout (-260 px).
The right properties panel keeps its fixed width (260 px) when the window is resized.
Dragging the splitter updates the fixed width from the right edge.'.
	form items: #( 'Property 1: True' 'Property 2: #auto' 'Property 3: 42' ).
	presenter openWithTitle: 'SpPanedLayout - Fixed Right (-260 px)'
]

{ #category : '*Spec2-Examples' }
SpPanedLayout class >> exampleFixedFromStart [
	<example>
	| presenter list text |
	presenter := SpPresenter new.
	presenter layout: (SpPanedLayout newLeftToRight
		positionOfSlider: 220;
		add: (list := presenter newList);
		add: (text := presenter newText);
		yourself).

	list items: #( 'Project Tree' 'Packages' 'Classes' 'Methods' ).
	text text: 'Fixed start layout (220 px).
The left list keeps its fixed width when the window is resized.
Dragging the splitter updates the fixed pixel width.'.
	presenter openWithTitle: 'SpPanedLayout - Fixed Left (220 px)'
]

{ #category : '*Spec2-Examples' }
SpPanedLayout class >> exampleNotResizingStartChild [ 
	<example>
	| app presenter child1 child2 |
	
	app := SpApplication new.

	presenter := SpPresenter newApplication: app.
	presenter layout: (SpPanedLayout newTopToBottom
		positionOfSlider: 50;
		add: (child1 := presenter newList) withConstraints: [ :c | c beNotResizable ];
		add: (child2 := presenter newList);
		yourself).
		
	child1 items: #(one two).
	child2 items: String loremIpsum substrings.

	presenter open
]

{ #category : '*Spec2-Examples' }
SpPanedLayout class >> exampleProportional [
	<example>
	| presenter list text |
	presenter := SpPresenter new.
	presenter layout: (SpPanedLayout newLeftToRight
		positionOfSlider: 30 percent;
		add: (list := presenter newList);
		add: (text := presenter newText);
		yourself).

	list items: (1 to: 50).
	text text: 'Proportional layout (30% / 70%).
Both panels resize proportionally when the window is resized.
Dragging the splitter keeps proportional behavior.'.
	presenter openWithTitle: 'SpPanedLayout - Proportional (30%)'
]
