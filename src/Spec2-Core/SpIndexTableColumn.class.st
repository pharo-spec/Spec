"
A column to display the row index (the row number) of the collection being shown.
This is useful to add the index information (like happens in many spreadsheets, etc.)

the row number is ""constant"", in the sense it shows the position of the element in the table (1st, 2nd...), independently of the sorting of the collection being displayed.

The user does not need to set an evaluation block for this column (as its value is taken elsewhere).

## Example
```
SpIndexTableColumn title: 'My index'
```
"
Class {
	#name : #SpIndexTableColumn,
	#superclass : #SpTableColumn,
	#category : #'Spec2-Core-Widgets-Table'
}

{ #category : #visiting }
SpIndexTableColumn >> acceptColumnVisitor: aBuilder [

	^ aBuilder visitIndexColumn: self
]
