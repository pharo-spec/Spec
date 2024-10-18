"
An action group is a spec command group (`SpCommandGroup`) that will be used for context menus and/or shortcuts in the presenters that implement `SpTActionContainer`
"
Class {
	#name : 'SpActionGroup',
	#superclass : 'SpCommandGroup',
	#instVars : [
		'id'
	],
	#category : 'Spec2-Commander2-Action',
	#package : 'Spec2-Commander2',
	#tag : 'Action'
}

{ #category : 'instance creation' }
SpActionGroup class >> newName: aName [

	^ self new
		name: aName;
		yourself
]

{ #category : 'instance creation' }
SpActionGroup class >> newName: aName with: aBlock [
	
	^ (self newName: aName)
		in: [ :this | aBlock value: this ];
		yourself
]

{ #category : 'comparing' }
SpActionGroup >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self id = anObject id
]

{ #category : 'accessing' }
SpActionGroup >> add: anActionOrGroup [

	self register: anActionOrGroup
]

{ #category : 'accessing' }
SpActionGroup >> addActionWith: aBlock [
	| action |
	
	action := SpAction new.
	aBlock value: action.
	self add: action
]

{ #category : 'accessing' }
SpActionGroup >> addGroupWith: aBlock [
	| action |
	
	action := self class new.
	aBlock value: action.
	self add: action
		
]

{ #category : 'accessing' }
SpActionGroup >> addShortcutWith: aBlock [
	| action |
	
	action := SpAction new.
	action beShortcutOnly.
	aBlock value: action.
	self add: action
]

{ #category : 'converting' }
SpActionGroup >> asMenuPresenter [

	^ SpActionMenuPresenterBuilder new
		visit: self;
		menuPresenter
]

{ #category : 'comparing' }
SpActionGroup >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self id hash
]

{ #category : 'accessing' }
SpActionGroup >> id [

	^ id ifNil: [ id := super id ]
]

{ #category : 'initialization' }
SpActionGroup >> initialize [

	decoratedGroup := SpBaseActionGroup new.
	super initialize
]

{ #category : 'accessing' }
SpActionGroup >> remove: aCommandOrGroup [

	self unregister: aCommandOrGroup
]

{ #category : 'accessing' }
SpActionGroup >> removeAll [

	self entries copy 
		do: [ :each | self remove: each ]
	
]
