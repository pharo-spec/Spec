Extension { #name : #DropListPresenter }

{ #category : #'*Spec-Transmission' }
DropListPresenter >> defineInputPorts [

	^ { SpListItemsPort new }
]

{ #category : #'*Spec-Transmission' }
DropListPresenter >> defineOutputPorts [

	^ { SpDropListSelectionPort new }
]
