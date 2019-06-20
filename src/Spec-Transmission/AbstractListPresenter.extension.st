Extension { #name : #AbstractListPresenter }

{ #category : #'*Spec-Transmission' }
AbstractListPresenter >> defineInputPorts [
	
	^ { SpListItemsPort new }
]

{ #category : #'*Spec-Transmission' }
AbstractListPresenter >> defineOutputPorts [
	
	^ { SpListSelectionPort new }
]
