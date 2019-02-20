Class {
	#name : #SpecLabel,
	#superclass : #Object,
	#instVars : [
		'label'
	],
	#category : #'Spec-Layout-Examples'
}

{ #category : #'instance creation' }
SpecLabel class >> label: aString [

	^ self new label: aString
]

{ #category : #'as yet unclassified' }
SpecLabel >> asPresenter [
	
	^ LabelPresenter new
		label: self label;
		yourself
]

{ #category : #accessing }
SpecLabel >> label [
	^ label
]

{ #category : #accessing }
SpecLabel >> label: anObject [
	label := anObject
]
