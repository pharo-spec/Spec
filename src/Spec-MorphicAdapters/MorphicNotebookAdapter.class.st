Class {
	#name : #MorphicNotebookAdapter,
	#superclass : #AbstractMorphicAdapter,
	#instVars : [
		'isClosedHolder'
	],
	#category : #'Spec-MorphicAdapters-Base'
}

{ #category : #factory }
MorphicNotebookAdapter >> addModelTo: aNotebook [
	
	self model pages ifEmpty: [ ^ self ].
	self model pages do: [ :each |
		aNotebook 
			addLazyPage: [ each presenter buildWithSpec ] 
			label: each title ].
	aNotebook selectedPageIndex: 1
]

{ #category : #factory }
MorphicNotebookAdapter >> buildWidget [
	| notebook |

	notebook := LazyTabGroupMorph new
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		yourself.
	self addModelTo: notebook.
	^ notebook
]
