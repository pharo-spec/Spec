"
! Output ports
An output port defines origin actions (and the possible data associated to such action) to transmit to an destination (input) port.

It also defines the transformations to apply to the output data before give them to the input port.

Finally, it can also define some operation to do after the transmission is completed. 

Transmission are ''attached'' to a presenter (each concrete output port will override *method:SpOutputPort#attachTransmission:*).
"
Class {
	#name : 'SpOutputPort',
	#superclass : 'SpAbstractPort',
	#instVars : [
		'transformations'
	],
	#category : 'Spec2-Transmission-Base',
	#package : 'Spec2-Transmission',
	#tag : 'Base'
}

{ #category : 'testing' }
SpOutputPort class >> isAbstract [

	^ self name = #SpOutputPort
]

{ #category : 'copying' }
SpOutputPort >> , otherPort [

	^ SpCompositeOutputPort new
		add: self;
		add: otherPort;
		yourself
]

{ #category : 'private' }
SpOutputPort >> applyTransform: anObject [
	| transformedObject |

	transformations ifNil: [ ^ anObject ].

	transformedObject := anObject.	
	transformations do: [ :eachBlock | 
		transformedObject := eachBlock value: transformedObject ].
	^ transformedObject 
]

{ #category : 'attaching' }
SpOutputPort >> attachTransmission: aTransmission [
	"A transmission is no more than a definition of what to transmit to who. 
	 By overriding this method, concrete output ports can listen the event they need to and 
	 execute the transmission (sending ==#transmitTo:value:==).
	[[[language=Smalltalk
	self destinationPresenter whenSelectionChangedDo: [ :selection | 
		self 
			transmitWith: aTransmission 
			value: selection transmission ]
	]]]"
	| presenterOrPort |
	
	"We attach transmission to presenter. If destination is not a presenter, then it has to be a
	chained port (in that case we just chan the transmission ;)"
	
	presenterOrPort := self destinationPresenterOrPort.
	presenterOrPort isPresenter
		ifTrue: [ 
			self attachTransmission: aTransmission to: presenterOrPort ]
		ifFalse: [ 
			presenterOrPort 
				transform: transformations;				
				attachTransmission: aTransmission ]
]

{ #category : 'attaching' }
SpOutputPort >> attachTransmission: aTransmission to: aPresenter [
		
	self subclassResponsibility
]

{ #category : 'testing' }
SpOutputPort >> isOutput [

	^ true
]

{ #category : 'accessing' }
SpOutputPort >> transform: aBlock [
	"Sometimes you do not want to transmit to the outside the object you are using but a 
	 transformation of it (for example, if you are using a list of wrapped elements instead the 
	 actual elements).
	 You can transform the output like this: 
	```Smalltalk
	(SpSelectionPort newPresenter: self)
		transform: [ :aNode | aNode wrappedElement ]; 
		yourself
	```"

	aBlock ifNil: [ ^ self ].
	transformations ifNil: [ transformations := #() ].
	transformations := transformations copyWith: aBlock
]

{ #category : 'transmitting' }
SpOutputPort >> transmitDo: aBlock [
	
	^ SpTransmission new
		fromPort: self;
		do: aBlock;
		apply
]

{ #category : 'transmitting' }
SpOutputPort >> transmitDo: aBlock transform: transformBlock [
	
	^ SpTransmission new
		fromPort: self;
		do: aBlock;
		transform: transformBlock;
		apply
]

{ #category : 'transmitting' }
SpOutputPort >> transmitTo: aPort [

	^ SpTransmission new
		fromPort: self;
		toPort: aPort;
		apply
]

{ #category : 'transmitting' }
SpOutputPort >> transmitTo: aPort postTransmission: postValuable [

	^ SpTransmission new
		fromPort: self;
		toPort: aPort;
		postTransmission: postValuable;
		apply
]

{ #category : 'transmitting' }
SpOutputPort >> transmitTo: aPort transform: aValuable [

	^ SpTransmission new
		fromPort: self;
		toPort: aPort;
		transform: aValuable;
		apply
]

{ #category : 'transmitting' }
SpOutputPort >> transmitTo: aPort transform: aValuable postTransmission: postValuable [

	^ SpTransmission new
		fromPort: self;
		toPort: aPort;
		transform: aValuable;
		postTransmission: postValuable;
		apply
]

{ #category : 'private' }
SpOutputPort >> transmitWith: aTransmission value: transmitted [

	aTransmission applyPreTransmissionWith: transmitted.
	aTransmission toPort
		incomingTransmission: (aTransmission transformed: transmitted)
		from: self.
	aTransmission applyPostTransmissionWith: transmitted
]
