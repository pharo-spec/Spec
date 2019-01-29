"
I'm an adapter for Paned Layouts.
A paned layout will split (horizontally or vertically) a panel and allow its resize. 
"
Class {
	#name : #MorphicPanedAdapter,
	#superclass : #MorphicLayoutAdapter,
	#instVars : [
		'direction',
		'layout'
	],
	#category : #'Spec-MorphicAdapters-Layout'
}

{ #category : #factory }
MorphicPanedAdapter >> add: aPresenter constraints: constraints [
 
	self widgetDo: [ :aPanel | 
		self 
			basicAdd: aPresenter 
			constaints: constraints 
			to: aPanel ]
]

{ #category : #private }
MorphicPanedAdapter >> addConstraits: constraints toChild: childMorph [
	"adds constraits by child"
	| theMorph |
	
	theMorph := childMorph.
	"keep constraints to layout usage"
	theMorph setProperty: #constraints toValue: constraints. 
	
	^ theMorph 
]

{ #category : #private }
MorphicPanedAdapter >> addSplitterIn: aPanel for: childMorph [
	
	aPanel submorphs size = 1 ifFalse: [ ^ self ].
	aPanel addMorphBack: (PanedResizerMorph perform: self selector)
]

{ #category : #private }
MorphicPanedAdapter >> basicAdd: aPresenter constaints: constraints to: aPanel [
	| childMorph |

	childMorph := self 
		addConstraits: constraints 
		toChild: (aPresenter buildWithSpec: constraints spec).

	aPanel addMorphBack: childMorph.
	self calulateLayoutsFor: aPanel submorphs.
	self addSplitterIn: aPanel for: childMorph
]

{ #category : #private }
MorphicPanedAdapter >> calulateLayoutsFor: anArray [
	| pane |

	"enter just the first time"
	"anArray size = 1 ifFalse: [ ^ self ].
	layout position ifNil: [ ^ self ].
	
	pane := anArray first.
	""if it is a percentage, we need a different approach""
	pane perform: self resizingSetSelector with: #rigid.
	self flag: #TODO.
	pane height: (layout position < 1 
		ifTrue: [ 150 ]
		ifFalse: [ layout position ])"
]

{ #category : #accessing }
MorphicPanedAdapter >> direction [

	^ self layout direction
]

{ #category : #accessing }
MorphicPanedAdapter >> layout [

	^ layout
]

{ #category : #factory }
MorphicPanedAdapter >> layout: aLayout [

	layout := aLayout.
	widget := aLayout direction newWidgetOn: self.
	widget layoutPolicy position: aLayout position.
	self selector: self splitterNewSelector.

]

{ #category : #factory }
MorphicPanedAdapter >> newHorizontal [

	^ self newPanel 
		listDirection: #leftToRight;
		yourself
]

{ #category : #factory }
MorphicPanedAdapter >> newPanel [

	^ PanelMorph new 
		layoutPolicy: PanedLayout new;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		color: Color transparent;
		yourself
]

{ #category : #factory }
MorphicPanedAdapter >> newVertical [

	^ self newPanel 
		listDirection: #topToBottom;
		yourself	
]

{ #category : #private }
MorphicPanedAdapter >> resizingSetSelector [

	^ layout isHorizontal 
		ifTrue: [ #hResizing: ]
		ifFalse: [ #vResizing: ]
]

{ #category : #private }
MorphicPanedAdapter >> splitterNewSelector [

	^ layout isHorizontal 
		ifTrue: [ #newHorizontal ]
		ifFalse: [ #newVertical ]
]
