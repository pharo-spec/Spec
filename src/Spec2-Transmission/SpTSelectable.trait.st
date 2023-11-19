"
This trait defines a custom selectable presenter. 

"
Trait {
	#name : 'SpTSelectable',
	#instVars : [
		'selectionAction'
	],
	#category : 'Spec2-Transmission-Custom',
	#package : 'Spec2-Transmission',
	#tag : 'Custom'
}

{ #category : 'testing' }
SpTSelectable >> hasOutputSelectionPort [

	^ true
]

{ #category : 'transmission' }
SpTSelectable >> outputSelectionPort [

	^ SpSelectionPort newPresenter: self
]

{ #category : 'private - actions' }
SpTSelectable >> select [
	"Perform here the activation. A common usage would be something like:

	self activationAction ifNil: [ ^ self ].
	self activationAction cull: (SpActivatedSelection newValue: 42)
	"

	self shouldBeImplemented
]

{ #category : 'private' }
SpTSelectable >> selectionAction [

	^ selectionAction
]

{ #category : 'api - events' }
SpTSelectable >> whenSelectionChangedDo: aBlock [
	"Defines the selected event. 
	 `aBlock` receives an optional argument, that needs to be an instance of `SpActivatedObject`.
	 see `SpTSelectable>>#activate"

	selectionAction ifNil: [ selectionAction := SpActivationHolder new ].
	selectionAction add: aBlock
]
