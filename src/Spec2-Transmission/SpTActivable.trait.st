"
This trait defines a custom activable presenter. 
Add the trait when you want to define a presenter that can be used in the inspector, for example.

see `SpDemoActivablePresenter`
"
Trait {
	#name : 'SpTActivable',
	#instVars : [
		'activationAction'
	],
	#category : 'Spec2-Transmission-Custom',
	#package : 'Spec2-Transmission',
	#tag : 'Custom'
}

{ #category : 'private - actions' }
SpTActivable >> activate [
	"Perform here the activation. A common usage would be something like:

	self activationAction ifNil: [ ^ self ].
	self activationAction cull: (SpActivatedSelection newValue: 42)
	"

	self shouldBeImplemented
]

{ #category : 'api' }
SpTActivable >> activateOnDoubleClick [
]

{ #category : 'api' }
SpTActivable >> activateOnSingleClick [
]

{ #category : 'private' }
SpTActivable >> activationAction [

	^ activationAction
]

{ #category : 'testing' }
SpTActivable >> hasOutputActivationPort [

	^ true
]

{ #category : 'transmission' }
SpTActivable >> outputActivationPort [

	^ SpActivationPort newPresenter: self
]

{ #category : 'api - events' }
SpTActivable >> whenActivatedDo: aBlock [
	"Defines the activation event. 
	 `aBlock` receives an optional argument, that needs to be an instance of `SpActivatedObject`.
	 see `SpTActivable>>#activate"

	activationAction ifNil: [ activationAction := SpActivationHolder new ].
	activationAction add: aBlock
]
