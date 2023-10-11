Class {
	#name : 'SpVerticalBoxLayoutAdapterTest',
	#superclass : 'SpBoxLayoutAdapterTest',
	#category : 'Spec2-Backend-Tests-Layout',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Layout'
}

{ #category : 'accessing' }
SpVerticalBoxLayoutAdapterTest >> newLayout [

	^ SpBoxLayout newTopToBottom
]
