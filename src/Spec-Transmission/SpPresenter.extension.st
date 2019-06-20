Extension { #name : #SpPresenter }

{ #category : #'*Spec-Transmission' }
SpPresenter >> defineInputPorts [

	^ #()
]

{ #category : #'*Spec-Transmission' }
SpPresenter >> defineOutputPorts [

	^ #()
]

{ #category : #'*Spec-Transmission' }
SpPresenter >> inputPortDefault [

	"first input port will be default. 
	 this may be bad design and probably needs to be revisited later"
	^ self inputPorts first
]

{ #category : #'*Spec-Transmission' }
SpPresenter >> inputPortNamed: aSymbol [

	^ self inputPorts detect: [ :each | each name = aSymbol ]
]

{ #category : #'*Spec-Transmission' }
SpPresenter >> inputPorts [

	^ self defineInputPorts collect: [ :each | each presenter: self ]
]

{ #category : #'*Spec-Transmission' }
SpPresenter >> newTransmission [

	^ SpTransmission new
]

{ #category : #'*Spec-Transmission' }
SpPresenter >> outputPortDefault [

	"first output port will be default. 
	 this may be bad design and probably needs to be revisited later"
	^ self outputPorts first
]

{ #category : #'*Spec-Transmission' }
SpPresenter >> outputPortNamed: aSymbol [

	^ self outputPorts detect: [ :each | each name = aSymbol ]
]

{ #category : #'*Spec-Transmission' }
SpPresenter >> outputPorts [

	^ self defineOutputPorts collect: [ :each | each presenter: self ]
]

{ #category : #'*Spec-Transmission' }
SpPresenter >> transmitDo: aBlock [
	
	self newTransmission
		from: self;
		do: aBlock;
		apply
]

{ #category : #'*Spec-Transmission' }
SpPresenter >> transmitDo: aBlock transform: transformBlock [
	
	self newTransmission
		from: self;
		do: aBlock;
		transform: transformBlock;
		apply
]

{ #category : #'*Spec-Transmission' }
SpPresenter >> transmitPort: aPortName do: aBlock [
	
	self newTransmission
		from: self port: aPortName;
		do: aBlock;
		apply
]

{ #category : #'*Spec-Transmission' }
SpPresenter >> transmitPort: aPortName do: aBlock transform: transformBlock [
	
	self newTransmission
		from: self port: aPortName;
		do: aBlock;
		transform: transformBlock;
		apply
]

{ #category : #'*Spec-Transmission' }
SpPresenter >> transmitTo: aPresenter [		
	
	^ self newTransmission
		from: self;
		to: aPresenter;
		apply
]

{ #category : #'*Spec-Transmission' }
SpPresenter >> transmitTo: aPresenter transform: aValuable [
	
	^ self newTransmission
		from: self;
		to: aPresenter;
		transform: aValuable;
		apply
]

{ #category : #'*Spec-Transmission' }
SpPresenter >> transmitTo: aPresenter transform: aValuable postTransmission: postValuable [
	
	^ self newTransmission
		from: self; 
		to: aPresenter;
		transform: aValuable;
		postTransmission: postValuable;
		apply
]
