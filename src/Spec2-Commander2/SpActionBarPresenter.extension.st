Extension { #name : 'SpActionBarPresenter' }

{ #category : '*Spec2-Commander2' }
SpActionBarPresenter >> fillWith: aCommandGroup [

	items removeAll.
	SpActionBarPresenterBuilder new 
		actionBarPresenter: self;
		visit: aCommandGroup
]
