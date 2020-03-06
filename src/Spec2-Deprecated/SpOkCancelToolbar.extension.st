Extension { #name : #SpOkCancelToolbar }

{ #category : #'*Spec2-Deprecated' }
SpOkCancelToolbar >> cancel [

	self cancelled: true
]

{ #category : #'*Spec2-Deprecated' }
SpOkCancelToolbar >> cancelAction [
	^ cancelAction
]

{ #category : #'*Spec2-Deprecated' }
SpOkCancelToolbar >> cancelAction: aBlock [
	^ cancelAction := aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpOkCancelToolbar >> cancelButton [

	^ cancelButton
]

{ #category : #'*Spec2-Deprecated' }
SpOkCancelToolbar >> cancelled [
	^ cancelled
]

{ #category : #'*Spec2-Deprecated' }
SpOkCancelToolbar >> cancelled: aBoolean [
	cancelled := aBoolean
]

{ #category : #'*Spec2-Deprecated' }
SpOkCancelToolbar >> connectPresenters [

	super connectPresenters.
	cancelButton action: [ self performCancelAction ]
]

{ #category : #'*Spec2-Deprecated' }
SpOkCancelToolbar class >> defaultSpec [
	<spec>
	
	^ SpLayout composed
		add: #okButton origin: 1@0 corner: 1@1 offsetOrigin: (2*(self buttonWidth negated))@0 offsetCorner: (self buttonWidth negated)@0;
		add: #cancelButton origin: 1@0 corner: 1@1 offsetOrigin: (self buttonWidth negated)@0 offsetCorner: 0@0;
		send: #vShrinkWrap;
		yourself
]

{ #category : #'*Spec2-Deprecated' }
SpOkCancelToolbar >> initialize [
	cancelled := false.
	cancelAction := [ true ].
	super initialize
]

{ #category : #'*Spec2-Deprecated' }
SpOkCancelToolbar >> initializePresenters [

	super initializePresenters.
	cancelButton := self newButton.

	self registerCancelButtonEvents.
	self focusOrder
		add: cancelButton
]

{ #category : #'*Spec2-Deprecated' }
SpOkCancelToolbar class >> isDeprecated [
	"You should use a ToolBarPresenter"

	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpOkCancelToolbar >> performCancelAction [
	^ self cancelAction value == false
		ifFalse: [ cancelled := true.
			owner ifNil: [ self delete ] ifNotNil: [ owner delete ] ]
]

{ #category : #'*Spec2-Deprecated' }
SpOkCancelToolbar >> registerCancelButtonEvents [

	cancelButton 
		label: 'Cancel';
		enabled: true;
		state: false
]

{ #category : #'*Spec2-Deprecated' }
SpOkCancelToolbar class >> title [

	^ 'Ok Cancel'
]

{ #category : #'*Spec2-Deprecated' }
SpOkCancelToolbar >> triggerCancelAction [

	self performCancelAction
]
