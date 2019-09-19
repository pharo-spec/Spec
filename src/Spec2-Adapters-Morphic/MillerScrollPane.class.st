Class {
	#name : #MillerScrollPane,
	#superclass : #GeneralScrollPane,
	#instVars : [
		'layoutChangeAction'
	],
	#category : #'Spec2-Adapters-Morphic-Layout'
}

{ #category : #layout }
MillerScrollPane >> layoutChanged [

	super layoutChanged.
	layoutChangeAction ifNotNil: [ 
		layoutChangeAction value ]
]

{ #category : #'as yet unclassified' }
MillerScrollPane >> onLayoutChange: aBlock [

	layoutChangeAction := aBlock
]
