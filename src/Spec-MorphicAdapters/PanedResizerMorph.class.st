"
I'm a base splitter to be used with a SpecPanedLayout. 
Splitters can be placed vertically or horizontally and my children deal with each of the cases.
The way I work is easy: 

- I need to be placed between two other morphs.
- I also need to act inside a morph with table layout (other layours may work, but is not testes).

self exampleVertical.
self exampleHorizontal.
"
Class {
	#name : #PanedResizerMorph,
	#superclass : #AbstractResizerMorph,
	#instVars : [
		'fitTargetOwner'
	],
	#category : #'Spec-MorphicAdapters-Layout'
}

{ #category : #examples }
PanedResizerMorph class >> exampleHorizontal [
	<example>
	
	(PanelMorph new 
		changeTableLayout;
		listDirection: #leftToRight;
		addMorphBack: (Morph new 
			color: Color red;
			vResizing: #spaceFill;
			hResizing: #spaceFill;
			yourself);
		addMorphBack: self newHorizontal;
		addMorphBack: (Morph new 
			color: Color blue;
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			yourself);
		openInWindow)
		extent: 500@500
]

{ #category : #examples }
PanedResizerMorph class >> exampleVertical [
	<example>
	
	(PanelMorph new 
		changeTableLayout;
		addMorphBack: (Morph new 
			color: Color red;
			vResizing: #spaceFill;
			hResizing: #spaceFill;
			yourself);
		addMorphBack: self newVertical;
		addMorphBack: (Morph new 
			color: Color blue;
			vResizing: #spaceFill;
			hResizing: #spaceFill;
			yourself);
		openInWindow)
		extent: 500@500
]

{ #category : #'instance creation' }
PanedResizerMorph class >> new [ 
	
	self error: 'Use #newHorizonal or #newVertical'
]

{ #category : #'instance creation' }
PanedResizerMorph class >> newHorizontal [ 
	
	^ PanedResizerHorizontalMorph basicNew initialize
]

{ #category : #'instance creation' }
PanedResizerMorph class >> newVertical [
	
	^ PanedResizerVerticalMorph basicNew initialize
]

{ #category : #accessing }
PanedResizerMorph class >> splitterWidth [

	^ 4
]

{ #category : #accessing }
PanedResizerMorph >> adoptPaneColor: paneColor [
	"Change our color too."
	
	super adoptPaneColor: paneColor.
	self fillStyle: self normalFillStyle
]

{ #category : #accessing }
PanedResizerMorph >> defaultHeight [
	"Answer the default height for the receiver."
	
	^ self class splitterWidth
]

{ #category : #configuration }
PanedResizerMorph >> defaultWidth [
	"Answer the default width for the receiver."
	
	^ self class splitterWidth
]

{ #category : #accessing }
PanedResizerMorph >> edgeName [
	"Answer the value of edgeName"

	^ self subclassResponsibility
]

{ #category : #accessing }
PanedResizerMorph >> fitTargetBoundsInOwner: aRect [
	"Reset the target bounds if required to
	ensure that the owner's submorphs fit within the owner's
	exisiting bounds when layed out."
	|ownerMinExt targetOwner|
	
	targetOwner := self target owner ifNil: [^self].
	ownerMinExt :=  targetOwner minExtent.
	ownerMinExt x > self target owner width
		ifTrue: [self edgeName = #left
				ifTrue: [self target bounds: (aRect left + (ownerMinExt x - targetOwner width) @ aRect top extent: (aRect width - (ownerMinExt x - targetOwner width)) @ aRect height)]
				ifFalse: [self target bounds: (aRect origin extent: (aRect width - (ownerMinExt x - targetOwner width)) @ aRect height)]].
	ownerMinExt y > self target owner height
		ifTrue: [self edgeName = #top
				ifTrue: [self target bounds: (aRect left @ (aRect top + (ownerMinExt y - targetOwner height)) extent: aRect width @ (aRect height - (ownerMinExt y - targetOwner height)))]
				ifFalse: [self target bounds: (aRect origin extent: aRect width @ (aRect height - (ownerMinExt y - targetOwner height))) ] ]
]

{ #category : #accessing }
PanedResizerMorph >> fitTargetOwner [

	^ fitTargetOwner
]

{ #category : #accessing }
PanedResizerMorph >> fitTargetOwner: anObject [

	fitTargetOwner := anObject
]

{ #category : #accessing }
PanedResizerMorph >> gripLayoutFrame [
	"Answer the layout frame dependinbg on our edge."
	
	self subclassResponsibility
]

{ #category : #initialization }
PanedResizerMorph >> initialize [
	"Initialize the receiver."
	
	super initialize.
	self
		fitTargetOwner: false;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		setLayoutSizing;
		layoutFrame: self gripLayoutFrame;
		extent: self defaultWidth @ self defaultHeight		
]

{ #category : #testing }
PanedResizerMorph >> isHorizontal [
	"Answer true if the receiver has a horizontal layout."
	
	^ self subclassResponsibility
]

{ #category : #'event handling' }
PanedResizerMorph >> mouseDown: anEvent [
	"Remember the receiver and target offsets too."
	| cp |
	
	(self bounds containsPoint: anEvent cursorPoint)
		ifTrue: [ self fillStyle: self pressedFillStyle ].
		
	cp := anEvent cursorPoint.
	lastMouse := { cp. cp - self position. cp - self targetPoint }.
	self eventHandler ifNotNil: [ :handler |
		handler mouseDown: anEvent fromMorph: self ]
]

{ #category : #'event handling' }
PanedResizerMorph >> mouseMove: anEvent [
	"Track the mouse for resizing."
	
	self target ifNil: [ ^ self ] .
	self setTargetLayoutSizing.
	
	lastMouse at: 1 put: anEvent cursorPoint.
	self targetPoint: lastMouse first - lastMouse last.
	self positionPoint: (lastMouse first - lastMouse second)
]

{ #category : #'event handling' }
PanedResizerMorph >> mouseUp: anEvent [
	"Change the cursor back to normal if necessary and change the color back to normal."
	
	(self bounds containsPoint: anEvent cursorPoint)
		ifFalse: [ anEvent hand showTemporaryCursor: nil ].
	self adoptPaneColor: self paneColor
]

{ #category : #style }
PanedResizerMorph >> normalFillStyle [
	"Return the normal fillStyle of the receiver."
	
	^self theme splitterNormalFillStyleFor: self
]

{ #category : #accessing }
PanedResizerMorph >> positionPoint: aPoint [
	"Reposition based on ptName."
	
	^ self subclassResponsibility
]

{ #category : #style }
PanedResizerMorph >> pressedFillStyle [
	"Return the pressed fillStyle of the receiver."
	
	^ self theme splitterPressedFillStyleFor: self
]

{ #category : #actions }
PanedResizerMorph >> resizeCursor [

	^ Cursor resizeForEdge: self edgeName
]

{ #category : #private }
PanedResizerMorph >> setLayoutSizing [
	"Adjust the sizing for use within table layouts."

	self subclassResponsibility
]

{ #category : #private }
PanedResizerMorph >> setTargetBounds: aRect [
	"Set the target bounds, taking owner into account if required."

	self target bounds: aRect.
	self flag: #TODO. "What is this?"
	self fitTargetOwner ifTrue: [
		self fitTargetBoundsInOwner: aRect]
]

{ #category : #private }
PanedResizerMorph >> setTargetLayoutSizing [

	self subclassResponsibility
]

{ #category : #accessing }
PanedResizerMorph >> splitsTopAndBottom [
	"Answer true if the receiver has a horizontal layout."
	
	^ self isHorizontal
]

{ #category : #accessing }
PanedResizerMorph >> target [ 
	"answers previous morph in owners submorph list"
	
	^ self owner ifNotNil: [ :aMorph | 
		aMorph submorphs before: self ]
]

{ #category : #accessing }
PanedResizerMorph >> targetPoint [
	"Answer the reference point of the target."

	^ self target bounds pointAtSideOrCorner: self edgeName
]

{ #category : #accessing }
PanedResizerMorph >> targetPoint: aPoint [
	"Set the reference point of the target."
	| minExt rect target |
	
	target := self target.
	rect := target bounds withSideOrCorner: self edgeName setToPoint: aPoint.
	
	minExt := (target layoutPolicy notNil and: [ target layoutPolicy isTableLayout])
		ifTrue: [ target layoutPolicy minExtentOf: target in: target layoutBounds]
		ifFalse: [ target minimumExtent].
		
	rect width <= minExt x ifTrue: [
		rect withSideOrCorner: #right setToPoint: target bounds topLeft + minExt ].
	rect height <= minExt y ifTrue: [
		rect withSideOrCorner: #top setToPoint: target bounds bottomRight - minExt ].
	
	self setTargetBounds: rect
]

{ #category : #updating }
PanedResizerMorph >> themeChanged [
	"Update the fill style."

	self fillStyle: self normalFillStyle.
	super themeChanged
]
