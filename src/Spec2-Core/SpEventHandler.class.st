"
I am an event handler to dispatch low-level events to my presenters.
I am used when the ""high-level"" events (like ""clicked"" for buttons, etc.) are not enough and users need to control better what is happening. 

I can listen: 
- focus events: got focus, lost focus. 
- mouse events: mouse enter, mouse leave, mouse move
- keyboard events: keydown, keyup

WARNING: Not all presenters will answer equally to all events. For example, presenters who can't take the keyboard focus can't respond to focus events.
"
Class {
	#name : #SpEventHandler,
	#superclass : #Object,
	#instVars : [
		'presenter',
		'events'
	],
	#category : #'Spec2-Core-Base-Event'
}

{ #category : #'instance creation' }
SpEventHandler class >> for: aPresenter [ 

	^ self basicNew 
		initializePresenter: aPresenter;
		yourself
]

{ #category : #'instance creation' }
SpEventHandler class >> new [

	self error: 'Use #new'
]

{ #category : #testing }
SpEventHandler >> hasEvents [
	
	^ events notEmpty
]

{ #category : #initialization }
SpEventHandler >> initialize [
	
	super initialize.
	events := Set new
]

{ #category : #initialization }
SpEventHandler >> initializePresenter: aPresenter [

	presenter := aPresenter.
	self initialize
]

{ #category : #installing }
SpEventHandler >> installAllEventsTo: anAdapter target: aWidget [

	events do: [ :each |
		each installOn: anAdapter target: aWidget ]
]

{ #category : #private }
SpEventHandler >> register: anEvent [

	events add: anEvent.
	presenter withAdapterDo: [ :anAdapter | 
		anAdapter installEvent: anEvent  ]	
]

{ #category : #'api - events' }
SpEventHandler >> whenDoubleClickDo: aBlock [

	 self register: (SpMouseDoubleClickDefinition do: aBlock)
]

{ #category : #'api - events' }
SpEventHandler >> whenFocusLostDo: aBlock [
	"Register on a focus lost event. 
	 aBlock does not have parameters."

	 self register: (SpFocusLostEventDefinition do: aBlock)
]

{ #category : #'api - events' }
SpEventHandler >> whenFocusReceivedDo: aBlock [
	"Register on a focus received event. 
	aBlock does not have parameters."


	 self register: (SpFocusReceivedEventDefinition do: aBlock)
]

{ #category : #'api - events' }
SpEventHandler >> whenKeyDownDo: aBlock [
	"Register on a key down event. 
	 aBlock receives 'event' as parameter."

	 self register: (SpKeyDownEventDefinition do: aBlock)
]

{ #category : #'api - events' }
SpEventHandler >> whenKeyUpDo: aBlock [
	"Register on a key down event. 
	 aBlock receives 'event' as parameter."

	 self register: (SpKeyUpEventDefinition do: aBlock)
]

{ #category : #'api - events' }
SpEventHandler >> whenMouseDownDo: aBlock [
	"Register on a mouse down event. 
	 aBlock receives 'event' as parameter."

	 self register: (SpMouseDownEventDefinition do: aBlock)
]

{ #category : #'api - events' }
SpEventHandler >> whenMouseEnterDo: aBlock [
	"Register on a mouse enter event. 
	 aBlock receives 'event' as parameter."

	 self register: (SpMouseEnterEventDefinition do: aBlock)
]

{ #category : #'api - events' }
SpEventHandler >> whenMouseLeaveDo: aBlock [
	"Register on a mouse leave event. 
	 aBlock receives 'event' as parameter."

	 self register: (SpMouseLeaveEventDefinition do: aBlock)
]

{ #category : #'api - events' }
SpEventHandler >> whenMouseMoveDo: aBlock [
	"Register on a mouse move event. 
	 aBlock receives 'event' as parameter."

	 self register: (SpMouseMoveEventDefinition do: aBlock)
]

{ #category : #'api - events' }
SpEventHandler >> whenMouseUpDo: aBlock [
	"Register on a mouse up event. 
	 aBlock receives 'event' as parameter."
	
	 self register: (SpMouseUpEventDefinition do: aBlock)
]
