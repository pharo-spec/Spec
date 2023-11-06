Extension { #name : 'Symbol' }

{ #category : '*Spec2-Core' }
Symbol >> asPresenterOn: aPresenter [

	self flag: #TODO. "The additionalSubpresentersMap is a functionality that needs to 
	be removed, but for now we need to take it into account"
	^ [ aPresenter presenterAt: self ]
		on: SlotNotFound 
		do: [ :e |
			aPresenter additionalSubpresentersMap 
				at: self
				ifAbsent: [ e pass ] ]
]
