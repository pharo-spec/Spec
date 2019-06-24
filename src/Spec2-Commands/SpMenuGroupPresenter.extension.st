Extension { #name : #SpMenuGroupPresenter }

{ #category : #'*Spec2-Commands' }
SpMenuGroupPresenter >> add: aName target: targetObject selector: aSelector [
	
	self flag: #TODO. "This is for compatibility with the old menu builder and needs to be removed!"
	self addItem: [ :item | 
		item 
			name: aName; 
			action: [ targetObject perform: aSelector ] ].
	^ self menuItems last
]
