Extension { #name : #AbstractTextPresenter }

{ #category : #'*Spec-Transmission' }
AbstractTextPresenter >> defineInputPorts [ 

	^ { SpTextPort new }
]

{ #category : #'*Spec-Transmission' }
AbstractTextPresenter >> defineOutputPorts [
	^ {SpTextChangedPort new}
]
