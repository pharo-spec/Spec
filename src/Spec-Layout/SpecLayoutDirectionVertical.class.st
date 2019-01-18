Class {
	#name : #SpecLayoutDirectionVertical,
	#superclass : #SpecLayoutDirection,
	#category : #'Spec-Layout-Box'
}

{ #category : #factory }
SpecLayoutDirectionVertical >> newWidgetOn: anAdapter [

	^ anAdapter newVertical
]
