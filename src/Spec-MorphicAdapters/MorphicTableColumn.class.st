Class {
	#name : #MorphicTableColumn,
	#superclass : #FTColumn,
	#instVars : [
		'model'
	],
	#category : #'Spec-MorphicAdapters-Table'
}

{ #category : #'instance creation' }
MorphicTableColumn class >> on: anObject [

	^ self new model: anObject
]

{ #category : #accessing }
MorphicTableColumn >> id [

	^ self model title
]

{ #category : #accessing }
MorphicTableColumn >> model [
	^ model
]

{ #category : #accessing }
MorphicTableColumn >> model: anObject [
	model := anObject
]

{ #category : #'as yet unclassified' }
MorphicTableColumn >> readObject: anObject [ 

	^ self model readObject: anObject
]
