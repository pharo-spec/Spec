"
I'm a text field with a validation of the input when submitting.
I provide a visual feedback (icon) of the validation.
I also have a name that is used to customide the validation error message.

Here is an example:
self example

If you submit without entering text, you will see the error icon. Hovering the error icon will show the error message.
"
Class {
	#name : #SpTextInputFieldWithValidationPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'textInput',
		'statusIcon',
		'validations',
		'validationErrors',
		'name'
	],
	#category : #'Spec2-Core-Widgets'
}

{ #category : #examples }
SpTextInputFieldWithValidationPresenter class >> example [
	<example>
	
	^ self new
		text: '';
		placeholder: 'A placeholder';
		beRequired;
		openWithSpec;
		yourself
]

{ #category : #api }
SpTextInputFieldWithValidationPresenter >> addValidation: aSpValidation [ 
	self validations add: aSpValidation.
]

{ #category : #validation }
SpTextInputFieldWithValidationPresenter >> addValidationError: aSpValidation [ 
	validationErrors add: aSpValidation
]

{ #category : #api }
SpTextInputFieldWithValidationPresenter >> beRequired [
	self addValidation: SpRequiredFieldValidation new
]

{ #category : #specs }
SpTextInputFieldWithValidationPresenter >> defaultLayout [ 
		
	^ SpBoxLayout newLeftToRight
		vAlignStart;
		add: textInput;
		add: statusIcon expand: false;
		yourself
]

{ #category : #accessing }
SpTextInputFieldWithValidationPresenter >> errorIcon [
	^ self iconNamed: #smallError
]

{ #category : #validation }
SpTextInputFieldWithValidationPresenter >> errorIconMessage [

	^ String streamContents: [ :stream |
			validationErrors 
				do: [ :anError | stream nextPutAll: (anError messageFor: self) ] 
				separatedBy: [ stream cr ]]
]

{ #category : #api }
SpTextInputFieldWithValidationPresenter >> icon: aForm [ 
	statusIcon image: aForm
]

{ #category : #initialization }
SpTextInputFieldWithValidationPresenter >> initializePresenters [ 
	textInput := self newTextInput
		whenSubmitDo: [ self submit ];
		yourself.
	statusIcon := self newImage.
	
	self layout: self defaultLayout
]

{ #category : #api }
SpTextInputFieldWithValidationPresenter >> isValid [
	^ validationErrors isEmptyOrNil
]

{ #category : #accessing }
SpTextInputFieldWithValidationPresenter >> name [
	^ name
]

{ #category : #api }
SpTextInputFieldWithValidationPresenter >> name: aString [ 
	name := aString
]

{ #category : #accessing }
SpTextInputFieldWithValidationPresenter >> okIcon [
	^ self iconNamed: #smallOk
]

{ #category : #api }
SpTextInputFieldWithValidationPresenter >> placeholder: aString [ 
	textInput placeholder: aString
]

{ #category : #accessing }
SpTextInputFieldWithValidationPresenter >> statusIcon [
	^ statusIcon 
]

{ #category : #simulating }
SpTextInputFieldWithValidationPresenter >> submit [
	
	self validate.
]

{ #category : #accessing }
SpTextInputFieldWithValidationPresenter >> text [
	^ self textInput text
]

{ #category : #api }
SpTextInputFieldWithValidationPresenter >> text: aString [ 
	textInput text: aString
]

{ #category : #accessing }
SpTextInputFieldWithValidationPresenter >> textInput [
	^ textInput 
]

{ #category : #validation }
SpTextInputFieldWithValidationPresenter >> updateStatus [
	
	statusIcon 
		image: (self isValid ifTrue: [ self okIcon ] ifFalse: [ self errorIcon ]);
		help: (self isValid ifTrue: [ '' ] ifFalse: [ self errorIconMessage ]).
	  
]

{ #category : #validation }
SpTextInputFieldWithValidationPresenter >> validate [
	validationErrors := OrderedCollection new.
	self validations do: [ :validation | validation validate: self ].
	self updateStatus.
]

{ #category : #accessing }
SpTextInputFieldWithValidationPresenter >> validations [ 
	^ validations ifNil: [ validations := OrderedCollection new ]
]
