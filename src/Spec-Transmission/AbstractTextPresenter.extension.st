Extension { #name : #AbstractTextPresenter }

{ #category : #'*Spec-Transmission' }
AbstractTextPresenter >> defineInputPorts [ 

	^ { SpecTextPort new }
]

{ #category : #'*Spec-Transmission' }
AbstractTextPresenter >> defineOutputPorts [
	^ {SpecTextChangedPort new}
]
