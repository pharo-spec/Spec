"
A SpecPresenter is a object used to describe a user interface
"
Class {
	#name : #SpLayout,
	#superclass : #SpLegacyLayout,
	#instVars : [
		'type',
		'commands',
		'currentOffset',
		'currentProportional',
		'numberOfProportionals',
		'lastFractionIndex',
		'autoFractionComputation',
		'size',
		'selector'
	],
	#category : #'Spec2-Layout-Deprecated'
}

{ #category : #'instance creation' }
SpLayout class >> composed [

	^self new
		type: #SpContainerPresenter;
		yourself
]

{ #category : #constants }
SpLayout class >> windowBorderWidth [

	^ 0
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: aSpec [ 
	
	self add: aSpec origin: 0@0 corner: 1@1
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: aBlock bottom: aNumber [
	
	self add: aBlock top: nil bottom: aNumber left: nil right: nil
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: aBlock left: aNumber [
	
	self add: aBlock top: nil bottom: nil left: aNumber right: nil
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: aBlock left: left right: right [
	
	self add: aBlock top: nil bottom: nil left: left right: right
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: aSpec origin: originPoint corner: cornerPoint [ 

	self add: aSpec origin: originPoint corner: cornerPoint offsetOrigin: 0@0 offsetCorner: 0@0
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: aSpec origin: originPoint corner: cornerPoint offsetOrigin: ooPoint offsetCorner: ocPoint [
	
	commands add: (SpLayoutAdd 
							subwidget: aSpec
							layoutFrame: 
								((originPoint corner: cornerPoint) asSpLayoutFrame 
									topLeftOffset: ooPoint;
									bottomRightOffset: ocPoint ))
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: aBlock right: aNumber [
	
	self add: aBlock top: nil bottom: nil left: nil right: aNumber
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: aBlock top: aNumber [

	self add: aBlock top: aNumber bottom: nil left: nil right: nil
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: aBlock top: top bottom: bottom [
	
	self add: aBlock top: top bottom: bottom left: nil right: nil
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: aBlock top: top bottom: bottom left: left right: right [
	| layout |
	
	layout := self computeLayoutFromTop: top bottom: bottom left: left right: right.
		
	self 
		add: aBlock
		origin: layout first
		corner: layout second
		offsetOrigin: layout third
		offsetCorner: layout fourth
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: modelGetter withSpec: aSymbol [ 
	
	self add: modelGetter withSpec: aSymbol origin: 0@0 corner: 1@1
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: aBlock withSpec: aSpec bottom: aNumber [
	
	self add: aBlock withSpec: aSpec top: nil bottom: aNumber left: nil right: nil
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: aBlock withSpec: aSpec left: aNumber [
	
	self add: aBlock withSpec: aSpec top: nil bottom: nil left: aNumber right: nil
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: aBlock withSpec: aSpec left: left right: right [
	
	self add: aBlock withSpec: aSpec top: nil bottom: nil left: left right: right
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: modelGetter withSpec: aSymbol origin: originPoint corner: cornerPoint [ 

	self add: modelGetter withSpec: aSymbol origin: originPoint corner: cornerPoint offsetOrigin: 0@0 offsetCorner: 0@0
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: modelGetter withSpec: aSymbol origin: originPoint corner: cornerPoint offsetOrigin: ooPoint offsetCorner: ocPoint [

	commands add: (SpLayoutAddWithSpec 
							subwidget: modelGetter 
							spec: aSymbol 
							layoutFrame: ((originPoint corner: cornerPoint) asSpLayoutFrame 
												topLeftOffset: ooPoint;
												bottomRightOffset: ocPoint))
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: aBlock withSpec: aSpec right: aNumber [
	
	self add: aBlock withSpec: aSpec top: nil bottom: nil left: nil right: aNumber
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: aBlock withSpec: aSpec top: aNumber [
	
	self add: aBlock withSpec: aSpec top: aNumber bottom: nil left: nil right: nil
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: aBlock withSpec: aSpec top: top bottom: bottom [
	
	self add: aBlock withSpec: aSpec top: top bottom: bottom left: nil right: nil
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> add: aBlock withSpec: aSpec top: top bottom: bottom left: left right: right [
	| layout |
	
	layout := self computeLayoutFromTop: top bottom: bottom left: left right: right.
		
	self 
		add: aBlock
		withSpec: aSpec 
		origin: layout first
		corner: layout second
		offsetOrigin: layout third
		offsetCorner: layout fourth
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> addHSplitter [

	self commands add: (SpSplitterHorizontal commands: self commands)
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> addSpacer [
	self add: #specSpacer
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> addVSplitter [

	self commands add: (SpSplitterVertical commands: self commands)
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> asArray [
	^ (OrderedCollection new
		add: self type;
		addAll: self privateAsArray;
		yourself) asArray
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> asSpLayout [

	^ self
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> commands [
	^ commands
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> commands: anObject [
	commands := anObject
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> computeLayoutFromTop: top bottom: bottom left: left right: right [
	| originY offsetCornerX cornerX offsetOriginY offsetCornerY cornerY originX offsetOriginX |
	
	originX := left isFloat
		ifTrue: [ left ]
		ifFalse: [ 0 ].
	originY := top isFloat
		ifTrue: [ top ]
		ifFalse: [ 0 ].
	cornerX := right isFloat
		ifTrue: [ 1 - right ]
		ifFalse: [ 1 ].
	cornerY := bottom isFloat
		ifTrue: [ 1 - bottom ]
		ifFalse: [ 1 ].
	offsetOriginX := left isInteger
		ifTrue: [ left ]
		ifFalse: [ 0 ].
	offsetOriginY := top isInteger
		ifTrue: [ top ]
		ifFalse: [ 0 ].
	offsetCornerX := right isInteger
		ifTrue: [ right negated ]
		ifFalse: [ 0 ].
	offsetCornerY := bottom isInteger
		ifTrue: [ bottom negated ]
		ifFalse: [ 0 ].
		
	^ { originX@originY. cornerX@cornerY. offsetOriginX@offsetOriginY. offsetCornerX@offsetCornerY }
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> computeNonSplitterWidgetsIn: result [
	(self commands reject: #isSplitter)
		do: [ :widget | 
			self
				setOffsetsFor: widget
				top: widget topOffset
				left: widget leftOffset
				bottom: widget bottomOffset
				right: widget rightOffset
				borderWidth: self class windowBorderWidth.
			result addAll: widget asSpecElements ]
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> computeSplittersIn: result [
	(self commands select: #isSplitter)
		ifNotEmpty: [ :spliters | 
			spliters do: [ :spliter | result addAll: spliter asSpecElements ].
			result add: #checkSplitters ]
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> initialize [ 
	super initialize.
	
	type := #SpContainerPresenter.
	self commands: OrderedCollection new.
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> isExecutable [
	"If the spec layout is executable, the interpreter will try to execute it directly (without 
	 interpreting it)"

	^ false
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> newColumn: aBlock [ 
	
	self newColumn: aBlock origin: 0@0 corner: 1@1
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> newColumn: aBlock left: aNumber [
	
	self newColumn: aBlock left: aNumber right: nil
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> newColumn: aBlock left: left right: right [
	| layout |
	
	layout := self computeLayoutFromTop: nil bottom: nil left: left right: right.

	self 
		newColumn: aBlock
		origin: layout first
		corner: layout second
		offsetOrigin: layout third
		offsetCorner: layout fourth
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> newColumn: aBlock origin: originPoint corner: cornerPoint [ 

	self newColumn: aBlock origin: originPoint corner: cornerPoint offsetOrigin: 0@0 offsetCorner: 0@0
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> newColumn: aBlock origin: originPoint corner: cornerPoint offsetOrigin: ooPoint offsetCorner: ocPoint [
	| block |
	
	block := aBlock.
	block isBlock ifFalse: [ block := [:c | c add: aBlock ] ].
	
	commands add: (SpLayoutAddColumn
							block: block
							layoutFrame: ((originPoint corner: cornerPoint) asSpLayoutFrame
										topLeftOffset: ooPoint;
										bottomRightOffset: ocPoint)).
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> newColumn: aBlock right: aNumber [
	
	self newColumn: aBlock left: nil right: aNumber
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> newColumn: aBlock  width: aNumber [
	
	self newColumn: aBlock  origin: 0@0 corner: 0@1 offsetOrigin: 0@0 offsetCorner: aNumber @0
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> newRow: aBlock [ 
	
	self newRow: aBlock origin: 0@0 corner: 1@1
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> newRow: aBlock bottom: aNumber [
	
	self newRow: aBlock top: nil bottom: aNumber
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> newRow: aBlock height: aNumber [
	
	self newRow: aBlock origin: 0@0 corner: 1@0 offsetOrigin: 0@0 offsetCorner: 0@aNumber 
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> newRow: aBlock origin: originPoint corner: cornerPoint [ 

	self newRow: aBlock origin: originPoint corner: cornerPoint offsetOrigin: 0@0 offsetCorner: 0@0
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> newRow: aBlock origin: originPoint corner: cornerPoint offsetOrigin: ooPoint offsetCorner: ocPoint [
	| block |
	
	block := aBlock.
	block isBlock ifFalse: [ block := [:r | r add: aBlock ] ].
	
	commands add: (SpLayoutAddRow
							block: block
							layoutFrame: ((originPoint corner: cornerPoint) asSpLayoutFrame 
										topLeftOffset: ooPoint;
										bottomRightOffset: ocPoint)).
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> newRow: aBlock top: aNumber [
	
	self newRow: aBlock top: aNumber bottom: nil
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> newRow: aBlock top: top bottom: bottom [
	| layout |
	
	layout := self computeLayoutFromTop: top bottom: bottom left: nil right: nil.
		
	self 
		newRow: aBlock
		origin: layout first
		corner: layout second
		offsetOrigin: layout third
		offsetCorner: layout fourth
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> privateAsArray [
	| result |
	result := OrderedCollection new.
	
	self resetArrayComputation.
	
	self computeNonSplitterWidgetsIn: result.
	self computeSplittersIn: result.
	
	^ result asArray
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> resetArrayComputation [
	"Do nothing here"
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> selector [
	^ selector
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> selector: aSymbol [
	selector := aSymbol
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> send: aSelector [
	
	self send: aSelector withArguments: #()
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> send: aSelector withArguments: arguments [
	self commands add: (SpLayoutSend selector: aSelector)
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> setBottomOffset: bottom for: widget borderWidth: windowBorderWidth [

	widget bottomFraction = 1
		ifTrue: [ 
			bottom isZero
				ifTrue: [ widget bottomOffset: windowBorderWidth negated ]
				ifFalse: [ widget bottomOffset: bottom - self splitterWidth ] ]
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> setLeftOffset: left for: widget borderWidth: windowBorderWidth [

	widget leftFraction = 0
		ifTrue: [ 
			left isZero
				ifTrue: [ widget leftOffset: windowBorderWidth ]
				ifFalse: [ widget leftOffset: left + self splitterWidth ] ]
		ifFalse: [ 
			widget leftFraction = 1
				ifFalse: [ widget leftOffset: left + self splitterWidth ] ]
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> setOffsetsFor: widget top: top left: left bottom: bottom right: right borderWidth: windowBorderWidth [

	self setRightOffset: right for: windowBorderWidth borderWidth: widget.
	self setLeftOffset: left for: widget borderWidth: windowBorderWidth.
	self setBottomOffset: bottom for: widget borderWidth: windowBorderWidth.
	self setTopOffset: top for: widget borderWidth: windowBorderWidth
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> setRightOffset: right for: windowBorderWidth borderWidth: widget [

	widget rightFraction = 1
		ifTrue: [ 
			right isZero
				ifTrue: [ widget rightOffset: windowBorderWidth negated ]
				ifFalse: [ widget rightOffset: right - self splitterWidth ] ]
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> setTopOffset: top for: widget borderWidth: windowBorderWidth [

	widget topFraction = 0
		ifTrue: [
			top isZero
				ifTrue: [ widget topOffset: windowBorderWidth ]
				ifFalse: [ widget topOffset: top + self splitterWidth ] ]
		ifFalse: [ 
			widget topFraction = 1
				ifFalse: [ widget topOffset: top + self splitterWidth ] ]
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> splitterWidth [
	
	^ 4
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> type [
	^ type
]

{ #category : #'Spec2-Deprecated' }
SpLayout >> type: anObject [
	type := anObject
]
