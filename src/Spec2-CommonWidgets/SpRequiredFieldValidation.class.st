"
I ensure the presenter I will validate has data and is not blank!
"
Class {
	#name : 'SpRequiredFieldValidation',
	#superclass : 'SpAbstractValidation',
	#category : 'Spec2-CommonWidgets-Validation',
	#package : 'Spec2-CommonWidgets',
	#tag : 'Validation'
}

{ #category : 'testing' }
SpRequiredFieldValidation >> isValid: aPresenter [

	^ aPresenter text isNotNil and: [ aPresenter text trim isNotEmpty ]
]

{ #category : 'accessing' }
SpRequiredFieldValidation >> message [

	^ '{1} is required'
]
