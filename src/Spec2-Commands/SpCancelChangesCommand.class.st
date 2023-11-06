Class {
	#name : 'SpCancelChangesCommand',
	#superclass : 'SpToolCommand',
	#category : 'Spec2-Commands-Code',
	#package : 'Spec2-Commands',
	#tag : 'Code'
}

{ #category : 'defaults' }
SpCancelChangesCommand class >> defaultIconName [
	^#smallCancel
]

{ #category : 'defaults' }
SpCancelChangesCommand class >> defaultName [

	^ 'Cancel'
]

{ #category : 'defaults' }
SpCancelChangesCommand class >> defaultShortcutKey [

	^ $l command mac | $l ctrl win | $l ctrl unix
]

{ #category : 'execution' }
SpCancelChangesCommand >> execute [
	
	self context triggerResetAction
]
