"
A node to keep example methods.
"
Class {
	#name : 'SpExampleMethodNode',
	#superclass : 'SpExampleNode',
	#category : 'Spec2-Examples-ExampleBrowser',
	#package : 'Spec2-Examples',
	#tag : 'ExampleBrowser'
}

{ #category : 'accessing' }
SpExampleMethodNode >> iconName [

	^ #glamorousExample
]

{ #category : 'accessing' }
SpExampleMethodNode >> name [

	^ self entity selector
]

{ #category : 'updating' }
SpExampleMethodNode >> updateOn: anExampleBrowser [

	anExampleBrowser updateMethod: self entity
]
