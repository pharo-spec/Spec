Extension { #name : #SpAbstractListPresenter }

{ #category : #'*Spec-Transmission' }
SpAbstractListPresenter >> defineInputPorts [
	
	^ { SpListItemsPort new }
]

{ #category : #'*Spec-Transmission' }
SpAbstractListPresenter >> defineOutputPorts [
	
	^ { SpListSelectionPort new }
]
