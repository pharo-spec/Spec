"
A SpecColumnLayout is the layout used to specify a new column
"
Class {
	#name : 'SpColumnLayout',
	#superclass : 'SpLayout',
	#instVars : [
		'height'
	],
	#category : 'Spec2-Layout-Deprecated',
	#package : 'Spec2-Layout-Deprecated'
}

{ #category : 'Spec2-Deprecated' }
SpColumnLayout >> add: aSpec height: aNumber [
	
	self add: aSpec origin: 0@0 corner: 1@1 offsetOrigin: 0@0 offsetCorner: 0@aNumber 
]

{ #category : 'Spec2-Deprecated' }
SpColumnLayout >> addSplitter [

	self commands add: (SpSplitterHorizontal commands: self commands)
]

{ #category : 'Spec2-Deprecated' }
SpColumnLayout >> autoFractionComputation [
	| delta |
	delta := numberOfProportionals isZero
		ifTrue: [ 0 ]
		ifFalse: [ 1 / numberOfProportionals ].
	self commands
		doWithIndex: [ :e :idx | 
			e layoutFrame hasNoOffsets
				ifTrue: [ self setWidgetLayoutWithNoOffset: e at: idx delta: delta ]
				ifFalse: [ self setWidgetLayoutWithOffset: e at: idx ] ]
]

{ #category : 'Spec2-Deprecated' }
SpColumnLayout >> countNumberOfProportionals [

	self commands	do: [ :e | 
		e layoutFrame hasNoOffsets
			ifTrue: [ 
				(e layoutFrame topFraction == 0 and: [ e layoutFrame bottomFraction == 1 ])
					ifFalse: [ autoFractionComputation := false ].
				numberOfProportionals := numberOfProportionals + 1 ] ]
]

{ #category : 'Spec2-Deprecated' }
SpColumnLayout >> manualFractionComputation [
	
	self commands	doWithIndex: [ :e :idx | 
		e layoutFrame hasNoOffsets
			ifTrue: [  | delta |
				delta := e layoutFrame bottomFraction - e layoutFrame topFraction.
				self setWidgetLayoutWithNoOffset: e at: idx delta: delta ]
			ifFalse: [ self setWidgetLayoutWithOffset: e at: idx ] ]
]

{ #category : 'Spec2-Deprecated' }
SpColumnLayout >> privateAsArray [
	self resetArrayComputation.
	self countNumberOfProportionals.

	autoFractionComputation
		ifTrue: [ self autoFractionComputation ]
		ifFalse: [ self manualFractionComputation ].

	self shiftLastWidgets.

	^ super privateAsArray
]

{ #category : 'Spec2-Deprecated' }
SpColumnLayout >> resetArrayComputation [

	super resetArrayComputation.
	
	size := self commands size.
	numberOfProportionals := 0.
	lastFractionIndex := 0.
	autoFractionComputation := true.
	currentOffset := 0.
	currentProportional := 0
]

{ #category : 'Spec2-Deprecated' }
SpColumnLayout >> setWidgetLayoutWithNoOffset: widget at: index delta: delta [

	widget layoutFrame:
		((0 @ currentProportional corner: 1 @ (currentProportional + delta)) asSpLayoutFrame 
			topOffset: currentOffset;
			yourself).
				
	currentOffset := 0.
	currentProportional := currentProportional + delta.
	
	lastFractionIndex := index
]

{ #category : 'Spec2-Deprecated' }
SpColumnLayout >> setWidgetLayoutWithOffset: widget at: index [

	height := widget bottomOffset - widget topOffset.
	
	index = size
		ifTrue: [ 
			widget layoutFrame:
				((0 @ 1 corner: 1 @ 1) asSpLayoutFrame
					topLeftOffset: widget leftOffset @ height negated;
					bottomRightOffset: widget rightOffset @ 0) ]
		ifFalse: [ 
			widget layoutFrame:
				((0 @ currentProportional corner: 1 @ currentProportional) asSpLayoutFrame
					topLeftOffset: widget leftOffset @ currentOffset;
					bottomRightOffset: widget rightOffset @ (currentOffset + height)).
			currentOffset := currentOffset + height ]
]

{ #category : 'Spec2-Deprecated' }
SpColumnLayout >> shiftLastWidgets [
	| index ante |	
	
	(lastFractionIndex > 0 and: [ lastFractionIndex < size ]) ifFalse: [ ^ self ].
	
	index := size - 1.
	[ index > lastFractionIndex ] whileTrue: [ | myHeight |
			ante := self commands at: index.
			index := index - 1.
			myHeight := ante bottomOffset - ante topOffset.
			ante
				topOffset: (height + myHeight) negated;
				bottomOffset: height negated.
			height := height + myHeight ].
		
	self assert: index = lastFractionIndex.
	
	ante := self commands at: index.
	ante bottomOffset: height negated
]
