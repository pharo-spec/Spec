"
I am an event handler to dispatch low-level events to my presenters.
I am used when the ""high-level"" events (like ""clicked"" for buttons, etc.) are not enough and users need to control better what is happenign. 

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

{ #category : #'api-events' }
SpEventHandler >> whenGotFocusDo: aBlock [

	 self register: (SpGotFocusEvent do: aBlock)
]

{ #category : #'api-events' }
SpEventHandler >> whenLostFocusDo: aBlock [

	 self register: (SpLostFocusEvent do: aBlock)
]
