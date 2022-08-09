Class {
	#name : #SpDemoSelectablePresenter,
	#superclass : #SpPresenter,
	#traits : 'SpTSelectable',
	#classTraits : 'SpTSelectable classTrait',
	#instVars : [
		'activationAction'
	],
	#category : #'Spec2-Examples-Demo-Transmission'
}

{ #category : #'instance creation' }
SpDemoSelectablePresenter class >> open [ 
	<script>
	| presenter |
	
	presenter := self new.
	presenter outputSelectionPort 
		transmitDo: [ :aValue | self inform: 'Selected ', aValue asString ].
	presenter open
]

{ #category : #initialization }
SpDemoSelectablePresenter >> initializePresenters [

	self layout: (SpBoxLayout newVertical 
		add: (self newButton 
			label: 'Select';
			action: [ self select ];
			yourself);
		yourself).
]

{ #category : #'private - actions' }
SpDemoSelectablePresenter >> select [

	self selectionAction ifNil: [ ^ self ].
	self selectionAction cull: (SpActivatedSelection newValue: 42)
]
