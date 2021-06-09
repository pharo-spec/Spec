Class {
	#name : #SpVerticalBoxLayoutAdapterTest,
	#superclass : #SpBoxLayoutAdapterTest,
	#category : #'Spec2-Backend-Tests-Layout'
}

{ #category : #accessing }
SpVerticalBoxLayoutAdapterTest >> newLayout [

	^ SpBoxLayout newTopToBottom
]
