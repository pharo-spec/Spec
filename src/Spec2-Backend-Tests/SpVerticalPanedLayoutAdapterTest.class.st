Class {
	#name : 'SpVerticalPanedLayoutAdapterTest',
	#superclass : 'SpPanedLayoutAdapterTest',
	#category : 'Spec2-Backend-Tests-Layout',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Layout'
}

{ #category : 'accessing' }
SpVerticalPanedLayoutAdapterTest >> newLayout [
	
	^ SpPanedLayout newTopToBottom
]
