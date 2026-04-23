Class {
	#name : 'ReExtractTempCommandTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Refactoring-Commands-Tests',
	#package : 'Spec2-Refactoring-Commands-Tests'
}

{ #category : 'tests' }
ReExtractTempCommandTest >> testExtractTempCommandSuccess [

	| driver command context dialogMock |
	command := StExtractTempCommand new.
	context := StCommandContextMock new
		           sourceInterval: (63 to: 78);
		           selector: #rewriteUsing:;
		           behavior: RBTransformationRuleTestData.
	context method: context.
	command context: context.

	driver := command prepareDriver.
	dialogMock := StRequestDialogMock new.
	dialogMock response: 'tmp22'.
	driver requestDialog: dialogMock.
	driver
		forTesting: true;
		runRefactoring.

	self assert: driver changes changes size equals: 1
]
