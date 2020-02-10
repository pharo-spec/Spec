Extension { #name : #SpDropListPresenter }

{ #category : #'*Spec2-Transmission' }
SpDropListPresenter >> defaultInputPort [

	^ self inputItemsPort
]

{ #category : #'*Spec2-Transmission' }
SpDropListPresenter >> defineOutputPorts [

	^ { SpDropListSelectionPort new }
]

{ #category : #'*Spec2-Transmission' }
SpDropListPresenter >> inputItemsPort [

	^ SpListItemsPort newPresenter: self
]
