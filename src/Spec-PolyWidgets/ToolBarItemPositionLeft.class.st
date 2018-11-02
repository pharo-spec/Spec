"
This class has a single instance representing a left item position.

Do not use the class directly, instead use:

	ITItemPosition left
"
Class {
	#name : #ToolBarItemPositionLeft,
	#superclass : #ToolBarItemPosition,
	#category : #'Spec-PolyWidgets-Toolbar'
}

{ #category : #accessing }
ToolBarItemPositionLeft >> addItem: anObject into: aToolbar [
	aToolbar addItemLeft: anObject
]
