"
I represent a validation to apply on a presenter.
I hold the logic to validate the presenter and provide a message if the validation fails.
If you want to provide a custom validation, subclass me.
"
Class {
	#name : #SpAbstractValidation,
	#superclass : #Object,
	#category : #'Spec2-Core-Widgets'
}

{ #category : #testing }
SpAbstractValidation class >> isAbstract [
		
	^ self == SpAbstractValidation
]

{ #category : #testing }
SpAbstractValidation >> isValid: aPresenter [
	self subclassResponsibility
]

{ #category : #accessing }
SpAbstractValidation >> message [
	"The subclasses should return a message to format and show to the user.
    The message can use the following indexes:

    1 - Field name
    2 - Field value"
	^ self subclassResponsibility 
]

{ #category : #accessing }
SpAbstractValidation >> messageFor: field [

	^ self message format: { field name . field value }
]

{ #category : #accessing }
SpAbstractValidation >> validate: aPresenter [

	(self isValid: aPresenter textInput)
		ifFalse: [ aPresenter addValidationError: self ]
]
