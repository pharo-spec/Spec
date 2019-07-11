Extension { #name : #CmdCommandActivator }

{ #category : #'*Spec2-CommanderCompatibility' }
CmdCommandActivator >> getShortcutTipForMenuItem [
	CmdShortcutActivation
		activeInstancesFor: command class
		inContext: context
		do:
			[ :shortcut | "this is trick to show shortcut on menu with existing menu support" 
			^ shortcut keyCombination ].
		^nil
]

{ #category : #'*Spec2-CommanderCompatibility' }
CmdCommandActivator >> help [
	^ self command class defaultHelp.
]
