"
The presenter that provides only the standalone form for the form demo
"
Class {
	#name : #SpDemoStandaloneFormPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'workingModel',
		'nameTextInput',
		'surnameTextInput',
		'number1Input',
		'number2Input',
		'scaleInput',
		'passwordInput',
		'checkboxInput',
		'dateInput',
		'genderButtons',
		'maleButton',
		'femaleButton',
		'itemsInput',
		'submitButton',
		'restoreButton'
	],
	#category : #'Spec2-Examples-Demo-Forms'
}

{ #category : #'instance creation' }
SpDemoStandaloneFormPresenter class >> open [
	<example>
	(self on: SpDemoFormModel new) open
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> checkboxInput [
	^ checkboxInput
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> checkboxInput: anObject [
	checkboxInput := anObject
]

{ #category : #initialization }
SpDemoStandaloneFormPresenter >> connectPresenters [
	self submitButton action: [ self submit ].
	self restoreButton action: [ self restore ]
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> dateInput [
	^ dateInput
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> dateInput: anObject [
	dateInput := anObject
]

{ #category : #layout }
SpDemoStandaloneFormPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: (SpGridLayout build: [ :builder |
			builder
				add: 'Name:'; add: nameTextInput; nextRow;
				add: 'Surname:'; add: surnameTextInput; nextRow;
				add: 'Number 1:'; add: number1Input; nextRow;
				add: 'Number 2:'; add: number2Input; nextRow;
				add: 'Scale:'; add: scaleInput; nextRow;
				add: 'Password:'; add: passwordInput; nextRow;
				add: 'Remember me:'; add: checkboxInput; nextRow;
				"SpDatePresenter is exclusive from Morphic backend for the moment"
				"add: 'Date:';
				add: #dateInput;
				nextRow;"
				add: 'Gender:'; add: (SpBoxLayout newLeftToRight
					add: maleButton;
					add: femaleButton;
					yourself) ]);
		add: (SpBoxLayout newLeftToRight
			spacing: 5;
			add: submitButton;
			add: restoreButton;
			yourself)
		expand: false;
		yourself
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> femaleButton [
	^ femaleButton
]

{ #category : #'model updates' }
SpDemoStandaloneFormPresenter >> fillFormWithWorkingModel [
	| aModel |
	aModel := self workingModel.
	self nameTextInput text: aModel name.
	self surnameTextInput text: aModel surname.
	self number1Input text: aModel number1 asString.
	self number2Input text: aModel number2 asString.
	self scaleInput value: aModel scale.
	self passwordInput text: aModel password.
	self checkboxInput state: aModel rememberMe.
	"self dateInput date: aModel date."
	(genderButtons at: aModel gender) state: true.

	self itemsInput selectItems: self workingModel selectedItems
]

{ #category : #'model updates' }
SpDemoStandaloneFormPresenter >> fillModelWithFormContent [

	self workingModel
		name: self nameTextInput text;
		surname: self surnameTextInput text;
		number1: number1Input number;
		number2: number2Input number;
		scale: self scaleInput value;
		password: self passwordInput text;
		rememberMe: self checkboxInput state;
		date: self dateInput date.

	self workingModel gender: (genderButtons associations detect: [ :each | each value state ]) key.
	
	self workingModel selectedItems: self itemsInput selectedItems.

]

{ #category : #initialization }
SpDemoStandaloneFormPresenter >> initializePresenters [

	nameTextInput := self newTextInput.

	surnameTextInput := self newTextInput.
	surnameTextInput placeholder: 'empty'.

	number1Input := self newNumberInput.

	number2Input := self newNumberInput
		beFloat;
		digits: 3;
		climbRate: 0.005;
		minimum: 10.005;
		maximum: 20.05.

	scaleInput := self newSlider.

	passwordInput := self newTextInput bePassword.

	checkboxInput := self newCheckBox state: true.

	dateInput := self instantiate: SpDatePresenter.
	dateInput display: [ :item | item yyyymmdd ].

	maleButton := self newRadioButton label: 'male'.
	femaleButton := self newRadioButton label: 'female'.
	maleButton associatedRadioButtons: {femaleButton}.
	genderButtons := Dictionary newFrom: {
		(#male -> maleButton).
		(#female -> femaleButton)}.

	itemsInput := self newList.
	itemsInput beMultipleSelection.
	itemsInput items: self model items.

	submitButton := self newButton label: 'Submit'.
	restoreButton := self newButton label: 'Restore'
]

{ #category : #initialization }
SpDemoStandaloneFormPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		initialExtent: 400@400
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> itemsInput [
	^ itemsInput
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> itemsInput: anObject [
	itemsInput := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> maleButton [
	^ maleButton
]

{ #category : #initialization }
SpDemoStandaloneFormPresenter >> modelChanged [

	workingModel := self model copy.

	self fillFormWithWorkingModel.

	
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> nameTextInput [
	^ nameTextInput
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> nameTextInput: anObject [
	nameTextInput := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> number1Input [
	^ number1Input
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> number1Input: anObject [
	number1Input := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> number2Input [
	^ number2Input
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> number2Input: anObject [
	number2Input := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> passwordInput [
	^ passwordInput
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> passwordInput: anObject [
	passwordInput := anObject
]

{ #category : #actions }
SpDemoStandaloneFormPresenter >> restore [

	self modelChanged

	
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> restoreButton [
	^ restoreButton
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> restoreButton: anObject [
	restoreButton := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> scaleInput [
	^ scaleInput
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> scaleInput: anObject [
	scaleInput := anObject
]

{ #category : #actions }
SpDemoStandaloneFormPresenter >> submit [

	self fillModelWithFormContent.
	
	self model: workingModel.
	self announcingObject valueChanged.
	
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> submitButton [
	^ submitButton
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> submitButton: anObject [
	submitButton := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> surnameTextInput [
	^ surnameTextInput
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> surnameTextInput: anObject [
	surnameTextInput := anObject
]

{ #category : #'accessing - model' }
SpDemoStandaloneFormPresenter >> workingModel [
	^ workingModel
]

{ #category : #'accessing - model' }
SpDemoStandaloneFormPresenter >> workingModel: anObject [
	workingModel := anObject
]
