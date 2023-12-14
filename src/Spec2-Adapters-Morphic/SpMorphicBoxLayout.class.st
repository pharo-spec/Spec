"
I am the layout to be applied to the morph that represents a ""Box Layout"" (See `SpMorphicBoxAdapter`). 

If layout is homogeneous, it does a first pass to distribute size homogeneously (but it respects `minWidth`/`minHeight`).
To calculate the size, it relies in one of the `SpMorphicBoxLayoutCalculator` children, which are refacctored versions of what was found in the original `TableLayout`.
**NOTE:** The refactor is ""ongoing"", since I do not have time to do it properly. I just started to understand what is made there and I have no much time to spend on it right now. 

To improve performance, it prevents recursive calls on it while it is still calculating. 
"
Class {
	#name : 'SpMorphicBoxLayout',
	#superclass : 'SpMorphicBaseBoxLayout',
	#instVars : [
		'calculating'
	],
	#category : 'Spec2-Adapters-Morphic-Layout',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Layout'
}

{ #category : 'initialization' }
SpMorphicBoxLayout >> initialize [

	super initialize.
	calculating := false
]

{ #category : 'layout' }
SpMorphicBoxLayout >> layout: aMorph in: aRect [

	calculating ifTrue: [ ^ self ].
	[
		calculating := true. 
		self isHomogeneous 
			ifTrue: [ self layoutHomogeneous: aMorph in: aRect ].
		super layout: aMorph in: aRect ]
	ensure: [
		calculating := false ]
]
