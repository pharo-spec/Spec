Extension { #name : 'SpMenuPresenter' }

{ #category : '*Spec2-Commander2' }
SpMenuPresenter >> fillWith: aCommandGroup [

	self removeAllItems.
	self presenterBuilderClass new
		menuPresenter: self;
		visit: aCommandGroup
]

{ #category : '*Spec2-Commander2' }
SpMenuPresenter >> presenterBuilderClass [

	^ SpMenuPresenterBuilder
]
