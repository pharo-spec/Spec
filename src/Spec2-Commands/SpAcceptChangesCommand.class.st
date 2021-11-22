Class {
	#name : #SpAcceptChangesCommand,
	#superclass : #SpToolCommand,
	#category : #'Spec2-Commands-Code'
}

{ #category : #defaults }
SpAcceptChangesCommand class >> defaultIconName [
	^#smallOk 
]

{ #category : #defaults }
SpAcceptChangesCommand class >> defaultName [

	^ 'Accept'
]

{ #category : #defaults }
SpAcceptChangesCommand class >> defaultShortcutKey [

	^ $s command mac | $s ctrl win | $s ctrl unix
]

{ #category : #execution }
SpAcceptChangesCommand >> execute [

	self context triggerSubmitAction
]
