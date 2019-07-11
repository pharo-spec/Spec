Extension { #name : #CmdCommandActivator }

{ #category : #'*Spec2-CommanderCompatibility' }
CmdCommandActivator >> help [
	^ self command class defaultHelp.
]
