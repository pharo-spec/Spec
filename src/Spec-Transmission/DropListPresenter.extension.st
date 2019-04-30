Extension { #name : #DropListPresenter }

{ #category : #'*Spec-Transmission' }
DropListPresenter >> defineInputPorts [

	^ { ListItemsPresenterPort new }
]

{ #category : #'*Spec-Transmission' }
DropListPresenter >> defineOutputPorts [

	^ { DropListSelectionPresenterPort new }
]
