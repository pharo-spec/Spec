Class {
	#name : #SpLayoutDirectionVertical,
	#superclass : #SpLayoutDirection,
	#category : #'Spec-Layout-Base'
}

{ #category : #factory }
SpLayoutDirectionVertical >> newWidgetOn: anAdapter [

	^ anAdapter newVertical
]
