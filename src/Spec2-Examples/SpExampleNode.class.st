"
An example node, we use a tree to show examples, hence we need this as normalisation.
"
Class {
	#name : 'SpExampleNode',
	#superclass : 'Object',
	#instVars : [
		'entity'
	],
	#category : 'Spec2-Examples-ExampleBrowser',
	#package : 'Spec2-Examples',
	#tag : 'ExampleBrowser'
}

{ #category : 'accessing' }
SpExampleNode class >> allExampleClasses [

	^ (SpPresenter withAllSubclasses
		select: [ :eachClass |
			(eachClass package name beginsWith: 'Spec2-')
			and: [
				eachClass class selectors
					anySatisfy: [ :each | each beginsWith: 'example' ] ] ]
		thenCollect: [ :each | SpExampleClassNode newEntity: each ])
		sorted: #name ascending
]

{ #category : 'instance creation' }
SpExampleNode class >> newEntity: anObject [

	^ self new entity: anObject
]

{ #category : 'accessing' }
SpExampleNode >> children [

	^ #()
]

{ #category : 'accessing' }
SpExampleNode >> entity [

	^ entity
]

{ #category : 'accessing' }
SpExampleNode >> entity: anObject [

	entity := anObject
]

{ #category : 'accessing' }
SpExampleNode >> iconName [

	^ nil
]

{ #category : 'accessing' }
SpExampleNode >> name [

	^ self subclassResponsibility
]

{ #category : 'updating' }
SpExampleNode >> updateOn: anExampleBrowser [

	self subclassResponsibility
]
