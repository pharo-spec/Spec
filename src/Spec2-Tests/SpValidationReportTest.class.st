Class {
	#name : #SpValidationReportTest,
	#superclass : #TestCase,
	#instVars : [
		'report'
	],
	#category : #'Spec2-Tests-Validation'
}

{ #category : #running }
SpValidationReportTest >> setUp [
	super setUp.
	report := SpValidationReport new.
]

{ #category : #tests }
SpValidationReportTest >> testCanAddValidationFailure [
	report add: SpRequiredFieldValidation new.
	
	self assert: report hasErrors
]
