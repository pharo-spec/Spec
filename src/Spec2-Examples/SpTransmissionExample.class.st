"
I am an example how transmissions work
"
Class {
	#name : 'SpTransmissionExample',
	#superclass : 'SpPresenter',
	#instVars : [
		'packages',
		'classes',
		'protocols',
		'methods',
		'code'
	],
	#category : 'Spec2-Examples-Demo-Transmission',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Transmission'
}

{ #category : 'showing' }
SpTransmissionExample class >> open [ 
	<script>
	
	^ self new open
]

{ #category : 'initialization' }
SpTransmissionExample >> classTemplateFor: aPackage [

	aPackage ifNil: [ ^ '' ].

	^ 'Object subclass: #NameOfSubclass
	slots: {}
	classVariables: {}
	package: ''' , aPackage name , ''' '
]

{ #category : 'initialization' }
SpTransmissionExample >> connectClassesPresenter [

	classes
		transmitTo: protocols
		transform: [ :aClass | 
			aClass
				ifNotNil: [ 
					aClass protocols
						collect: [ :each | aClass -> each ]
						as: OrderedCollection ]
				ifNil: [ #(  ) ] ]
		postTransmission: [ :destination :origin | destination selectIndex: 1 ].
	
	classes
		transmitTo: code
		transform: [ :aClass | aClass ifNotNil: [ aClass definitionString ] ifNil: [ '' ] ]
]

{ #category : 'initialization' }
SpTransmissionExample >> connectMethodsPresenter [

	methods
		transmitTo: code
		transform: [ :aMethod | aMethod ifNotNil: [ aMethod sourceCode ] ifNil: [ '' ] ]
]

{ #category : 'initialization' }
SpTransmissionExample >> connectPackagesPresenter [

	packages
		transmitTo: classes
		transform: [ :aPackage | 
			aPackage
				ifNotNil: [ aPackage definedClasses asArray ]
				ifNil: [ #(  ) ] ].

	packages
		transmitTo: code
		transform: [ :aPackage | self classTemplateFor: aPackage ]
]

{ #category : 'initialization' }
SpTransmissionExample >> connectPresenters [

	self connectPackagesPresenter.
	self connectClassesPresenter.
	self connectProtocolsPresenter.
	self connectMethodsPresenter
]

{ #category : 'initialization' }
SpTransmissionExample >> connectProtocolsPresenter [

	protocols
		transmitTo: methods
		transform: [ :aPair | 
			aPair
				ifNotNil: [ 
					aPair value methodSelectors
						collect: [ :each | aPair key >> each ]
						as: OrderedCollection ]
				ifNil: [ #(  ) ] ].
			
	protocols
		transmitTo: code
		transform: [ :aPair | aPair ifNotNil: [ aPair key sourceCodeTemplate ] ifNil: [ '' ] ]
]

{ #category : 'layout' }
SpTransmissionExample >> defaultLayout [

	| packagesLayout classesLayout protocolsLayout methodsLayout |
	packagesLayout := SpBoxLayout newTopToBottom
		add: 'Packages' expand: false;
		add: packages;
		yourself.
	
	classesLayout := SpBoxLayout newTopToBottom
		add: 'Classes' expand: false;
		add: classes;
		yourself.
		
	protocolsLayout := SpBoxLayout newTopToBottom
		add: 'Protocols' expand: false;
		add: protocols;
		yourself.
		
	methodsLayout := SpBoxLayout newTopToBottom
		add: 'Methods' expand: false;
		add: methods;
		yourself.
		
	^ SpBoxLayout newTopToBottom
		spacing: 5;
		add: (SpBoxLayout newLeftToRight
			spacing: 5;
			add: packagesLayout;
			add: classesLayout;
			add: protocolsLayout;
			add: methodsLayout;
			yourself);	
		add: code;
		yourself
]

{ #category : 'initialization' }
SpTransmissionExample >> initializeClassesPresenter [

	classes := self newList.
	classes
		display: [ :class | class name];
		displayIcon: [ :aClass | self iconNamed: aClass systemIconName ];
		sortingBlock: [ :a :b | a name < b name ]
]

{ #category : 'initialization' }
SpTransmissionExample >> initializeCodePresenter [

	code := self newCode
]

{ #category : 'initialization' }
SpTransmissionExample >> initializeMethodsPresenter [

	methods := self newList.
	methods
		display: [ :method | method selector ];
		sortingBlock: [ :a :b | a selector < b selector ]
]

{ #category : 'initialization' }
SpTransmissionExample >> initializePackagesPresenter [

	packages := self newList.
	packages
		display: [ :package | package name ];
		displayIcon: [ self iconNamed: #package ];
		sortingBlock: [ :a :b | a name < b name ];
		items: RPackageOrganizer default packages
]

{ #category : 'initialization' }
SpTransmissionExample >> initializePresenters [

	self initializePackagesPresenter.
	self initializeClassesPresenter.
	self initializeProtocolsPresenter.
	self initializeMethodsPresenter.
	self initializeCodePresenter
]

{ #category : 'initialization' }
SpTransmissionExample >> initializeProtocolsPresenter [

	protocols := self newList.
	protocols
		display: [ :aPair | aPair value name ];
		sortingBlock: [ :a :b | a value name < b value name ]
]

{ #category : 'initialization' }
SpTransmissionExample >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Transmission example browser';
		initialExtent: 800 @ 600
]
