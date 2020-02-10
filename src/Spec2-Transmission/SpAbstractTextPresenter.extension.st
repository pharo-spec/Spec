Extension { #name : #SpAbstractTextPresenter }

{ #category : #'*Spec2-Transmission' }
SpAbstractTextPresenter >> defaultInputPort [

	^ self inputTextPort
]

{ #category : #'*Spec2-Transmission' }
SpAbstractTextPresenter >> defineOutputPorts [

	^ { SpTextChangedPort new }
]

{ #category : #'*Spec2-Transmission' }
SpAbstractTextPresenter >> inputTextPort [ 

	^ SpTextPort newPresenter: self
]
