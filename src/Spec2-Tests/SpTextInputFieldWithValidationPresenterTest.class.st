Class {
	#name : #SpTextInputFieldWithValidationPresenterTest,
	#superclass : #SpAbstractTextPresenterTest,
	#category : #'Spec2-Tests-Core-Widgets'
}

{ #category : #testing }
SpTextInputFieldWithValidationPresenterTest class >> shouldInheritSelectors [
	^ false
]

{ #category : #accessing }
SpTextInputFieldWithValidationPresenterTest >> classToTest [
	^ SpTextInputFieldWithValidationPresenter
]

{ #category : #tests }
SpTextInputFieldWithValidationPresenterTest >> testErrorIconIsPresentWhenValidationFails [	
	presenter 
		beRequired;
		submit.
	
	self deny: presenter isValid.
	self assert: presenter statusIcon image equals: presenter errorIcon.
]

{ #category : #tests }
SpTextInputFieldWithValidationPresenterTest >> testErrorMessageIsPresentWhenValidationFails [	
	presenter
		name: 'city';
		beRequired;
		submit.
	
	self deny: presenter isValid.
	self assert: presenter statusIcon help equals: 'city is required'.
]

{ #category : #tests }
SpTextInputFieldWithValidationPresenterTest >> testOkIconIsPresentWhenValidationIsOk [
	presenter 
		beRequired;
		text: 'ok';
		submit.
	
	self assert: presenter isValid.
	self assert: presenter statusIcon image equals: presenter okIcon.
]
