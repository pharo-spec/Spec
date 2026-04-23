Class {
	#name : 'RePushUpVariableCommandTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Refactoring-Commands-Tests',
	#package : 'Spec2-Refactoring-Commands-Tests'
}

{ #category : 'tests' }
RePushUpVariableCommandTest >> testPushUpVariableToClassSideCommandSuccess [

	| driver command context ast node method |
	command := StPushUpVariableCommand new.
	method := RBTransformationRuleTestData >> #isEmpty.
	ast := OpalCompiler new
		       class: method methodClass;
		       parse: method sourceCode.
	node := ast allChildren detect: [ :n | n isVariable and: [ n name = 'builder' ] ].
	context := StCommandContextMock new
		           variable: node variable;
		           behavior: RBTransformationRuleTestData.
	command context: context.
	driver := command prepareDriver.
	driver
		forTesting: true;
		runRefactoring.

	self assert: driver changes changes size equals: 2
]
