Class {
	#name : #SpMorphicPanedLayoutTest,
	#superclass : #TestCase,
	#instVars : [
		'instance'
	],
	#category : #'Spec2-Morphic-Backend-Tests'
}

{ #category : #running }
SpMorphicPanedLayoutTest >> tearDown [

	instance ifNotNil: [ 
		instance window close.
		instance := nil ].
	super tearDown
]

{ #category : #tests }
SpMorphicPanedLayoutTest >> testListTakesAssignedSpace [
	| list |

	(instance := SpPresenter new) 
		layout: (SpPanedLayout newTopToBottom 
			add: (SpPanedLayout newLeftToRight
				add: (list := instance newTree);
				add: (instance newLabel);
				yourself);
			add: instance newText;
			yourself).
		
	list items: #(a).
	
	instance openWithSpec.

	self 
		assert: list adapter widget container width 
		equals: list adapter widget width
]

{ #category : #tests }
SpMorphicPanedLayoutTest >> testReplacePresenter [
	| presenter p1 p2 p3 widget |
	
	presenter := SpPresenter new.
	presenter application: SpApplication new.

	presenter layout: (SpPanedLayout newLeftToRight 
		addFirst: (p1 := presenter newButton label: '1');
		addSecond: (p2 := presenter newButton label: '2');
		yourself).
	
	[ presenter openWithSpec ]
	ensure: [ presenter window close ].

	p3 := presenter newLabel label: 'Test'.

	presenter layout addFirst: p3.
	
	widget := presenter adapter widget.
	self assert: widget submorphs size equals: 3 "one plus for the slider".
	self assert: widget submorphs first equals: p3 adapter widget
	
]
