"
An OkCancelToolbar is a model for a basic Ok toolbar
"
Class {
	#name : #SpOkToolbar,
	#superclass : #SpPresenter,
	#instVars : [
		'#okButton',
		'#okAction => SpObservableSlot'
	],
	#category : #'Spec2-Deprecated-Obsolete'
}

{ #category : #'*Spec2-Deprecated' }
SpOkToolbar class >> defaultSpec [
	<spec>
	
	^ SpLayout composed
		add: #okButton origin: 1@0 corner: 1@1 offsetOrigin: (self buttonWidth negated)@0 offsetCorner: 0@0;
		send: #vShrinkWrap;
		yourself
]

{ #category : #'*Spec2-Deprecated' }
SpOkToolbar class >> isDeprecated [
	"You should use a ToolBarPresenter"

	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpOkToolbar class >> title [

	^ 'Ok Toolbar'
]

{ #category : #'*Spec2-Deprecated' }
SpOkToolbar >> cancel [
	
	owner 
		ifNil: [ self delete ] 
		ifNotNil: [ owner delete ]
]

{ #category : #'*Spec2-Deprecated' }
SpOkToolbar >> connectPresenters [

	okButton action: self okActionBlock
]

{ #category : #'*Spec2-Deprecated' }
SpOkToolbar >> initialize [
	super initialize.
	okAction := [ true ]
]

{ #category : #'*Spec2-Deprecated' }
SpOkToolbar >> initializePresenters [
	
	
	okButton := self newButton.
	self registerOkButtonEvents.
	
	self focusOrder
		add: okButton
]

{ #category : #'*Spec2-Deprecated' }
SpOkToolbar >> okAction [
	^ okAction
]

{ #category : #'*Spec2-Deprecated' }
SpOkToolbar >> okAction: aBlock [

	^ okAction := aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpOkToolbar >> okActionBlock [
	^ [ self okAction value == false ifFalse: [ owner ifNil: [ self delete ] ifNotNil: [ owner delete ] ] ]
]

{ #category : #'*Spec2-Deprecated' }
SpOkToolbar >> okButton [

	^ okButton
]

{ #category : #'*Spec2-Deprecated' }
SpOkToolbar >> registerOkButtonEvents [

	okButton 
		label: 'Ok';
		enabled: true;
		state: false
]

{ #category : #'*Spec2-Deprecated' }
SpOkToolbar >> triggerCancelAction [
	
	self cancel
]

{ #category : #'*Spec2-Deprecated' }
SpOkToolbar >> triggerOkAction [

	self okActionBlock value
]
