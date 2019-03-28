Class {
	#name : #TransmissionExample,
	#superclass : #ComposablePresenter,
	#instVars : [
		'packages',
		'classes',
		'protocols',
		'methods',
		'code'
	],
	#category : #'Spec-Examples'
}

{ #category : #specs }
TransmissionExample class >> defaultSpec [

	^ SpecBoxLayout newVertical
		add: (SpecBoxLayout newHorizontal 
			add: #packages;
			add: #classes;
			add: #protocols;
			add: #methods);
		add: #code;
		yourself
]

{ #category : #showing }
TransmissionExample class >> open [ 
	<script>
	
	^ self new openWithSpec
]

{ #category : #initialization }
TransmissionExample >> initializeWidgets [
	
	packages := self newList displayBlock: #name. 
	classes := self newList displayBlock: #name. 
	protocols := self newList displayBlock: [ :aPair | aPair value name ]. 
	methods := self newList displayBlock: #selector. 
	code := self newText beForCode.

	self transmit 
		from: packages
		to: classes
		transform: [ :aPackage | aPackage definedClasses asOrderedCollection ].
		
	self transmit 
		from: classes
		to: protocols
		transform: [ :aClass | 
			aClass organization allProtocols 
				collect: [ :each | aClass -> each ]
				as: OrderedCollection ]
		postTransmission: [ :destination :origin | destination selectIndex: 1 ].
			
	self transmit 
		from: protocols
		to: methods
		transform: [ :aPair | 
			aPair value methods 
				collect: [ :each | aPair key >> each ]
				as: OrderedCollection ].
			
	self transmit 
		from: methods
		to: code
		transform: #sourceCode.
	
	packages items: RPackageOrganizer default packages
]

{ #category : #initialization }
TransmissionExample >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Transmission example browser';
		initialExtent: 800@600
]
