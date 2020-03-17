Extension { #name : #SpButtonPresenter }

{ #category : #'*Spec2-Deprecated' }
SpButtonPresenter >> getAction [
	"get the block performed when the button is clicked"

	self deprecated: 'Use #action instead' transformWith: '`@receiver getAction' -> '`@receiver action'.
	^ self action
]

{ #category : #'*Spec2-Deprecated' }
SpButtonPresenter >> menu [

	self 
		deprecated: 'Use #contextMenu instead.' 
		transformWith: '`@receiver menu' 
						-> '`@receiver contextMenu'.

	^ self contextMenu
]

{ #category : #'*Spec2-Deprecated' }
SpButtonPresenter >> menu: aMenu [

	self 
		deprecated: 'Use #contextMenu instead.' 
		transformWith: '`@receiver menu: `@argument' 
						-> '`@receiver contextMenu: `@argument'.
		
	self contextMenu: aMenu
]
