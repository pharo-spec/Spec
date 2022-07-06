"
A column that displays images.

The user need to set the evaluation block (by sending `SpTableColumn>>#evaluated:`) to answer an image (an instance of `Form`).

## Example
```
SpImageTableColumn 
	title: 'My Image' 
	evaluated: [ :anObject | anObject systemIcon ]
```
"
Class {
	#name : #SpImageTableColumn,
	#superclass : #SpTableColumn,
	#category : #'Spec2-Core-Widgets-Table'
}

{ #category : #examples }
SpImageTableColumn class >> example [

	SpTablePresenter new
		addColumn:
			((SpImageTableColumn title: 'Icon' evaluated: #systemIcon)
				width: 50;
				yourself);
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		items: self class environment allClasses;
		beResizable;
		open.
]

{ #category : #visiting }
SpImageTableColumn >> acceptColumnVisitor: aBuilder [

	^ aBuilder visitImageColumn: self
]
