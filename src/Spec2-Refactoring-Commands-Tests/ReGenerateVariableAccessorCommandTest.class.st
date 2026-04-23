Class {
	#name : 'ReGenerateVariableAccessorCommandTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Refactoring-Commands-Tests',
	#package : 'Spec2-Refactoring-Commands-Tests'
}

{ #category : 'tests' }
ReGenerateVariableAccessorCommandTest >> testGenerateAccessorCommandSuccess [

	| driver command context |
	command := StGenerateVariableAccessorCommand new.
	context := StCommandContextMock new
		           origin: RBTransformationRuleTestData;
		           name: #builder.
	context selectedMethod: context.
	command context: context.
	driver := command prepareDriver.
	driver
		forTesting: true;
		runRefactoring.

	self assert: driver changes changes size equals: 2
]
