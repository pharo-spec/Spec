"
A validation report is used to collect possible validation failures in a tree of presenters.
It holds errors so that the caller of the validation can determine if the validation is successful or provide a useful feedback to the user on failed validations.
"
Class {
	#name : #SpValidationReport,
	#superclass : #Object,
	#instVars : [
		'errors'
	],
	#category : #'Spec2-Core-Utils'
}

{ #category : #adding }
SpValidationReport >> add: aValidationFailure [ 
	errors add: aValidationFailure
]

{ #category : #adding }
SpValidationReport >> addAll: aListOfValidationFailure [ 
	errors addAll: aListOfValidationFailure 
]

{ #category : #accessing }
SpValidationReport >> errors [
	^ errors
]

{ #category : #testing }
SpValidationReport >> hasErrors [

	^ errors isNotEmpty
]

{ #category : #initialization }
SpValidationReport >> initialize [ 
	errors := OrderedCollection new.
]
