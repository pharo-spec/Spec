"
@@TODO

A simple playground would be defined as: 

[[[language=Smalltalk
SpCodeInteractionMode newForScripting.
]]]

A code editor on a method: 

[[[language=Smalltalk
SpCodeInteractionMode newForMethod: aMethod.
]]]l 
 
"
Class {
	#name : 'SpCodeInteractionModel',
	#superclass : 'Object',
	#instVars : [
		'owner'
	],
	#category : 'Spec2-Code-Base',
	#package : 'Spec2-Code',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpCodeInteractionModel >> behavior [

	^ nil
]

{ #category : 'accessing' }
SpCodeInteractionModel >> bindings [

	"no additional bindings provided by the Requestor"

	^ #() asDictionary
]

{ #category : 'testing' }
SpCodeInteractionModel >> canAddBindingOf: name [
	^ false
]

{ #category : 'accessing' }
SpCodeInteractionModel >> compiler [
	"Provide a compiler set up on the current context/class/receiver"

	^ self doItReceiver class compiler
		context: self doItContext;
		receiver: self doItReceiver;
		isScripting: self isScripting;
		requestor: self;
		yourself
]

{ #category : 'interactive error protocol' }
SpCodeInteractionModel >> correctFrom: start to: stop with: aString [ 
	"this line of code marks the underlying widget as dirty.
	But... see below"
	self owner adapter widget correctFrom: start to: stop with: aString.
	
	"We need to unmark the dirtyness here.

	Otherwise, once compilation is done, the method installer will announce it.
	And the method browser will catch it and see it was dirty and launch a popup.
	And this happens before the `submit` callback returns!
	So this is not clear where to do it.
	
	But this is not so easy because here we are deep in the presenter hierarchy.
	Our owner owner may be a SpCodeEditor or not!
	
	This needs to be redesigned somehow..."
	(self owner owner respondsTo: #unmarkDirty)
		ifTrue: [ self owner owner unmarkDirty ] 
]

{ #category : 'accessing' }
SpCodeInteractionModel >> doItContext [

	^ nil
]

{ #category : 'accessing' }
SpCodeInteractionModel >> doItReceiver [

	^ nil
]

{ #category : 'testing' }
SpCodeInteractionModel >> hasBindingThatBeginsWith: aString [

	^ self variableBindingNames 
		anySatisfy: [ :each | each beginsWith: aString ]
]

{ #category : 'testing' }
SpCodeInteractionModel >> isScripting [

	^ false
]

{ #category : 'testing' }
SpCodeInteractionModel >> needRequestorScope [
	^false
]

{ #category : 'interactive error protocol' }
SpCodeInteractionModel >> notify: message at: location in: code [
	| currentSelection stripMessage |

	"self owner withAdapterDo: [ :anAdapter |
		anAdapter notify: message at: location in: code ]"

	stripMessage := (message endsWith: ' ->')
		ifTrue: [ message allButLast: 3 ]
		ifFalse: [ message ].

	currentSelection := self owner selectionInterval.
	self owner
		insertErrorPopover: (SpCodePopoverErrorPresenter
			newCode: self owner
			message: stripMessage)
		atIndex: (currentSelection isEmptyOrNil
			ifTrue: [ location ]
			ifFalse: [
				"both selection and location are 1-based, but position will be zero-based
				 (zero=first element), to actually arrive to the position I want I need to
				 substract two elements"
				currentSelection first + location - 2 ])
]

{ #category : 'accessing' }
SpCodeInteractionModel >> owner [

	^ owner
]

{ #category : 'accessing' }
SpCodeInteractionModel >> owner: aPresenter [

	owner := aPresenter
]

{ #category : 'accessing' }
SpCodeInteractionModel >> selectedBehavior [

	^ self behavior
]

{ #category : 'accessing' }
SpCodeInteractionModel >> selectedClass [

	^ self behavior
]

{ #category : 'accessing' }
SpCodeInteractionModel >> selectedClassOrMetaClass [

	^ self behavior
]

{ #category : 'accessing' }
SpCodeInteractionModel >> text [

	^ self owner text
]

{ #category : 'accessing' }
SpCodeInteractionModel >> variableBindingNames [
	
	^ self variableBindings keys
]

{ #category : 'accessing' }
SpCodeInteractionModel >> variableBindings [

	^ Dictionary new
]
