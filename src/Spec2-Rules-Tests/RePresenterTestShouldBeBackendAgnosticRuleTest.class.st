"
I test `RePresenterTestShouldBeBackendAgnosticRule`, the rule reporting presenter tests that reach the backend (`widget`, `allMorphs`, `submorphs`, `currentWorld`, `World`, `UIManager`).

## Responsibility:

- Check that each reported send and global is reported, once per node, also in blocks and on the class side, and that the critique is anchored on the reported node.
- Check the scope: presenter tests, directly or through a superclass, are reported; tests referencing no presenter, tests of backend packages and presenters themselves are not.
- Check the package name convention (`isBackendTestPackageName:`) and the method filter (`shouldCheckMethod:`).

## Collaborators: 

- `ReAbstractRuleTestCase`: derives the rule from my name (`subjectUnderTest`).
- Fixture classes built in `setUp` with the class builder in a private `SystemEnvironment` with its own announcer, registered in packages of that environment, and compiled without logging: they are neither installed nor logged, so nothing stays in the image. `World` and `UIManager` are bound there to stand-in objects, so the tests need no backend.

## Internal Representation

- `environment`: the private environment of the fixtures.
- `presenterTest`: a `TestCase` subclass of a Spec test package referencing `SpButtonPresenter`.
- `plainTest`: a `TestCase` subclass referencing no presenter.
- `backendTest`: a `TestCase` subclass referencing a presenter, in a backend test package.
- `presenter`: an `SpPresenter` subclass.
"
Class {
	#name : 'RePresenterTestShouldBeBackendAgnosticRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#instVars : [
		'environment',
		'presenterTest',
		'plainTest',
		'backendTest',
		'presenter'
	],
	#category : 'Spec2-Rules-Tests',
	#package : 'Spec2-Rules-Tests'
}

{ #category : 'helpers' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> compile: aSource in: aBehavior [
	"Compile aSource in aBehavior, a fixture, without logging it, and answer the method."

	^ aBehavior >> (aBehavior
		   compile: aSource
		   classified: #fixture
		   withStamp: nil
		   logSource: false)
]

{ #category : 'helpers' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> critiquesOn: aSource in: aBehavior [
	"Compile aSource in aBehavior and answer the critiques of the rule on the nodes of the method."

	| method rule critiques |
	method := self compile: aSource in: aBehavior.
	rule := self subjectUnderTest new.
	critiques := OrderedCollection new.
	method ast nodesDo: [ :node | rule check: node forCritiquesDo: [ :critique | critiques add: critique ] ].
	^ critiques
]

{ #category : 'helpers' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> newFixtureNamed: aSymbol superclass: aClass package: aString [
	"Answer a class built in my private environment and registered in the package named aString of that environment. It is neither installed nor logged, so tearDown has nothing to remove."

	| class |
	class := (aClass << aSymbol)
		         environment: environment;
		         build.
	(environment organization ensurePackage: aString) addClass: class.
	^ class
]

{ #category : 'running' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> setUp [

	super setUp.
	environment := SystemEnvironment new.
	environment codeChangeAnnouncer: Announcer new.
	#( #FixedLayout #TestCase #SpPresenter #SpButtonPresenter ) do: [ :each |
		environment at: each put: (self class environment at: each) ].
	"Stand-ins: the rule recognizes these globals by their name, so the tests need no backend."
	#( #World #UIManager ) do: [ :each | environment at: each put: Object new ].
	presenterTest := self newFixtureNamed: #RePresenterTestFixture superclass: TestCase package: 'Spec2-Fixture-Tests'.
	self compile: 'newPresenter ^ SpButtonPresenter new' in: presenterTest.
	plainTest := self newFixtureNamed: #RePlainTestFixture superclass: TestCase package: 'Kernel-Fixture-Tests'.
	backendTest := self newFixtureNamed: #ReBackendTestFixture superclass: TestCase package: 'Spec2-Backend-Fixture-Tests'.
	self compile: 'newPresenter ^ SpButtonPresenter new' in: backendTest.
	presenter := self newFixtureNamed: #ReFixturePresenter superclass: SpPresenter package: 'Spec2-Fixture'
]

{ #category : 'tests - not reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testAdapterSendIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ self newPresenter adapter' in: presenterTest)
]

{ #category : 'tests - reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testAllMorphsSendIsReported [

	self assert: (self critiquesOn: 'foo ^ self newPresenter allMorphs' in: presenterTest) size equals: 1
]

{ #category : 'tests - not reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testBackendTestIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ self newPresenter adapter widget' in: backendTest)
]

{ #category : 'tests - not reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testBackendTestPackageNamesAreRecognized [

	#( 'Spec2-Backend-Tests' 'Spec2-Morphic-Backend-Tests' 'Spec2-Adapters-Morphic-Tests' 'Spec2-Morphic-Tests' 'Morphic-Tests'
	   'Toplo-Tests' 'Bloc-Tests' ) do: [ :each | self assert: (self subjectUnderTest isBackendTestPackageName: each) ]
]

{ #category : 'tests - reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testClassSideOfPresenterTestIsReported [

	self assert: (self critiquesOn: 'foo ^ self currentWorld' in: presenterTest class) size equals: 1
]

{ #category : 'tests - reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testCritiqueIsOnTheReportedSend [

	| method critique interval |
	method := self compile: 'foo ^ self newPresenter adapter widget' in: presenterTest.
	critique := (self critiquesOn: method sourceCode in: presenterTest) first.
	interval := critique sourceAnchor interval.
	self assert: (method sourceCode copyFrom: interval first to: interval last) equals: 'self newPresenter adapter widget'
]

{ #category : 'tests - reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testCurrentWorldSendIsReported [

	self assert: (self critiquesOn: 'foo ^ self currentWorld' in: presenterTest) size equals: 1
]

{ #category : 'tests - reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testEachSendIsReported [

	self assert: (self critiquesOn: 'foo self currentWorld. ^ self newPresenter adapter widget' in: presenterTest) size equals: 2
]

{ #category : 'tests - not reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testOtherGlobalReferenceIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ SpButtonPresenter' in: presenterTest)
]

{ #category : 'tests - not reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testPresenterIsNotReported [
	"Presenters themselves are checked by RePresenterShouldNotViolateLayerRule."

	self assertEmpty: (self critiquesOn: 'foo ^ self currentWorld' in: presenter)
]

{ #category : 'tests - reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testPresenterReferenceInBlockIsReported [

	self assert: (self critiquesOn: 'foo ^ [ SpButtonPresenter new ] value adapter widget' in: plainTest) size equals: 1
]

{ #category : 'tests - reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testPresenterReferenceInMethodItselfIsReported [

	self assert: (self critiquesOn: 'foo ^ SpButtonPresenter new adapter widget' in: plainTest) size equals: 1
]

{ #category : 'tests - reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testPresenterTestPackageNamesAreNotBackend [

	#( 'Spec2-Tests' 'Spec2-Code-Tests' 'NewTools-Debugger-Tests' 'Microdown-RichTextPresenter-Tests'
	   'Spec2-ListView-Tests' ) do: [ :each | self deny: (self subjectUnderTest isBackendTestPackageName: each) ]
]

{ #category : 'tests - reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testSendInBlockIsReported [

	self assert: (self critiquesOn: 'foo ^ [ self currentWorld ] value' in: presenterTest) size equals: 1
]

{ #category : 'tests - reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testShouldCheckMethodReferencingReportedGlobal [

	self assert: (self subjectUnderTest new shouldCheckMethod: (self compile: 'foo ^ World' in: presenterTest))
]

{ #category : 'tests - reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testShouldCheckMethodSendingReportedSelector [

	self assert: (self subjectUnderTest new shouldCheckMethod: (self compile: 'foo ^ self currentWorld' in: presenterTest))
]

{ #category : 'tests - reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testShouldCheckMethodSendingReportedSelectorInCleanBlock [

	self assert:
		(self subjectUnderTest new shouldCheckMethod: (self compile: 'foo ^ #( 1 ) collect: [ :each | each widget ]' in: presenterTest))
]

{ #category : 'tests - not reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testShouldNotCheckMethodNotSendingReportedSelector [

	self deny: (self subjectUnderTest new shouldCheckMethod: (self compile: 'foo ^ self newPresenter adapter' in: presenterTest))
]

{ #category : 'tests - not reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testShouldNotCheckMethodOfBackendTest [

	self deny: (self subjectUnderTest new shouldCheckMethod: (self compile: 'foo ^ self currentWorld' in: backendTest))
]

{ #category : 'tests - reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testSubclassOfPresenterTestIsReported [

	| subclass |
	subclass := self newFixtureNamed: #RePresenterSubtestFixture superclass: presenterTest package: 'Kernel-Fixture-Tests'.
	self assert: (self critiquesOn: 'foo ^ self currentWorld' in: subclass) size equals: 1
]

{ #category : 'tests - reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testSubmorphsSendIsReported [

	self assert: (self critiquesOn: 'foo ^ self newPresenter submorphs' in: presenterTest) size equals: 1
]

{ #category : 'tests - not reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testTestNotReferencingPresentersIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ self currentWorld' in: plainTest)
]

{ #category : 'tests - reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testUIManagerReferenceIsReported [

	self assert: (self critiquesOn: 'foo ^ UIManager' in: presenterTest) size equals: 1
]

{ #category : 'tests - reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testWidgetSendIsReported [

	self assert: (self critiquesOn: 'foo ^ self newPresenter adapter widget' in: presenterTest) size equals: 1
]

{ #category : 'tests - reported' }
RePresenterTestShouldBeBackendAgnosticRuleTest >> testWorldReferenceIsReported [

	self assert: (self critiquesOn: 'foo ^ World' in: presenterTest) size equals: 1
]
