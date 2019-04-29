Extension { #name : #DropListPresenter }

{ #category : #'*Spec-Transmission' }
DropListPresenter >> defineInputPorts [

	^ { ItemsPresenterPort new }
]

{ #category : #'*Spec-Transmission' }
DropListPresenter >> defineOutputPorts [

	^ { DropListSelectionPresenterPort new }
]
