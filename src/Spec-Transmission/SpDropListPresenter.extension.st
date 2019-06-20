Extension { #name : #SpDropListPresenter }

{ #category : #'*Spec-Transmission' }
SpDropListPresenter >> defineInputPorts [

	^ { SpListItemsPort new }
]

{ #category : #'*Spec-Transmission' }
SpDropListPresenter >> defineOutputPorts [

	^ { SpDropListSelectionPort new }
]
