Extension { #name : #ComposablePresenter }

{ #category : #'*Spec-Transmission' }
ComposablePresenter >> defineInputPorts [

	^ #()
]

{ #category : #'*Spec-Transmission' }
ComposablePresenter >> defineOutputPorts [

	^ #()
]

{ #category : #'*Spec-Transmission' }
ComposablePresenter >> inputPortDefault [

	"first input port will be default. 
	 this may be bad design and probably needs to be revisited later"
	^ self inputPorts first
]

{ #category : #'*Spec-Transmission' }
ComposablePresenter >> inputPortNamed: aSymbol [

	^ self inputPorts detect: [ :each | each name = aSymbol ]
]

{ #category : #'*Spec-Transmission' }
ComposablePresenter >> inputPorts [

	^ self defineInputPorts collect: [ :each | each presenter: self ]
]

{ #category : #'*Spec-Transmission' }
ComposablePresenter >> outputPortDefault [

	"first output port will be default. 
	 this may be bad design and probably needs to be revisited later"
	^ self outputPorts first
]

{ #category : #'*Spec-Transmission' }
ComposablePresenter >> outputPortNamed: aSymbol [

	^ self outputPorts detect: [ :each | each name = aSymbol ]
]

{ #category : #'*Spec-Transmission' }
ComposablePresenter >> outputPorts [

	^ self defineOutputPorts collect: [ :each | each presenter: self ]
]

{ #category : #'*Spec-Transmission' }
ComposablePresenter >> transmit [
	| newTransmition |

	transmissions ifNil: [ transmissions := Set new ].
	newTransmition := PresenterTransmission on: self.
	transmissions add: newTransmition.
	^ newTransmition
]
