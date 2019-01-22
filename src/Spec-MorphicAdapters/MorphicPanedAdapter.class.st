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
	| index |
	
	index := aPanel submorphs indexOf: childMorph.
	index > 1 ifTrue: [ 
		aPanel perform: self selector with: index ]
]

{ #category : #private }
MorphicPanedAdapter >> basicAdd: aPresenter constaints: constraints to: aPanel [
	| childMorph |

	childMorph := self addConstraits: constraints toChild: aPresenter buildWithSpec.

	aPanel addMorphBack: childMorph.
	self calulateLayoutsFor: aPanel submorphs.
	self addSplitterIn: aPanel for: childMorph
]

{ #category : #private }
MorphicPanedAdapter >> calulateLayoutsFor: aCollection [
	| numOfMorphs step |

	aCollection size = 1 ifTrue: [ 
		aCollection first layoutFrame: LayoutFrame identity.
		^ self ].
	
	numOfMorphs := aCollection size.
	step := 1 / numOfMorphs.
	aCollection withIndexDo: [ :each :index | 
		each layoutFrame: (LayoutFrame identity 
			topFraction: step * (index - 1);
			bottomFraction: (step * index);
			yourself) ]
]

{ #category : #accessing }
MorphicPanedAdapter >> direction [

	^ self layout direction
]

{ #category : #testing }
MorphicPanedAdapter >> isFlexible [

	^ self selector notNil
]

{ #category : #accessing }
MorphicPanedAdapter >> layout [

	^ layout
]

{ #category : #factory }
MorphicPanedAdapter >> layout: aLayout [

	layout := aLayout.
	widget := self newPanel.	
	self selector: (self splitterSelectorFor: aLayout).

]

{ #category : #factory }
MorphicPanedAdapter >> newPanel [

	^ PanelMorph new 
		changeProportionalLayout;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		color: Color transparent;
		yourself
]

{ #category : #private }
MorphicPanedAdapter >> splitterSelectorFor: aLayout [

	^ aLayout isHorizontal 
		ifTrue: [ #newVSplitterAt: ]
		ifFalse: [ #newHSplitterAt: ]
]
