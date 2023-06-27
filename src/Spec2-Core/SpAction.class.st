"
An action is a spec command (`SpCommand`) that will be used for context menus and/or shortcuts in the presenters that implement `SpTActionContainer`
"
Class {
	#name : #SpAction,
	#superclass : #SpCommand,
	#instVars : [
		'action',
		'actionEnabled',
		'visible',
		'actionVisible'
	],
	#category : #'Spec2-Core-Base-Command'
}

{ #category : #'instance creation' }
SpAction class >> newName: aName action: aBlock [

	^ self new 
		name: aName;
		action: aBlock;
		yourself
]

{ #category : #'instance creation' }
SpAction class >> newName: aName shortcut: aShortcut action: aBlock [

	^ self new 
		name: aName;
		shortcutKey: aShortcut;
		action: aBlock;
		yourself
]

{ #category : #'instance creation' }
SpAction class >> newShortcut: aShortcut action: aBlock [
	"action without menu entry"
	
	^ self new 
		name: aShortcut asString;
		shortcutKey: aShortcut;
		action: aBlock;
		beOnlyShortcut;
		yourself
]

{ #category : #accessing }
SpAction >> action: aBlock [

	action := aBlock
]

{ #category : #accessing }
SpAction >> actionEnabled: aBlock [

	actionEnabled := aBlock
]

{ #category : #accessing }
SpAction >> actionVisible: aBlock [

	actionVisible := aBlock
]

{ #category : #accessing }
SpAction >> beOnlyShortcut [

	visible := false
]

{ #category : #testing }
SpAction >> canBeExecuted [

	actionEnabled ifNil: [ ^ true ].
	^ actionEnabled cull: self context
]

{ #category : #executing }
SpAction >> execute [
	
	action ifNil: [ ^ self ].
	self canBeExecuted ifFalse: [ ^ self ].

	action cull: self context
]

{ #category : #initialization }
SpAction >> initialize [

	decoratedCommand := CmCommand new.
	decoratedCommand name: nil.
	visible := true.
	super initialize.
	 
]

{ #category : #testing }
SpAction >> isVisible [

	^ visible 
		and: [ actionVisible isNil or: [ actionVisible value ] ]
]

{ #category : #accessing }
SpAction >> shortcut: aKeyCombination [
	"just a synonym"
	
	self shortcutKey: aKeyCombination
]
