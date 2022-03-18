"
Description
--------------------

I am a presenter to show how to use modals with spec.
"
Class {
	#name : #SpDemoModalPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'button1',
		'button2'
	],
	#category : #'Spec2-Examples-Demo-Modals'
}

{ #category : #'instance creation' }
SpDemoModalPresenter class >> open [
	<script>
	self new open
]

{ #category : #specs }
SpDemoModalPresenter class >> title [
	^ 'Modals demo'
]

{ #category : #accessing }
SpDemoModalPresenter >> button1 [
	^ button1
]

{ #category : #accessing }
SpDemoModalPresenter >> button2 [
	^ button2
]

{ #category : #layout }
SpDemoModalPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: (SpBoxLayout newLeftToRight
			add: button1;
			add: button2;
			yourself)
		expand: false;
		yourself
]

{ #category : #initialization }
SpDemoModalPresenter >> initializePresenters [
	button1 := self newButton.
	button2 := self newButton.
	
	button1
		label: 'Open 1';
		action: [ SpDemoModal1Presenter new openModal ].
	button2 label: 'Open 2';
		action: [ SpDemoModal2Presenter new openModal ]
]
