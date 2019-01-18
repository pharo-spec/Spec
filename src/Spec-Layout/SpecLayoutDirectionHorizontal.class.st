Class {
	#name : #SpecLayoutDirectionHorizontal,
	#superclass : #SpecLayoutDirection,
	#category : #'Spec-Layout-Box'
}

{ #category : #factory }
SpecLayoutDirectionHorizontal >> newWidgetOn: anAdapter [

	^ anAdapter newHorizontal
]
