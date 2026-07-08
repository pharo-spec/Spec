"
An action is a spec command (`SpCommand`) that will be used for context menus and/or shortcuts in the presenters that implement `SpTActionContainer`
"
Class {
	#name : 'SpAction',
	#superclass : 'SpCommand',
	#instVars : [
		'priority',
		'action',
		'actionEnabled',
		'visible',
		'actionVisible',
		'id',
		'dynamicName',
		'state',
		'actionState'
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
SpAction class >> newName: aName iconName: anIconName action: aBlock [

	^ self new 
		name: aName;
		iconName: anIconName;
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
SpAction >> actionState: aBlock [

	actionState := aBlock
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

	self state: false.
	self buildPresenterBlock: [ :specCommand | 
		SpToolbarToggleButtonPresenter new
			label: specCommand name;
			help: specCommand description;
			in: [ :button | 
				specCommand hasIcon
					ifTrue: [ button icon: specCommand icon ] ];
			action: [
				self toggleState.
				specCommand execute ];
			enabled: specCommand canBeExecuted;
			yourself ]
]

{ #category : 'testing' }
SpAction >> canBeExecuted [

	actionEnabled ifNil: [ ^ true ].
	^ actionEnabled cull: self context
]

{ #category : 'accessing' }
SpAction >> dynamicName [

	^ dynamicName 
		ifNotNil: [ :aBlock | aBlock cull: self context ]
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

	action 
		cull: self context
		cull: self
]

{ #category : 'testing' }
SpAction >> hasState [
	"state can be true/false. If nil this is a regular menu."

	^ state isNotNil or: [ actionState isNotNil ]
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
	priority := 0.
	super initialize
]

{ #category : 'testing' }
SpAction >> isVisible [

	^ visible and: [ 
		actionVisible isNil or: [ actionVisible cull: self context ] ]
]

{ #category : 'accessing' }
SpAction >> presenterClass: aClass [
	"this is an easy way to to define a special presenter that will be responsible of the UI
	 of the action. The only condition of this presenter is that it has to be able to receive 
	 a model."
	
	self flag: #CHECK. "Maybe I need to keep the presenter class?" 
	 self buildPresenterBlock: [ :aCommand | 
	 	self context 
	 		instantiate: aClass 
	 		on: aCommand ]
]

{ #category : 'printing' }
SpAction >> printOn: stream [

	stream << 'a SpAction('.
	stream << 'Name: ' << (self name ifNil: [ 'No name' ]).
	stream << ' Shortcut: ' << (self hasShortcutKey 
		ifTrue: [ self shortcutKey asString ] 
		ifFalse: [ 'No shortcut' ]).
	stream << ')'
]

{ #category : 'accessing' }
SpAction >> priority [

	^ priority ifNil: [ priority := 1 ]
]

{ #category : 'accessing' }
SpAction >> priority: aNumber [

	priority := aNumber
]

{ #category : 'accessing' }
SpAction >> shortcut: aKeyCombination [

	self 
		deprecated: 'It was a bad idea' 
		transformWith: '@receiver shortcut: `@arg1' -> '@receiver shortcutKey: `@arg1'.	
	self shortcutKey: aKeyCombination
]

{ #category : 'accessing - state' }
SpAction >> state [
	"state can be true/false or nil. This will be used for check menu items (and toggleable buttons)"
	actionState ifNotNil: [ ^ actionState cull: self context ].

	^ state 
]

{ #category : 'accessing - state' }
SpAction >> state: aBoolean [ 
	
	state := aBoolean
]

{ #category : 'accessing - state' }
SpAction >> toggleState [

	self hasState ifFalse: [ ^ self ].

	self state: self state not
]
