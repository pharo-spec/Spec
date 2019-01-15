"
I'm a composite column.
I contain other column definitions to compose a single type of column. 
Typically, I will compose images and texts (or checkbox and text, as for do a cherry pick).
"
Class {
	#name : #CompositeTableColumn,
	#superclass : #TableColumn,
	#instVars : [
		'columns'
	],
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #visiting }
CompositeTableColumn >> acceptColumnVisitor: aBuilder [

	^ aBuilder visitCompositeColumn: self
]

{ #category : #accessing }
CompositeTableColumn >> addColumn: aTableColumn [ 
	
	columns add: aTableColumn
]

{ #category : #accessing }
CompositeTableColumn >> columns [

	^ columns
]

{ #category : #initialization }
CompositeTableColumn >> initialize [
	
	super initialize.
	"there will be at least two, if it is composed :)"
	columns := OrderedCollection new: 2
]
