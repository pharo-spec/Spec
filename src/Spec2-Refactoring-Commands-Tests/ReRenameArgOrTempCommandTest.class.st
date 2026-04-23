Class {
	#name : 'ReRenameArgOrTempCommandTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Refactoring-Commands-Tests',
	#package : 'Spec2-Refactoring-Commands-Tests'
}

{ #category : 'tests' }
ReRenameArgOrTempCommandTest >> testRenameArgOrTempCommandSuccess [

	| driver command context method ast node dialogMock |
	method := ReClassToConvertTemporaryToInstanceVariable >> #doAction1.
	ast := OpalCompiler new parse: method sourceCode.
	node := ast allChildren detect: [ :n | n isVariable and: [ n name = 'temp' ] ].

	command := StRenameArgOrTempCommand new.
	context := StCommandContextMock new
		           method: method;
		           selectedNode: node.
	command context: context.
	driver := command prepareDriver.
	dialogMock := StRequestDialogMock new.
	dialogMock response: 'tmp2'.
	driver requestDialog: dialogMock.
	driver
		forTesting: true;
		runRefactoring.

	self assert: driver changes changes size equals: 1
]
