Class {
	#name : 'ReProtectVariableCommandTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Refactoring-Commands-Tests',
	#package : 'Spec2-Refactoring-Commands-Tests'
}

{ #category : 'tests' }
ReProtectVariableCommandTest >> testPushUpVariableToClassSideCommandSuccess [

	| driver command context ast node method |
	command := StProtectVariableCommand new.
	method := RBBasicLintRuleTestData >> #result.
	ast := OpalCompiler new
		       class: method methodClass;
		       parse: method sourceCode.
	node := ast allChildren detect: [ :n | n isVariable and: [ n name = 'result' ] ].
	context := StCommandContextMock new
		           variable: node variable;
		           behavior: RBBasicLintRuleTestData.
	command context: context.
	driver := command prepareDriver.
	driver
		forTesting: true;
		runRefactoring.

	self assert: driver changes changes size equals: 1
]
