Class {
	#name : #SpMorphicPatchLineDecorator,
	#superclass : #RubParagraphDecorator,
	#instVars : [
		'adapter'
	],
	#category : #'Spec2-Code-Morphic-Diff'
}

{ #category : #querying }
SpMorphicPatchLineDecorator class >> key [
	^ #patchLineDecorator
]

{ #category : #accessing }
SpMorphicPatchLineDecorator >> adapter [

	^ adapter
]

{ #category : #accessing }
SpMorphicPatchLineDecorator >> adapter: anAdapter [

	adapter := anAdapter
]

{ #category : #drawing }
SpMorphicPatchLineDecorator >> drawOn: aCanvas [ 
	| lines |

	lines := self paragraph lines.
	self adapter lineMarks do: [ :each | | line bounds | 
		line := lines at: each key.
		bounds := (line topLeft - (self margins left @ 0)) 
			corner: (line bottomRight + (self margins right @ 0)).
		aCanvas 
			fillRectangle: bounds 
			color: (self markAt: each value) backgroundColor ]
]

{ #category : #accessing }
SpMorphicPatchLineDecorator >> markAt: aSymbol [

	^ self adapter markAt: aSymbol
]
