Class {
	#name : 'SpHorizontalLayoutDirection',
	#superclass : 'SpLayoutDirection',
	#category : 'Spec2-Layout-Base',
	#package : 'Spec2-Layout',
	#tag : 'Base'
}

{ #category : 'testing' }
SpHorizontalLayoutDirection >> isHorizontal [

	^ true
]

{ #category : 'factory' }
SpHorizontalLayoutDirection >> newWidgetOn: anAdapter [

	^ anAdapter newHorizontal
]
