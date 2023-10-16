"
This class defines the main entry point for running a Spec example of a two-pane ""browser"", however, it display the class comments on classes of the selected package. It defines a component list (`newComponentList`) to hold a list of presenters, instances of `SpTransmissionComponentItemExample`.

- In the left side there are a list of system's pacakges.
- When a package is clicked, in the right side will appear a list of presenters.
- Each presenter is an instance of `SpTransmissionComponentItemExample`.
- The ""glue"" between this main container and the presenter-items is implemented in `SpTransmissionComponentPageExample >> #setModel:`

"
Class {
	#name : 'SpTransmissionComponentListExample',
	#superclass : 'SpPresenter',
	#instVars : [
		'classesPresenter',
		'packagesPresenter'
	],
	#category : 'Spec2-Examples-Demo-ComponentList',
	#package : 'Spec2-Examples',
	#tag : 'Demo-ComponentList'
}

{ #category : 'showing' }
SpTransmissionComponentListExample class >> open [ 
	<script>
	
	^ self new open
]

{ #category : 'initialization' }
SpTransmissionComponentListExample >> connectPresenters [

	packagesPresenter
		transmitTo: classesPresenter
		transform: [ :aPackage | 
			aPackage
				ifNotNil: [ 
					aPackage definedClasses asArray collect: [ : packageClass |
						self
							instantiate: SpTransmissionComponentItemExample
							on: packageClass ] ]
				ifNil: [ #(  ) ] ].

]

{ #category : 'transmission' }
SpTransmissionComponentListExample >> defaultInputPort [ 

	^ SpListItemsPort newPresenter: classesPresenter

]

{ #category : 'layout' }
SpTransmissionComponentListExample >> defaultLayout [

	| packagesLayout classesLayout |
	packagesLayout := SpBoxLayout newTopToBottom
		add: 'Packages' expand: false;
		add: packagesPresenter;
		yourself.
	
	classesLayout := SpBoxLayout newTopToBottom
		add: 'Classes' expand: false;
		add: classesPresenter;
		yourself.
		
	^ SpBoxLayout newTopToBottom
		spacing: 5;
		add: (SpPanedLayout newLeftToRight
			add: packagesLayout;
			add: classesLayout;
			yourself);	
		yourself
]

{ #category : 'ports' }
SpTransmissionComponentListExample >> defaultOutputPort [ 

	^ packagesPresenter
]

{ #category : 'initialization' }
SpTransmissionComponentListExample >> initialize [ 

	super initialize.
	self application addStyleSheetFromString: '.application [
        .gray [ Draw { #backgroundColor: #veryLightGray } ],
        .red [ Draw { #backgroundColor: #red } ]
]'.
]

{ #category : 'initialization' }
SpTransmissionComponentListExample >> initializePresenters [

	packagesPresenter := self newList.
	packagesPresenter
		display: [ :package | package name ];
		displayIcon: [ self iconNamed: #package ];
		sortingBlock: [ :a :b | a name < b name ];
		items: RPackageOrganizer default packages.

	"classesPresenter := self instantiate: SpTransmissionComponentPageExample on: self"
	classesPresenter := self newComponentList.
]

{ #category : 'initialization' }
SpTransmissionComponentListExample >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Transmission example with component list example';
		initialExtent: 800 @ 600
]
