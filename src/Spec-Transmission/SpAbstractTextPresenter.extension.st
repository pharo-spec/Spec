Extension { #name : #SpAbstractTextPresenter }

{ #category : #'*Spec-Transmission' }
SpAbstractTextPresenter >> defineInputPorts [ 

	^ { SpTextPort new }
]

{ #category : #'*Spec-Transmission' }
SpAbstractTextPresenter >> defineOutputPorts [
	^ {SpTextChangedPort new}
]
