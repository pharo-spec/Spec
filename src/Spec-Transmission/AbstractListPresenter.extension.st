Extension { #name : #AbstractListPresenter }

{ #category : #'*Spec-Transmission' }
AbstractListPresenter >> defineInputPorts [
	
	^ { ItemsPresenterPort new }
]

{ #category : #'*Spec-Transmission' }
AbstractListPresenter >> defineOutputPorts [
	
	^ { ListSelectionPresenterPort new }
]
