Extension { #name : 'PluggableButtonMorph' }

{ #category : '*Spec2-Pharo7To8Compatibility' }
PluggableButtonMorph >> getMenu: shiftPressed [
	"Answer the menu for this button, supplying an empty menu to be filled in. If the menu selector takes an extra argument, pass in the current state of the shift key."

	| menu |
	getMenuSelector isNil ifTrue: [^nil].
	menu := self theme newMenuIn: self for: model.
	getMenuSelector numArgs = 1 
		ifTrue: [^model perform: getMenuSelector with: menu].
	getMenuSelector numArgs = 2 
		ifTrue: 
			[^model 
				perform: getMenuSelector
				with: menu
				with: shiftPressed].
	^self error: 'The getMenuSelector must be a 1- or 2-keyword symbol'
]
