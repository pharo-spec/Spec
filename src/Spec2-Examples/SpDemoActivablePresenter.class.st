"
A demo to demonstrate the usage of `SpTActivable`
"
Class {
	#name : #SpDemoActivablePresenter,
	#superclass : #SpPresenter,
	#traits : 'SpTActivable',
	#classTraits : 'SpTActivable classTrait',
	#instVars : [
		'activationAction'
	],
	#category : #'Spec2-Examples-Demo-Transmission'
}

{ #category : #inspection }
SpDemoActivablePresenter class >> inspectionTesting [
	<inspectorPresentationOrder: 0 title: 'Testing'>

	^ self new
]

{ #category : #'instance creation' }
SpDemoActivablePresenter class >> open [ 
	<script>
	
	self inspect
]

{ #category : #'private - actions' }
SpDemoActivablePresenter >> activate [

	self activationAction ifNil: [ ^ self ].
	self activationAction cull: (SpActivatedObject newValue: 42)
]

{ #category : #initialization }
SpDemoActivablePresenter >> initializePresenters [

	self layout: (SpBoxLayout newVertical 
		add: (self newButton 
			label: 'Activate';
			action: [ self activate ];
			yourself);
		yourself).
]
