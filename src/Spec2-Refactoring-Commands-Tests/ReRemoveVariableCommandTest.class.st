Class {
	#name : 'ReRemoveVariableCommandTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Refactoring-Commands-Tests',
	#package : 'Spec2-Refactoring-Commands-Tests'
}

{ #category : 'tests' }
ReRemoveVariableCommandTest >> testRemoveVariableToClassSideCommandSuccess [

	| driver command context |
	command := StRemoveVariableCommand new.
	context := StCommandContextMock new
		           name: 'foo1';
		           behavior: RBLintRuleTestData .
	context variable: context.
	command context: context.
	driver := command prepareDriver.
	driver
		forTesting: true;
		runRefactoring.

	self assert: driver changes changes size equals: 1
]
