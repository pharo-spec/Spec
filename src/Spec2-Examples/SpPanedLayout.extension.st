Extension { #name : 'SpPanedLayout' }

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
