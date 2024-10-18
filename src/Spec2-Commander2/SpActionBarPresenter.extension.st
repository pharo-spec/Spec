Extension { #name : 'SpActionBarPresenter' }

{ #category : '*Spec2-Commander2' }
SpActionBarPresenter >> addItemLeft: anItem [

	self add: anItem
]

{ #category : '*Spec2-Commander2' }
SpActionBarPresenter >> addItemRight: anItem [

	self addLast: anItem
]

{ #category : '*Spec2-Commander2' }
SpActionBarPresenter >> fillWith: aCommandGroup [

	items removeAll.
	SpActionBarPresenterBuilder new 
		actionBarPresenter: self;
		visit: aCommandGroup
]
