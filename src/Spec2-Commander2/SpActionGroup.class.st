"
An action group is a spec command group (`SpCommandGroup`) that will be used for context menus and/or shortcuts in the presenters that implement `SpTActionContainer`
"
Class {
	#name : 'SpActionGroup',
	#superclass : 'SpCommandGroup',
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

{ #category : 'initialization' }
SpActionGroup >> initialize [

	decoratedGroup := SpBaseActionGroup new.
	super initialize
]
