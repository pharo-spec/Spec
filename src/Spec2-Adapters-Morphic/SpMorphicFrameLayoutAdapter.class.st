"
I'm an adapter for Frame Layouts.
"
Class {
	#name : 'SpMorphicFrameLayoutAdapter',
	#superclass : 'SpMorphicLayoutAdapter',
	#instVars : [
		'framePanel'
	],
	#category : 'Spec2-Adapters-Morphic-Layout',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Layout'
}

{ #category : 'experiment-toggle' }
SpMorphicFrameLayoutAdapter class >> adaptingName [

	^ #FrameLayoutAdapter
]

{ #category : 'factory' }
SpMorphicFrameLayoutAdapter >> add: aPresenter [
 
	self add: aPresenter constraints: SpBoxConstraints new
]

{ #category : 'factory' }
SpMorphicFrameLayoutAdapter >> addConstraints: constraints toChild: childMorph [

	^ childMorph
]

{ #category : 'private' }
SpMorphicFrameLayoutAdapter >> addPadding: aNumber toMorph: aMorph [
	
	aNumber = 0 ifTrue: [ ^ aMorph ].
	
	^ layout direction 
		addPadding: aNumber 
		toMorph: aMorph
		into: self
]

{ #category : 'private' }
SpMorphicFrameLayoutAdapter >> applyAlignmentTo: aWidget [

	layout vAlign ifNotNil: [ :align | 
		framePanel vResizing: #shrinkWrap.
		aWidget listCentering: align asMorphicAlign ].
	layout hAlign ifNotNil: [ :align | 
		framePanel hResizing: #shrinkWrap.
		aWidget wrapCentering: align asMorphicAlign.
		aWidget cellPositioning: align asMorphicAlign ].

	^ aWidget
]

{ #category : 'private' }
SpMorphicFrameLayoutAdapter >> applyAlignmentToChild: aWidget [

	"layout vAlign 
		ifNotNil: [ aWidget vResizing: #rigid ].
	layout hAlign 
		ifNotNil: [ aWidget hResizing: #rigid ]"

]

{ #category : 'private' }
SpMorphicFrameLayoutAdapter >> basicAdd: aPresenter constraints: constraints to: aPanel [
	| childMorph |

	childMorph := self buildMorph: aPresenter constraints: constraints.	

	self applyAlignmentToChild: childMorph.
	self verifyBoxExtentOf: aPanel withChild: childMorph.

	framePanel addMorphBack: childMorph .

	^ childMorph
]

{ #category : 'accessing' }
SpMorphicFrameLayoutAdapter >> children [

	^ framePanel submorphs
]

{ #category : 'accessing' }
SpMorphicFrameLayoutAdapter >> childrenWidgets [
	
	^ self children
]

{ #category : 'factory' }
SpMorphicFrameLayoutAdapter >> layout: aLayout [

	layout := aLayout.
	
	widget ifNil: [
		"build of widget was differed up to here (to know what is the direction)"
		widget := self newLabel: (aLayout label ifNil: [ '' ]).

		"widget borderWidth: aLayout borderWidth."
		"aLayout hasAlignment 
			ifTrue: [ widget := self applyAlignmentTo: widget ]."
		"the spacing needs to be applied to the inner sub-panels"
		"{ startPanel. endPanel } 
			do: [ :each | each cellInset: aLayout spacing ]"
		"widget homogeneous: aLayout isHomogeneous" ].

	aLayout whenChildrenAddedDo: [ :ann |
		self
			add: ann child
			constraints: (aLayout constraintsFor: ann child) ].
	
	aLayout whenChildrenRemovedDo: [ :ann |
		self remove: ann child ].
	
	super layout: aLayout
]

{ #category : 'factory' }
SpMorphicFrameLayoutAdapter >> newLabel: aLabel [

	^ (framePanel := self newPanelWith: self newPanelLayout label: aLabel)
		listDirection: #topToBottom;
		yourself
]

{ #category : 'factory' }
SpMorphicFrameLayoutAdapter >> newPanelLayout [

	^ SpMorphicFrameLayout new
		specLayout: layout;
		yourself
]

{ #category : 'factory' }
SpMorphicFrameLayoutAdapter >> newPanelWith: aLayout label: aLabel [

	^ SpMorphicFrameLayoutMorph new
	  label: aLabel;
	  layoutPolicy: aLayout;
	  hResizing: #spaceFill;
	  vResizing: #spaceFill;
	  color: Color transparent;
	  borderColor: Color transparent;
	  clipSubmorphs: true;
	  "stop being grabbed"beSticky;
	  borderWidth: 12;
	  extent: 0 @ 0;
	  yourself
]

{ #category : 'accessing' }
SpMorphicFrameLayoutAdapter >> remove: aPresenter [

	aPresenter adapter ifNotNil: [ :adapter |
		framePanel removeMorph: adapter widget.
		self verifyBoxExtent ]
]

{ #category : 'accessing' }
SpMorphicFrameLayoutAdapter >> removeAll [

	framePanel removeAllMorphs.
	self verifyBoxExtent
]

{ #category : 'factory' }
SpMorphicFrameLayoutAdapter >> removeSubWidgets [

	framePanel removeAllMorphs.
]

{ #category : 'accessing' }
SpMorphicFrameLayoutAdapter >> replace: aPresenter with: otherPresenter [

	| oldMorph newMorph |	
	oldMorph := aPresenter adapter widget.
	
	newMorph := self 
		buildMorph: otherPresenter 
		constraints: (layout constraintsFor: otherPresenter).

	framePanel replaceSubmorph: oldMorph by: newMorph
]

{ #category : 'accessing' }
SpMorphicFrameLayoutAdapter >> replace: aPresenter with: otherPresenter withConstraints: constraints [

	| oldMorph newMorph |	
	oldMorph := aPresenter adapter widget.
	
	newMorph := self 
		buildMorph: otherPresenter 
		constraints: constraints.

	framePanel replaceSubmorph: oldMorph by: newMorph
]

{ #category : 'updating' }
SpMorphicFrameLayoutAdapter >> updateSpacing [

	framePanel cellInset: layout spacing
]

{ #category : 'private' }
SpMorphicFrameLayoutAdapter >> verifyBoxExtent [

	framePanel hasSubmorphs
		ifFalse: [ widget extent: 0@0 ]
]

{ #category : 'private' }
SpMorphicFrameLayoutAdapter >> verifyBoxExtentOf: aPanel withChild: childMorph [
	| width height |

	width := childMorph width + (widget borderWidth * 2).
	height := childMorph height + (widget borderWidth * 2).

	height := height + aPanel height + aPanel cellInset.
			 
	aPanel extent: (aPanel width max: width)@(aPanel height max: height)
]

{ #category : 'private - test support' }
SpMorphicFrameLayoutAdapter >> widgetLabel [
	
	^ self widget label
]
