Class {
	#name : 'SpHorizontalPanedLayoutAdapterTest',
	#superclass : 'SpPanedLayoutAdapterTest',
	#category : 'Spec2-Backend-Tests-Layout',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Layout'
}

{ #category : 'accessing' }
SpHorizontalPanedLayoutAdapterTest >> newLayout [
	
	^ SpPanedLayout newLeftToRight
]
