Extension { #name : #AbstractListPresenter }

{ #category : #'*Spec-Transmission' }
AbstractListPresenter >> defineInputPorts [
	
	^ { ListItemsPresenterPort new }
]

{ #category : #'*Spec-Transmission' }
AbstractListPresenter >> defineOutputPorts [
	
	^ { ListSelectionPresenterPort new }
]
