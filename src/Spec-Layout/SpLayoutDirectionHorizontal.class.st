Class {
	#name : #SpLayoutDirectionHorizontal,
	#superclass : #SpLayoutDirection,
	#category : #'Spec-Layout-Base'
}

{ #category : #factory }
SpLayoutDirectionHorizontal >> newWidgetOn: anAdapter [

	^ anAdapter newHorizontal
]
