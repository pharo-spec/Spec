Class {
	#name : 'ReConvertTemporaryToInstanceVariableCommandTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Refactoring-Commands-Tests',
	#package : 'Spec2-Refactoring-Commands-Tests'
}

{ #category : 'tests' }
ReConvertTemporaryToInstanceVariableCommandTest >> testConvertTempCommandSuccess [

	| driver command context |
	command := StConvertTempToInstVarCommand new.
	context := StCommandContextMock new
		           name: #temp;
		           behavior: ReClassToConvertTemporaryToInstanceVariable;
		           selector: #doAction1.
	context method: context.
	command context: context.
	driver := command prepareDriver.
	driver
		forTesting: true;
		runRefactoring.

	self assert: driver changes changes size equals: 2
]
