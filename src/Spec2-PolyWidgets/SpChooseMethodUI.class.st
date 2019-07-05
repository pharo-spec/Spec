"
i'm an UI to select a method , package , class 

HOW TO USE in your UI:
1 - use BIChooseMethodUi class method openOn: 
2 - you will have to define the method 'acceptAction: aReferenceOfBIChooseMethod' , this method use the pattern visitor , in this method you will define the action of okButton 
	for example you can use to select a class 

 
Internal Representation and Key Implementation Points.

    Instance Variables
	classList:		<ListPresenter>
	isInstanceButtonSelected:		<Boolean>
	methodList:		<ListPresenter>
	packageList:		<ListPresenter>
	radioButtonClassSide:		<RadioButtonPresenter>
	radioButtonInstanceSide:		<RadioButtonPresenter>
	uiReceiver:		<subClassOfComposablePresenter> a reference to a UI


    Implementation Points
"
Class {
	#name : #SpChooseMethodUI,
	#superclass : #ComposablePresenter,
	#instVars : [
		'packageList',
		'classList',
		'methodList',
		'radioButtonInstanceSide',
		'radioButtonClassSide',
		'isInstanceButtonSelected',
		'uiReceiver'
	],
	#category : #'Spec2-PolyWidgets'
}

{ #category : #specs }
SpChooseMethodUI class >> defaultSpec [
	<spec>
	^ SpecBoxLayout newHorizontal
		add: #packageList;
		add: #classList;
		add:
			(SpecBoxLayout newVertical
				add: #methodList;
				add:
					(SpecBoxLayout newHorizontal
						add: #radioButtonInstanceSide;
						add: #radioButtonClassSide;
						yourself)  withConstraints: [:contraint  |contraint height: 20] ;
				yourself);
		yourself
]

{ #category : #examples }
SpChooseMethodUI class >> main [ 
	<example>
		^ self openOn: nil .
]

{ #category : #'as yet unclassified' }
SpChooseMethodUI class >> open: aWindowPresenter withExtent: aPoint [ 
	aWindowPresenter extent: aPoint.
]

{ #category : #'instance creation' }
SpChooseMethodUI class >> openOn: aUI [
	| window |
	window := self new
		uiReceiver: aUI;
		yourself.
	self open: window openDialogWithSpec withExtent: 550@350.
	^ window
]

{ #category : #specs }
SpChooseMethodUI class >> title [
	^ 'method chooser'
]

{ #category : #accessing }
SpChooseMethodUI >> classList [
	^ classList
]

{ #category : #util }
SpChooseMethodUI >> classMethodsOfSelectedClassItem: selectedClass [
	^ selectedClass class methods asOrderedCollection
]

{ #category : #initialization }
SpChooseMethodUI >> initializeDialogWindow: aDialog [
	super initializeDialogWindow: aDialog.
	aDialog okAction: [ :presenter | uiReceiver acceptActionBIChooseMethod: self  ]
]

{ #category : #initialization }
SpChooseMethodUI >> initializePresenter [
	packageList
		transmitTo: classList
		transform: [ :selectedPacakge | selectedPacakge classes asOrderedCollection ]
		postTransmission: [ classList items isEmpty
				ifTrue: [ classList selectIndex: 0 ]
				ifFalse: [ classList selectIndex: 1 ] ].
	classList
		transmitTo: methodList
		transform: [ :selectedClass | 
			selectedClass
				ifNotNil: [ isInstanceButtonSelected
						ifTrue: [ self instanceMethodsOfSelectedClassItem: selectedClass ]
						ifFalse: [ self classMethodsOfSelectedClassItem: selectedClass ] ]
				ifNil: [ {} asOrderedCollection ] ]
		postTransmission: [ :destination | 
			destination items isEmpty
				ifTrue: [ destination selectIndex: 0 ]
				ifFalse: [ destination selectIndex: 1 ] ].
	radioButtonClassSide
		whenActivatedDo: [ isInstanceButtonSelected := false.
			methodList
				items:
					(self
						classMethodsOfSelectedClassItem: classList selection selectedItem) ].
	radioButtonInstanceSide
		whenActivatedDo: [ isInstanceButtonSelected := true.
			methodList
				items:
					(self
						instanceMethodsOfSelectedClassItem: classList selection selectedItem) ]
]

{ #category : #initialization }
SpChooseMethodUI >> initializeWidgets [
	packageList := self newList.
	classList := self newList.
	methodList := self newList.
	radioButtonClassSide := self newRadioButton.
	radioButtonInstanceSide := self newRadioButton.
	self setupPackageList.
	self setupClassList.
	self setupMethodList.
	self setupRadioButtons.
	self focusOrder
		add: packageList;
		add: classList;
		add: methodList
]

{ #category : #util }
SpChooseMethodUI >> instanceMethodsOfSelectedClassItem: selectedClass [
	^ selectedClass methods asOrderedCollection
]

{ #category : #accessing }
SpChooseMethodUI >> isInstanceButtonSelected [
	^ isInstanceButtonSelected
]

{ #category : #accessing }
SpChooseMethodUI >> methodList [
	^ methodList
]

{ #category : #accessing }
SpChooseMethodUI >> packageList [
	^ packageList
]

{ #category : #accessing }
SpChooseMethodUI >> radioButtonClassSide [
	^ radioButtonClassSide
]

{ #category : #accessing }
SpChooseMethodUI >> radioButtonInstanceSide [
	^ radioButtonInstanceSide
]

{ #category : #'initialize-widgets' }
SpChooseMethodUI >> setupClassList [
	classList
		items: (packageList selection selectedItem classes asOrderedCollection sort: [:a :b |a name < b name]);
		icons: [:item |self iconNamed: #system  ];
		selectIndex: 1
]

{ #category : #'initialize-widgets' }
SpChooseMethodUI >> setupMethodList [
	methodList
		items: (classList selection selectedItem methods sort: [:a :b |a selector < b selector]);
		displayBlock: [ :item | item selector ];
		selectIndex: 1
]

{ #category : #'initialize-widgets' }
SpChooseMethodUI >> setupPackageList [
	
	packageList
		items: (RPackageOrganizer default packages sort: [:a :b | a name < b name]);
		icons: [:item |self iconNamed: #package];
		displayBlock: [ :item | item name ];
		selectIndex: 1
]

{ #category : #'initialize-widgets' }
SpChooseMethodUI >> setupRadioButtons [
	radioButtonClassSide
		label: 'class side';
		associatedRadioButtons: radioButtonInstanceSide asOrderedCollection.
	radioButtonInstanceSide
		label: 'instance side';
		associatedRadioButtons: radioButtonClassSide asOrderedCollection.
	"instance radioButton is selected at initialisation"
	isInstanceButtonSelected := true.
]

{ #category : #accessing }
SpChooseMethodUI >> uiReceiver [
	^ uiReceiver
]

{ #category : #accessing }
SpChooseMethodUI >> uiReceiver: anObject [
	uiReceiver := anObject
]
