"
I test `RePresenterShouldNotViolateLayerRule`, the rule reporting presenters that reference the backend (Morphic, Toplo, Bloc) instead of going through Spec.

## Responsibility:

- Check that each kind of backend reference is reported: a backend class, the `World` global, `currentWorld` and `scaledByDisplayScaleFactor` sends, on both sides and in widgets, one critique per node.
- Check what is not reported: Spec presenter classes living in backend packages, neutral classes, adapters, and presenters of backend-specific packages.
- Check the package name convention (`isBackendPackageName:`) and the method filter (`shouldCheckMethod:`).

## Collaborators: 

- `ReAbstractRuleTestCase`: derives the rule from my name, runs it on every node of a method (`myCritiquesOnMethod:`, which does not call `shouldCheckMethod:`) and removes the compiled methods in `tearDown`.
- Anonymous subclasses of `SpPresenter`, `SpAbstractWidgetPresenter` and `SpAbstractAdapter`, created in `setUp`, so that no violating fixture stays in the image.

## Public API and Key Messages

- One test per case, for example `testBackendClassReferenceIsReported`.

```
RePresenterShouldNotViolateLayerRuleTest run: #testBackendClassReferenceIsReported
```

## Internal Representation

- `presenter`: an anonymous subclass of `SpPresenter`.
- `widgetPresenter`: an anonymous subclass of `SpAbstractWidgetPresenter`.
- `adapter`: an anonymous subclass of `SpAbstractAdapter`.
"
Class {
	#name : 'RePresenterShouldNotViolateLayerRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#instVars : [
		'presenter',
		'widgetPresenter',
		'adapter'
	],
	#category : 'Spec2-Rules-Tests',
	#package : 'Spec2-Rules-Tests'
}

{ #category : 'helpers' }
RePresenterShouldNotViolateLayerRuleTest >> critiquesOn: aSource in: aBehavior [
	"Compile aSource in aBehavior (removed in tearDown) and answer the critiques of my rule on it."

	^ self myCritiquesOnMethod: (self generateMethod: aSource classified: #tests in: aBehavior)
]

{ #category : 'running' }
RePresenterShouldNotViolateLayerRuleTest >> setUp [

	super setUp.
	presenter := SpPresenter newAnonymousSubclass.
	widgetPresenter := SpAbstractWidgetPresenter newAnonymousSubclass.
	adapter := SpAbstractAdapter newAnonymousSubclass
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testAdapterIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ Morph new extent: self currentWorld extent' in: adapter)
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testBackendClassReferenceIsReported [

	self assert: (self critiquesOn: 'foo ^ Morph new' in: presenter) size equals: 1
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testBackendPackageNamesAreRecognized [

	#( 'Spec2-Morphic' 'Spec2-Morphic-Examples' 'Morphic-Core' 'Toplo-Demo' 'Bloc-Spec2' ) do: [ :each |
		self assert: (self subjectUnderTest isBackendPackageName: each) ]
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testClassSideMethodOfPresenterIsReported [

	self assert: (self critiquesOn: 'foo ^ Morph new' in: presenter class) size equals: 1
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testCurrentWorldSendIsReported [

	self assert: (self critiquesOn: 'foo ^ self currentWorld' in: presenter) size equals: 1
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testEachOffendingNodeIsReported [

	self assert: (self critiquesOn: 'foo ^ Morph new extent: self currentWorld extent' in: presenter) size equals: 2
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testMethodInBackendPackageIsNotReported [

	self assertEmpty: (self myCritiquesOnMethod: SpDatePresenter >> #chooseDate)
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

	self assertEmpty: (self critiquesOn: 'foo ^ self instantiate: SpBlSpaceInMorphPresenter' in: presenter)
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testWidgetPresenterIsReported [

	self assert: (self critiquesOn: 'foo ^ Morph new' in: widgetPresenter) size equals: 1
]

{ #category : 'tests' }
RePresenterShouldNotViolateLayerRuleTest >> testWorldGlobalIsReported [

	self assert: (self critiquesOn: 'foo ^ World' in: presenter) size equals: 1
]
