Class {
	#name : 'ReInlineMethodCommandTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Refactoring-Commands-Tests',
	#package : 'Spec2-Refactoring-Commands-Tests'
}

{ #category : 'tests' }
ReInlineMethodCommandTest >> testInlineMethodCommandSuccess [

	| driver command context |
	command := StInlineMethodCommand new.
	context := StCommandContextMock new
		           sourceInterval: (63 to: 78);
		           selector: #rewriteUsing:;
		           origin: RBTransformationRuleTestData.
	context selectedMethod: context.
	command context: context.
	driver := command prepareDriver.
	driver
		forTesting: true;
		runRefactoring.

	self assert: driver changes changes size equals: 1
]
