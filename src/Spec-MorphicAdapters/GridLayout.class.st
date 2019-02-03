Class {
	#name : #GridLayout,
	#superclass : #LayoutPolicy,
	#instVars : [
		'rowSpacing',
		'columnSpacing',
		'padding'
	],
	#category : #'Spec-MorphicAdapters-Layout'
}

{ #category : #accessing }
GridLayout >> columnSpacing [
	^ columnSpacing
]

{ #category : #accessing }
GridLayout >> columnSpacing: anObject [
	columnSpacing := anObject
]

{ #category : #initialization }
GridLayout >> initialize [

	super initialize.
	self padding: 0.
	self columnSpacing: 0.
	self rowSpacing: 0
]

{ #category : #layout }
GridLayout >> isComputedSize: aNumber ifNot: aBlock [
	
	^ aNumber = 0 
		ifTrue: aBlock 
		ifFalse: [ aNumber ]
]

{ #category : #layout }
GridLayout >> layout: aMorph in: aRect [
	| morphs numRows numColumns innerBounds rowHeights columnWidths rowPositions columnPositions cellExtents origin |
	
	morphs := aMorph submorphs.
	
	numRows := 0.
	numColumns := 0.
	morphs
		collect: #layoutProperties 
		thenDo: [ :each |
			numRows := numRows max: (each row + each rowSpan - 1).
			numColumns := numColumns max: (each column + each columnSpan - 1) ].
		
	innerBounds := aRect insetBy: self padding.
	
	"Collect actual widget sizes"
	rowHeights := Array new: numRows withAll: 0.
	columnWidths := Array new: numColumns withAll: 0.
	morphs do: [ :each | | properties |
		properties := each layoutProperties.
		rowHeights 
			at: properties row 
			put: ((rowHeights at: properties row) max: each height).
		columnWidths 
			at: properties column
			put: ((columnWidths at: properties column) max: each width) ].	

	"Calculate row positions"
	rowPositions := Array new: numRows.	
	rowPositions at: 1 put: 0.
	2 to: numRows do: [ :index | 
		rowPositions 
			at: index 
			put: (rowPositions at: index - 1) + (rowHeights at: index - 1) + self rowSpacing ].
	"Calculate columns positions"
	columnPositions := Array new: numColumns.
	columnPositions at: 1 put: 0.
	2 to: numColumns do: [ :index |
		columnPositions 
			at: index 
			put: (columnPositions at: index - 1) + (columnWidths at: index - 1) + self columnSpacing ].
	"Calculate cell extents"
	cellExtents := SmallDictionary new.
	morphs 
		collect: #layoutProperties 
		thenDo: [ :constraint | | w h |
			w := (columnWidths 
				copyFrom: constraint column 
				to: constraint column + constraint columnSpan - 1) 
				sum.
			h := (rowHeights 
				copyFrom: constraint row 
				to: constraint row + constraint rowSpan - 1) 
				sum.
		cellExtents 
			at: constraint position 
			put: w@h ].
	
	"Calculate the origin taking alignment into account"
	origin := innerBounds origin.
	"Now calculate the bounds for each widget"
	morphs do: [ :each | | constraint pos extent |
		constraint := each layoutProperties.
		pos := origin + ((columnPositions at: constraint column)@(rowPositions at: constraint row)).
		"if widget is resizable, it will take all the available space. 
		 if widget is not resizable, we need to take into account its alignment constraint, since it 
		 can be placed differently."
		((each hResizing = #spaceFill) and: [ each vResizing = #spaceFill ]) 
			ifTrue: [ 
				extent := cellExtents at: constraint position ]
			ifFalse: [ | cellExtent width height |
				cellExtent := (cellExtents at: constraint position). 
				width := self isComputedSize: each width ifNot: [ cellExtent x ].
				height := self isComputedSize: each width ifNot: [ cellExtent y ].
				extent := width@height.
				pos := pos + cellExtent ].
		each privateBounds: (pos extent: extent) ]
]

{ #category : #accessing }
GridLayout >> padding [

	^ padding
]

{ #category : #accessing }
GridLayout >> padding: anObject [
	padding := anObject
]

{ #category : #accessing }
GridLayout >> rowSpacing [
	^ rowSpacing
]

{ #category : #accessing }
GridLayout >> rowSpacing: anObject [
	rowSpacing := anObject
]
