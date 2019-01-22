Class {
	#name : #MorphicBoxAdapter,
	#superclass : #MorphicLayoutAdapter,
	#category : #'Spec-MorphicAdapters-Layout'
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
	| theMorph |
	
	theMorph := childMorph.
	constraints isExpand 
		ifTrue: [ 
			"if is not 'fill', in fact I need to pad it with another (since it 'expands', 
			 but does not 'fills')"
			constraints isFill ifFalse: [ 
				theMorph
					hResizing: #rigid;
					vResizing: #rigid.
				theMorph := self newPanel
					addMorphBack: theMorph;
					yourself ]. 
			"Set to fill"
			theMorph 
				hResizing: #spaceFill;
				vResizing: #spaceFill ]
		ifFalse: [
			"Set morph to stay rigid"
			self flag: #TODO. "This works for vertical but has to be inversed for horizontal"
			theMorph 
				hResizing: #spaceFill; 
				vResizing: #rigid.
			constraints minWidth ifNotNil: [ :w | theMorph width: w ].
			constraints minHeight ifNotNil: [ :h | theMorph height: h ] ].
	"constraints padding"
	
	^ theMorph 
]

{ #category : #private }
MorphicBoxAdapter >> basicAdd: aPresenter constaints: constraints to: aPanel [
	| childMorph |

	childMorph := self addConstraits: constraints toChild: aPresenter buildWithSpec.
	constraints isPlacedAtStart
		ifTrue: [ aPanel submorphs first addMorphBack: childMorph ]
		ifFalse: [ aPanel submorphs second addMorphBack: childMorph ]
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
		addMorphBack: (self newPanel
			listDirection: #leftToRight;
			yourself);
		addMorphBack: (self newPanel
			listDirection: #leftToRight;
			hResizing: #shrinkWrap;
			width: 0;
			yourself);
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
		addMorphBack: (self newPanel
			listDirection: #topToBottom;
			yourself);
		addMorphBack: (self newPanel
			listDirection: #topToBottom;
			vResizing: #shrinkWrap;
			height: 0;
			yourself);
		yourself	
]
