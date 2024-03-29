Class {
	#name : 'SpLayoutDirection',
	#superclass : 'Object',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Spec2-Layout-Base',
	#package : 'Spec2-Layout',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpLayoutDirection class >> horizontal [

	^ SpHorizontalLayoutDirection uniqueInstance
]

{ #category : 'accessing' }
SpLayoutDirection class >> uniqueInstance [ 
	
	self = SpLayoutDirection ifTrue: [ 
		self error: 'I''m abstract, use one of my children' ].
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew initialize ]
]

{ #category : 'accessing' }
SpLayoutDirection class >> vertical [

	^ SpVerticalLayoutDirection uniqueInstance
]

{ #category : 'testing' }
SpLayoutDirection >> isHorizontal [

	^ false
]

{ #category : 'testing' }
SpLayoutDirection >> isVertical [

	^ false
]

{ #category : 'factory' }
SpLayoutDirection >> newWidgetOn: anAdapter [

	^ self subclassResponsibility
]
