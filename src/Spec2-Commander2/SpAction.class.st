"
An action is a spec command (`SpCommand`) that will be used for context menus and/or shortcuts in the presenters that implement `SpTActionContainer`
"
Class {
	#name : 'SpAction',
	#superclass : 'SpCommand',
	#instVars : [
		'action',
		'actionEnabled',
		'visible',
		'actionVisible',
		'id',
		'dynamicName'
	],
	#category : 'Spec2-Commander2-Action',
	#package : 'Spec2-Commander2',
	#tag : 'Action'
}

{ #category : 'instance creation' }
SpAction class >> newName: aName action: aBlock [

	^ self new 
		name: aName;
		action: aBlock;
		yourself
]

{ #category : 'instance creation' }
SpAction class >> newName: aName shortcutKey: aShortcut action: aBlock [

	^ self new 
		name: aName;
		shortcutKey: aShortcut;
		action: aBlock;
		yourself
]

{ #category : 'instance creation' }
SpAction class >> newShortcutKey: aShortcut action: aBlock [
	"action without menu entry"
	
	^ self new 
		beShortcutOnly;
		shortcutKey: aShortcut;
		action: aBlock;
		yourself
]

{ #category : 'comparing' }
SpAction >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self id = anObject id
]

{ #category : 'accessing' }
SpAction >> action: aBlock [

	action := aBlock
]

{ #category : 'accessing' }
SpAction >> actionEnabled: aBlock [

	actionEnabled := aBlock
]

{ #category : 'accessing' }
SpAction >> actionVisible: aBlock [

	actionVisible := aBlock
]

{ #category : 'accessing' }
SpAction >> beShortcutOnly [

	visible := false
]

{ #category : 'accessing' }
SpAction >> beToggleButton [

	self configureAsToolBarToggleButton
]

{ #category : 'testing' }
SpAction >> canBeExecuted [

	actionEnabled ifNil: [ ^ true ].
	^ actionEnabled cull: self context
]

{ #category : 'accessing' }
SpAction >> dynamicName [

	^ dynamicName 
		ifNotNil: [ :aBlock | aBlock value ]
		ifNil: [ super dynamicName ]
]

{ #category : 'accessing' }
SpAction >> dynamicName: aBlock [

	"since name works also as identifier, we need one"
	self name 
		ifNil: [ self name:  'dynamic-', UUID new asString ]. 
	dynamicName := aBlock
]

{ #category : 'executing' }
SpAction >> execute [
	
	action ifNil: [ ^ self ].
	self canBeExecuted ifFalse: [ ^ self ].

	action cull: self context
]

{ #category : 'comparing' }
SpAction >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self id hash
]

{ #category : 'private' }
SpAction >> id [

	^ id ifNil: [ id := super id ]
]

{ #category : 'initialization' }
SpAction >> initialize [

	decoratedCommand := CmCommand new.
	decoratedCommand name: nil.
	visible := true.
	super initialize.
	 
]

{ #category : 'testing' }
SpAction >> isVisible [

	^ visible 
		and: [ actionVisible isNil or: [ actionVisible value ] ]
]

{ #category : 'printing' }
SpAction >> printOn: stream [

	stream << 'a SpAction('.
	stream << 'Name: ' << (self name ifNil: [ 'No name' ]).
	stream << ' Shortcut: ' << (self shortcutKey 
		ifNotNil: [ :key | key asString ] 
		ifNil: [ 'No shortcut' ]).
	stream << ')'
]

{ #category : 'accessing' }
SpAction >> shortcut: aKeyCombination [

	self 
		deprecated: 'It was a bad idea' 
		transformWith: '@receiver shortcut: `@arg1' -> '@receiver shortcutKey: `@arg1'.	
	self shortcutKey: aKeyCombination
]
