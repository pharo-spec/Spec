"
A node to keep classes.
"
Class {
	#name : #SpExampleClassNode,
	#superclass : #SpExampleNode,
	#category : #'Spec2-Examples-ExampleBrowser'
}

{ #category : #accessing }
SpExampleClassNode >> children [

	^ (self entity class methods
		select: [ :each | each selector beginsWith: 'example' ]
		thenCollect: [ :each | SpExampleMethodNode newEntity: each ])
		sorted: #name ascending
]

{ #category : #accessing }
SpExampleClassNode >> iconName [

	^ self entity systemIconName
]

{ #category : #accessing }
SpExampleClassNode >> name [

	^ self entity name
]

{ #category : #updating }
SpExampleClassNode >> updateOn: anExampleBrowser [

	anExampleBrowser updateClass: self entity
]
