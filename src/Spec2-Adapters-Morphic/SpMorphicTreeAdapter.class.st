Class {
	#name : #SpMorphicTreeAdapter,
	#superclass : #SpMorphicTreeTableAdapter,
	#category : #'Spec2-Adapters-Morphic-Table'
}

{ #category : #factory }
SpMorphicTreeAdapter >> columns [
	
	^ #()
]

{ #category : #factory }
SpMorphicTreeAdapter >> defaultColumn [
	| column |

	column := SpStringTableColumn evaluated: self presenter display.	
	
	self presenter displayColor 
		ifNotNil: [ :aBlock | column displayColor: aBlock ].
	self presenter displayBold
		ifNotNil: [ :aBlock | column displayBold: aBlock ].
	self presenter displayItalic
		ifNotNil: [ :aBlock | column displayItalic: aBlock ].
	self presenter displayUnderline
		ifNotNil: [ :aBlock | column displayUnderline: aBlock ].
	self presenter displayBackgroundColor 
		ifNotNil: [ :aBlock | column displayBackgroundColor: aBlock ].

	^ self presenter displayIcon 
		ifNotNil: [ :iconBlock |
			SpCompositeTableColumn new 
				addColumn: (SpImageTableColumn evaluated: iconBlock) beNotExpandable;
				addColumn: column;
				yourself ]
		ifNil: [ column ]
]

{ #category : #factory }
SpMorphicTreeAdapter >> ensureAtLeastOneColumnIn: tableMorph [

	tableMorph addColumn: (self newColumnFrom: self defaultColumn)
]

{ #category : #factory }
SpMorphicTreeAdapter >> registerColumnsChangedEventTo: tableMorph [
]
