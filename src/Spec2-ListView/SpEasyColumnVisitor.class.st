"
A visitor for `SpTableColumn`. 
This is uset to convert `SpTableColumn` into `SpColumnViewColumn` (needed to adapt the ""easy"" compatibility classes)
"
Class {
	#name : 'SpEasyColumnVisitor',
	#superclass : 'Object',
	#instVars : [
		'presenter'
	],
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

{ #category : 'accessing' }
SpEasyColumnVisitor >> presenter [

	^ presenter
]

{ #category : 'accessing' }
SpEasyColumnVisitor >> presenter: aPresenter [

	presenter := aPresenter
]

{ #category : 'visiting' }
SpEasyColumnVisitor >> visit: aColumn [

	^ aColumn acceptColumnVisitor: self
]

{ #category : 'visiting' }
SpEasyColumnVisitor >> visitCheckboxColumn: aColumn [

	^ self visitStringColumn: aColumn
]

{ #category : 'visiting' }
SpEasyColumnVisitor >> visitCompositeColumn: aColumn [

	^ self visitStringColumn: aColumn
]

{ #category : 'visiting' }
SpEasyColumnVisitor >> visitDropListColumn: aColumn [

	^ self visitStringColumn: aColumn
]

{ #category : 'visiting' }
SpEasyColumnVisitor >> visitImageColumn: aColumn [

	^ self visitStringColumn: aColumn
]

{ #category : 'visiting' }
SpEasyColumnVisitor >> visitIndexColumn: aColumn [

	^ self visitStringColumn: aColumn
]

{ #category : 'visiting' }
SpEasyColumnVisitor >> visitLinkColumn: aColumn [

	^ self visitStringColumn: aColumn
]

{ #category : 'visiting' }
SpEasyColumnVisitor >> visitStringColumn: aColumn [

	^ self subclassResponsibility
]
