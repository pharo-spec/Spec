Class {
	#name : #MorphicBoxAdapter,
	#superclass : #AbstractMorphicAdapter,
	#category : #'Spec-MorphicAdapters-Base'
}

{ #category : #factory }
MorphicBoxAdapter >> add: aPresenter constraints: constraints [
 
	self widgetDo: [ :aPanel | 
		self 
			basicAdd: aPresenter 
			constaints: constraints 
			to: aPanel ]
]

{ #category : #private }
MorphicBoxAdapter >> addConstraits: constraints toChild: childMorph [
	"adds constraits by child"
	
	constraints isExpand ifTrue: [ childMorph hResizing: #spaceFill ].
	"constraints isFill ifTrue: [  ] ?"
	"constraints padding"
]

{ #category : #private }
MorphicBoxAdapter >> basicAdd: aPresenter constaints: constraints to: aPanel [
	| childMorph |

	childMorph := aPresenter buildWithSpec.
	self addConstraits: constraints toChild: childMorph.
	constraints isPlacedAtStart
		ifTrue: [ aPanel addMorphFront: childMorph ]
		ifFalse: [ aPanel addMorphBack: childMorph ]
]

{ #category : #factory }
MorphicBoxAdapter >> buildWidget [

	^ nil
]

{ #category : #factory }
MorphicBoxAdapter >> layout: aLayout [

	"build of widget was differed up to here (to know what is the direction)"
	widget := aLayout direction newWidgetOn: self.
	widget 
		borderWidth: aLayout borderWidth;
		cellInset: aLayout spacing.
	
	"widget homogeneous: aLayout isHomogeneous"
]

{ #category : #factory }
MorphicBoxAdapter >> newHorizontal [

	^ self newPanel 
		listDirection: #leftToRight;
		yourself	
]

{ #category : #factory }
MorphicBoxAdapter >> newPanel [

	^ PanelMorph new 
		changeTableLayout;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		color: Color transparent;
		yourself	
]

{ #category : #factory }
MorphicBoxAdapter >> newVertical [

	^ self newPanel 
		listDirection: #topToBottom;
		yourself	
]
