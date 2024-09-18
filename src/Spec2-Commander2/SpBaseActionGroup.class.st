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
	
	((aCommandOrGroup name isEmptyOrNil) or: [ aCommandOrGroup name = self class defaultName ]) 
		ifTrue: [ 
			"generate an unique name, since I do not care but it may be bad for generating ;)"
			aCommandOrGroup assignUniqueName ].
	super ensureNotDuplicated: aCommandOrGroup
]
