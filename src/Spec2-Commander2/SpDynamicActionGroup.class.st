"
An action group is a spec command group (`SpCommandGroup`) that will be used for dynamic context menus in the presenters that implement `SpTActionContainer`
"
Class {
	#name : 'SpDynamicActionGroup',
	#superclass : 'SpCommandGroup',
	#instVars : [
		'id',
		'dynamicBuilder'
	],
	#category : 'Spec2-Commander2-Action',
	#package : 'Spec2-Commander2',
	#tag : 'Action'
}

{ #category : 'instance creation' }
SpDynamicActionGroup class >> newName: aName [

	^ self new
		name: aName;
		yourself
]

{ #category : 'instance creation' }
SpDynamicActionGroup class >> newName: aName with: aBlock [
	
	^ (self newName: aName)
		in: [ :this | aBlock value: this ];
		yourself
]

{ #category : 'instance creation' }
SpDynamicActionGroup class >> with: aBlock [

	^ self new with: aBlock
]

{ #category : 'comparing' }
SpDynamicActionGroup >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self id = anObject id
]

{ #category : 'visiting' }
SpDynamicActionGroup >> acceptVisitor: aVisitor [

	^ aVisitor visitCommandDynamicGroup: self
]

{ #category : 'converting' }
SpDynamicActionGroup >> asMenuPresenter [

	^ SpActionMenuPresenterBuilder new
		visit: self;
		menuPresenter
]

{ #category : 'private' }
SpDynamicActionGroup >> dynamicBuilder [

	^ dynamicBuilder
]

{ #category : 'comparing' }
SpDynamicActionGroup >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self id hash
]

{ #category : 'accessing' }
SpDynamicActionGroup >> id [

	^ id ifNil: [ id := super id ]
]

{ #category : 'initialization' }
SpDynamicActionGroup >> initialize [

	decoratedGroup := SpBaseActionGroup new.
	super initialize
]

{ #category : 'accessing' }
SpDynamicActionGroup >> with: aBlock [

	dynamicBuilder := aBlock
]
