Extension { #name : #CmdCommandMenuItem }

{ #category : #'*Spec2-CommanderCompatibility' }
CmdCommandMenuItem >> addToMenuPresenter: aSpMenuPresenter [
	aSpMenuPresenter
		addItem: [ :anItem | 
			anItem
				name: self name;
				icon: self icon;
				action: [ self executeCommand ];
				enabled: self isActive;
				description: self command class defaultHelp.
				self getShortcutTipForMenuItem ifNotNil: [ :shortcut | anItem shortcut: shortcut ] ]
]
