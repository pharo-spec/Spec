Extension { #name : #SpTreeTablePresenter }

{ #category : #'*Spec-Transmission' }
SpTreeTablePresenter >> defineInputPorts [ 

	^ { RootsPresenterPort new }
]

{ #category : #'*Spec-Transmission' }
SpTreeTablePresenter >> defineOutputPorts [ 

	^ { SpListSelectionPort new }
]
