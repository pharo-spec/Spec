Class {
	#name : 'ReRenameClassCommandTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Refactoring-Commands-Tests',
	#package : 'Spec2-Refactoring-Commands-Tests'
}

{ #category : 'tests' }
ReRenameClassCommandTest >> testRenameClassCommandSucess [

	| driver command context dialogMock |
	command := StRenameClassCommand new.
	context := StCommandContextMock new name: #ReClassToConvertTemporaryToInstanceVariable.
	command context: context.
	driver := command prepareDriver.
	dialogMock := StRequestDialogMock new.
	dialogMock response: 'NewClassNameForTest'.
	driver requestDialog: dialogMock.
	driver
		forTesting: true;
		runRefactoring.

	self assert: driver changes changes size equals: 5.

]
