"
I test `RePresenterShouldNotViolateLayerRule`, the rule reporting presenters that reference the backend (Morphic, Toplo, Bloc) instead of going through Spec.

## Responsibility:

- Check that each kind of backend reference is reported: a backend class, `currentWorld` and `scaledByDisplayScaleFactor` sends, on both sides and in widgets, one critique per node.
- Check what is not reported: Spec presenter classes living in backend packages, neutral classes, adapters, and presenters of backend-specific packages.
- Check the package name convention (`isBackendPackageName:`) and the method filter (`shouldCheckMethod:`).

## Collaborators: 

- `ReAbstractRuleTestCase`: derives the rule from my name, runs it on every node of a method (`myCritiquesOnMethod:`, which does not call `shouldCheckMethod:`) and removes the compiled methods in `tearDown`.
- Anonymous subclasses of `SpPresenter`, `SpAbstractWidgetPresenter` and `SpAbstractAdapter`, created in `setUp`, so that no violating fixture stays in the image.
- Two fixture classes, `ReLayerRuleBackendFixture` and `ReLayerRuleBackendPresenterFixture` (an `SpPresenter`), created in `setUp` in the package `Morphic-Spec2-Rules-Tests-Fixture` and removed in `tearDown`. Their package name marks a backend, so they play the backend class and the backend presenter without loading Morphic, Toplo or Bloc: Spec tests must not depend on a backend. The backend globals are tested without Morphic: `testWorldIsABackendGlobal` checks that `World` is in `backendGlobalNames`, and `testGlobalNamedAsBackendGlobalIsReported` uses a fixture subclass of the rule listing `SpPresenter`.

## Public API and Key Messages

- One test per case, for example `testBackendClassReferenceIsReported`.

```
RePresenterShouldNotViolateLayerRuleTest run: #testBackendClassReferenceIsReported
```

## Internal Representation

- `presenter`: an anonymous subclass of `SpPresenter`.
- `widgetPresenter`: an anonymous subclass of `SpAbstractWidgetPresenter`.
- `adapter`: an anonymous subclass of `SpAbstractAdapter`.
- `backendClass`, `backendPresenter`: the fixture classes of the backend-named package.
"
Class {
	#name : 'RePresenterShouldNotViolateLayerRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#instVars : [
		'presenter',
		'widgetPresenter',
		'adapter',
		'backendClass',
		'backendPresenter'
	],
	#category : 'Spec2-Rules-Tests',
	#package : 'Spec2-Rules-Tests'
}

{ #category : 'helpers' }
RePresenterShouldNotViolateLayerRuleTest >> critiquesOf: aRuleClass on: aSource in: aBehavior [
	"Compile aSource in aBehavior (removed in tearDown) and answer the critiques of aRuleClass, a node rule, on its nodes."

	| method rule critiques |
	method := self generateMethod: aSource classified: #tests in: aBehavior.
	rule := aRuleClass new.
	critiques := OrderedCollection new.
	method ast nodesDo: [ :node | rule check: node forCritiquesDo: [ :critique | critiques add: critique ] ].
	^ critiques
]

{ #category : 'helpers' }
RePresenterShouldNotViolateLayerRuleTest >> critiquesOn: aSource in: aBehavior [
	"Compile aSource in aBehavior (removed in tearDown) and answer the critiques of my rule on it."

	^ self myCritiquesOnMethod: (self generateMethod: aSource classified: #tests in: aBehavior)
]

{ #category : 'helpers' }
RePresenterShouldNotViolateLayerRuleTest >> fixturePackageName [
	"A package named like a backend, so that its classes play the role of backend classes without loading Morphic, Toplo or Bloc."

	^ 'Morphic-Spec2-Rules-Tests-Fixture'
]

{ #category : 'helpers' }
RePresenterShouldNotViolateLayerRuleTest >> newFixtureClassNamed: aSymbol superclass: aClass [
	"Create a class in the backend-named fixture package; tearDown removes it."

	^ ShiftClassInstaller make: [ :builder |
		builder
			name: aSymbol;
			superclass: aClass;
			package: self fixturePackageName ]
]

{ #category : 'running' }
RePresenterShouldNotViolateLayerRuleTest >> setUp [

	super setUp.
	presenter := SpPresenter newAnonymousSubclass.
	widgetPresenter := SpAbstractWidgetPresenter newAnonymousSubclass.
	adapter := SpAbstractAdapter newAnonymousSubclass.
	backendClass := self newFixtureClassNamed: #ReLayerRuleBackendFixture superclass: Object.
	backendPresenter := self newFixtureClassNamed: #ReLayerRuleBackendPresenterFixture superclass: SpPresenter
]

{ #category : 'running' }
RePresenterShouldNotViolateLayerRuleTest >> tearDown [

	{ backendPresenter. backendClass } do: [ :each | each ifNotNil: [ each removeFromSystem ] ].
	(self packageOrganizer packageNamed: self fixturePackageName ifAbsent: [ nil ])
		ifNotNil: [ :package | package removeFromSystem ].
	super tearDown
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testAdapterIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ ReLayerRuleBackendFixture new -> self currentWorld' in: adapter)
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testBackendClassReferenceIsReported [

	self assert: (self critiquesOn: 'foo ^ ReLayerRuleBackendFixture new' in: presenter) size equals: 1
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testBackendPackageNamesAreRecognized [

	#( 'Spec2-Morphic' 'Spec2-Morphic-Examples' 'Morphic-Core' 'Toplo-Demo' 'Bloc-Spec2' ) do: [ :each |
		self assert: (self subjectUnderTest isBackendPackageName: each) ]
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testClassSideMethodOfPresenterIsReported [

	self assert: (self critiquesOn: 'foo ^ ReLayerRuleBackendFixture new' in: presenter class) size equals: 1
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testCurrentWorldSendIsReported [

	self assert: (self critiquesOn: 'foo ^ self currentWorld' in: presenter) size equals: 1
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testEachOffendingNodeIsReported [

	self assert: (self critiquesOn: 'foo ^ ReLayerRuleBackendFixture new -> self currentWorld' in: presenter) size equals: 2
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testGlobalNamedAsBackendGlobalIsReported [
	"SpPresenter plays a backend global for a rule listing it, so the test does not need the World global of Morphic."

	| rule |
	rule := self newFixtureClassNamed: #ReLayerRuleWithFixtureGlobal superclass: RePresenterShouldNotViolateLayerRule.
	[ rule class compile: 'backendGlobalNames
	^ #( #SpPresenter )' classified: #accessing.
	self assert: (self critiquesOf: rule on: 'foo ^ SpPresenter' in: presenter) size equals: 1 ]
		ensure: [ rule removeFromSystem ]
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testGlobalNotNamedAsBackendGlobalIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ SpPresenter' in: presenter)
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testMethodInBackendPackageIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ ReLayerRuleBackendFixture new' in: backendPresenter)
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testNeutralClassReferenceIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ OrderedCollection new' in: presenter)
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testNeutralPackageNamesAreNotRecognized [

	#( 'Spec2-Core' 'NewTools-WelcomeBrowser' 'Spec2-MorphicLike' ) do: [ :each |
		self deny: (self subjectUnderTest isBackendPackageName: each) ]
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testScaledByDisplayScaleFactorSendIsReported [

	self assert: (self critiquesOn: 'foo ^ 30 scaledByDisplayScaleFactor' in: presenter) size equals: 1
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testShouldCheckPresenterMethods [

	self assert: (self subjectUnderTest new shouldCheckMethod: (self generateMethod: 'foo ^ 1' classified: #tests in: presenter))
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testShouldNotCheckAdapterMethods [

	self deny: (self subjectUnderTest new shouldCheckMethod: (self generateMethod: 'foo ^ 1' classified: #tests in: adapter))
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testSpecPresenterFromBackendPackageIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ self instantiate: ReLayerRuleBackendPresenterFixture' in: presenter)
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testWidgetPresenterIsReported [

	self assert: (self critiquesOn: 'foo ^ ReLayerRuleBackendFixture new' in: widgetPresenter) size equals: 1
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testWorldIsABackendGlobal [

	self assert: (RePresenterShouldNotViolateLayerRule backendGlobalNames includes: #World)
]
