"
I'm a column for the table on a MorphicTableAdapter hierarchy.
I delegate most of my behavior to my model (which is a TableColumn* instance)
"
Class {
	#name : 'SpMorphicTableColumn',
	#superclass : 'FTColumn',
	#instVars : [
		'model',
		'addEmptySpace'
	],
	#category : 'Spec2-Adapters-Morphic-Table',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Table'
}

{ #category : 'instance creation' }
SpMorphicTableColumn class >> on: anObject [

	^ self new model: anObject
]

{ #category : 'accessing' }
SpMorphicTableColumn >> addEmptySpace [

	addEmptySpace := true
]

{ #category : 'private' }
SpMorphicTableColumn >> defaultSortFunction [

	^ [ :each | (self readObject: each) ] ascending
]

{ #category : 'private' }
SpMorphicTableColumn >> emptySpace [

	^ SpMorphicTreeTableDataSource emptyMorph width
]

{ #category : 'accessing' }
SpMorphicTableColumn >> id [ 

	^ self model title
]

{ #category : 'initialization' }
SpMorphicTableColumn >> initialize [

	super initialize.
	addEmptySpace := false
]

{ #category : 'testing' }
SpMorphicTableColumn >> isExpandable [

	^ self model isExpandable
]

{ #category : 'testing' }
SpMorphicTableColumn >> isSortable [

	^ self model isSortable
]

{ #category : 'testing' }
SpMorphicTableColumn >> isSorted [

	^ self sortingStrategy isSortingEnabled and: [ self sortingStrategy state isSorted ]
]

{ #category : 'accessing' }
SpMorphicTableColumn >> model [
	^ model
]

{ #category : 'accessing' }
SpMorphicTableColumn >> model: aTableColumn [

	model := aTableColumn.
	model isSortable ifTrue: [ 
		self sortableUsing: model sortFunction ]
]

{ #category : 'accessing' }
SpMorphicTableColumn >> readObject: anObject [ 

	^ self model readObject: anObject
]

{ #category : 'accessing' }
SpMorphicTableColumn >> sortFunction [

	^ self model sortFunction
]

{ #category : 'sorting' }
SpMorphicTableColumn >> sortableUsing: aSortFunction [

	^ super sortableUsing: (aSortFunction ifNil: [ self defaultSortFunction ])
]

{ #category : 'accessing' }
SpMorphicTableColumn >> width [
	| resultWidth |

	resultWidth := self model width ifNil: [ super width ].
	^ addEmptySpace 
		ifTrue: [ resultWidth + self emptySpace ]
		ifFalse: [ resultWidth ]
]

{ #category : 'accessing' }
SpMorphicTableColumn >> width: aNumber [
	| widthToAdd |

	aNumber ifNotNil: [ 
		widthToAdd := addEmptySpace 
			ifTrue: [ aNumber - self emptySpace ]
			ifFalse: [ aNumber ].
		(self model isExpandable and: [ aNumber notNil ])
			ifTrue: [ self model width: widthToAdd ] ].
	super width: widthToAdd
]
