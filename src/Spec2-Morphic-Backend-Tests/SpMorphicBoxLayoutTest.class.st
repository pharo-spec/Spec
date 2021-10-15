Class {
	#name : #SpMorphicBoxLayoutTest,
	#superclass : #TestCase,
	#instVars : [
		'instance'
	],
	#category : #'Spec2-Morphic-Backend-Tests'
}

{ #category : #running }
SpMorphicBoxLayoutTest >> tearDown [
	instance
		ifNotNil: [ instance close.
			instance := nil ].
	super tearDown
]

{ #category : #tests }
SpMorphicBoxLayoutTest >> testAddWithPaddingHorizontal [
	| base presenter layout |

	base := SpBoxLayoutWithTableForTestPresenter new.
	presenter := SpLabelPresenter new.
	
	layout := SpBoxLayout newLeftToRight
		add: presenter expand: false fill: false padding: 10;
		yourself.
		
	base buildAdapterWithSpecLayout: layout.

	"validate the widget is within a parent that keeps the widget with a padding"	
	self 
		assert: presenter adapter widget extent
		equals: (presenter adapter widget owner extent - (20@0))
]

{ #category : #tests }
SpMorphicBoxLayoutTest >> testAddWithPaddingVertical [
	| base presenter layout |

	base := SpBoxLayoutWithTableForTestPresenter new.
	presenter := SpLabelPresenter new.
	
	layout := SpBoxLayout newTopToBottom
		add: presenter expand: false fill: false padding: 10;
		yourself.
		
	base buildAdapterWithSpecLayout: layout.

	"validate the widget is within a parent that keeps the widget with a padding"	
	self 
		assert: presenter adapter widget extent
		equals: (presenter adapter widget owner extent - (0@20))
]

{ #category : #tests }
SpMorphicBoxLayoutTest >> testBeHomogeneous [
	| presenter p1 p2 p3 |

	presenter := SpPresenter new.
	presenter layout: (SpBoxLayout newHorizontal 
		beHomogeneous;
		add: (p1 := presenter newList);
		add: (p2 := presenter newLabel);
		add: (p3 := presenter newText);
		yourself).

	[ presenter openWithSpec ]
	ensure: [ presenter window close ].		

	self assert: presenter adapter widget width 
		>= (p1 adapter widget width 
			+ p2 adapter widget width
			+ p3 adapter widget width).
	self assert: p1 adapter widget width equals: p2 adapter widget width.
	self assert: p2 adapter widget width equals: p3 adapter widget width.	
]

{ #category : #tests }
SpMorphicBoxLayoutTest >> testClassIsDisplayedWithCorrectAlignment [
	| presenter table |

	presenter := SpBoxLayoutWithTableForTestPresenter new.
	instance := presenter openWithSpec.

	table := presenter table adapter widget.
	self assert: instance window left <= table left.
	self assert: table left <= table submorphs first left
]

{ #category : #tests }
SpMorphicBoxLayoutTest >> testLayoutHeightTakesAllSpaceNeeded [
	| string presenter textPresenter layout |

	string := String loremIpsum withNoLineLongerThan: 80.

	presenter := SpPresenter new.

	textPresenter := SpTextPresenter new.
	textPresenter text: string.
	textPresenter propagateNaturalHeight: true. 

	layout := SpBoxLayout newTopToBottom 
		add: textPresenter;
		yourself.	
	
	presenter 
		layout: layout;
		buildWithSpec.
	
	self assert: presenter adapter widget height >= (string lines size * string asMorph height).
]

{ #category : #tests }
SpMorphicBoxLayoutTest >> testNestedLayoutModifiesHeightOfTopLayout [
	| base presenter layout |

	base := SpBoxLayoutWithTableForTestPresenter new.

	presenter := SpLabelPresenter new
		label: 'Test';
		yourself.
	
	layout := SpBoxLayout newTopToBottom
		add: (SpBoxLayout newLeftToRight 
				add: presenter expand: false;
				yourself) 
			expand: false;
		yourself.
		
	base buildAdapterWithSpecLayout: layout.

	"validate the widget is within a parent that keeps the widget with a padding"	
	self 
		assert: presenter adapter widget owner owner height  
		equals: presenter adapter widget height
]

{ #category : #tests }
SpMorphicBoxLayoutTest >> testPresenterTakesRightHeight [
	| presenter l1 l2 |
	
	(presenter := SpPresenter new) 
		layout: (SpBoxLayout newTopToBottom 
			add: (l1 := (presenter newLabel label: 'Line 1')) expand: false;
			add: (l2 := (presenter newLabel label: 'Line 2')) expand: false).
	
	presenter buildWithSpec.	
	
	self 
		assert: presenter adapter widget height 
		equals: l1 adapter widget height + l2 adapter widget height
]
