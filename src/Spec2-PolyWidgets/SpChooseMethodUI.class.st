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
		'radioButtonClassSide'
	],
	#category : #'Spec2-PolyWidgets-Widgets'
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
SpChooseMethodUI class >> example [
	<example>
	(self openOnAccept: [ :chooseMethodPresenter | chooseMethodPresenter selectedMethod browse ]) withWindowDo: [ :w | w title: 'Select a method example' ]
]

{ #category : #'instance creation' }
SpChooseMethodUI class >> openOnAccept: aBlock [
	| instance |
	instance := self new.
	instance openDialogWithSpec.
	instance withWindowDo: [ :w | w okAction: [ :dialog | aBlock cull: instance cull: dialog ] ].
	^ instance
]

{ #category : #accessing }
SpChooseMethodUI >> classList [
	^ classList
]

{ #category : #utilities }
SpChooseMethodUI >> classMethodsOf: aClass [
	^ aClass class methods
]

{ #category : #initialization }
SpChooseMethodUI >> initializeDialogWindow: aDialog [
	super initializeDialogWindow: aDialog.
	aDialog
		initialExtent: 550 @ 350;
		title: 'Select a method'
]

{ #category : #initialization }
SpChooseMethodUI >> initializePresenter [
	packageList
		transmitTo: classList
		transform: [ :selectedPacakge | selectedPacakge classes asOrderedCollection ]
		postTransmission: [ classList selectIndex: 1 ].

	classList
		transmitTo: methodList
		transform: [ :selectedClass | selectedClass ifNotNil: [ self methodsToDisplayOf: selectedClass ] ifNil: [ #() ] ]
		postTransmission: [ :destination | destination selectIndex: 1 ].

	radioButtonClassSide whenActivatedDo: [ methodList items: (self classMethodsOf: self selectedClass) ].

	radioButtonInstanceSide whenActivatedDo: [ methodList items: (self instanceMethodsOf: self selectedClass) ].

	packageList selectIndex: 1
]

{ #category : #initialization }
SpChooseMethodUI >> initializeWidgets [
	packageList := self newList.
	classList := self newList.
	methodList := self newList.
	radioButtonClassSide := self newRadioButton.
	radioButtonInstanceSide := self newRadioButton.

	packageList
		items: RPackageOrganizer default packages;
		displayBlock: #name;
		sortingBlock: #name ascending;
		icons: [ :item | self iconNamed: #package ].

	classList
		sortingBlock: #name ascending;
		icons: [ :item | self iconNamed: item systemIconName ].

	methodList
		sortingBlock: #selector ascending;
		displayBlock: #selector.

	radioButtonClassSide label: 'class side'.
	radioButtonInstanceSide
		label: 'instance side';
		state: true.

	radioButtonInstanceSide associatedRadioButtons: {radioButtonClassSide}.

	self focusOrder
		add: packageList;
		add: classList;
		add: methodList
]

{ #category : #utilities }
SpChooseMethodUI >> instanceMethodsOf: aClass [
	^ aClass methods
]

{ #category : #testing }
SpChooseMethodUI >> isInstanceButtonSelected [
	^ radioButtonInstanceSide state
]

{ #category : #accessing }
SpChooseMethodUI >> methodList [
	^ methodList
]

{ #category : #utilities }
SpChooseMethodUI >> methodsToDisplayOf: aClass [
	^ (self isInstanceButtonSelected ifTrue: [ self instanceMethodsOf: aClass ] ifFalse: [ self classMethodsOf: aClass ]) asOrderedCollection
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

{ #category : #accessing }
SpChooseMethodUI >> selectedClass [
	^ classList selectedItem
]

{ #category : #accessing }
SpChooseMethodUI >> selectedMethod [
	^ methodList selectedItem
]

{ #category : #accessing }
SpChooseMethodUI >> selectedPackage [
	^ packageList selectedItem
]
