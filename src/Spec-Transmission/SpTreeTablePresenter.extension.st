Extension { #name : #SpTreeTablePresenter }

{ #category : #'*Spec-Transmission' }
SpTreeTablePresenter >> defineInputPorts [ 

	^ { SpRootsPresenterPort new }
]

{ #category : #'*Spec-Transmission' }
SpTreeTablePresenter >> defineOutputPorts [ 

	^ { SpListSelectionPort new }
]
