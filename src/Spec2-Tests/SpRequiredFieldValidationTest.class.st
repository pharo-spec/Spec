Class {
	#name : 'SpRequiredFieldValidationTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'tests' }
SpRequiredFieldValidationTest >> testValidationIsKoWhenTextIsEmpty [
	| validation presenter |
	presenter := SpTextInputFieldPresenter new
		text: '';
		yourself.
	validation := SpRequiredFieldValidation new.
	
	self deny: (validation isValid: presenter )
]

{ #category : 'tests' }
SpRequiredFieldValidationTest >> testValidationIsKoWhenTextIsNil [
	| validation presenter |
	presenter := SpTextInputFieldPresenter new
		text: nil;
		yourself.
	validation := SpRequiredFieldValidation new.
	
	self deny: (validation isValid: presenter )
]

{ #category : 'tests' }
SpRequiredFieldValidationTest >> testValidationIsKoWhenTextOnlyHasWhiteSpaces [
	| validation presenter |
	presenter := SpTextInputFieldPresenter new
		text: '       ';
		yourself.
	validation := SpRequiredFieldValidation new.
	
	self deny: (validation isValid: presenter )
]

{ #category : 'tests' }
SpRequiredFieldValidationTest >> testValidationIsOkWhenTextContainsOneChar [
	| validation presenter |
	presenter := SpTextInputFieldPresenter new
		text: 'a';
		yourself.
	validation := SpRequiredFieldValidation new.
	
	self assert: (validation isValid: presenter )
]
