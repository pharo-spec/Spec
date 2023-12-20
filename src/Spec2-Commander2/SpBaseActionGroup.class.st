Class {
	#name : 'SpBaseActionGroup',
	#superclass : 'CmCommandGroup',
	#category : 'Spec2-Commander2-Action',
	#package : 'Spec2-Commander2',
	#tag : 'Action'
}

{ #category : 'private' }
SpBaseActionGroup >> ensureNotDuplicated: aCommandOrGroup [
	"we do not really care if this has not name (since groups as sections may not show it 
	 and actions as shortcuts do not need it)"
	
	aCommandOrGroup name ifNil: [ ^ self ].
	super ensureNotDuplicated: aCommandOrGroup
]
