"
I test `RePresenterShouldBeInstantiatedWithOwnerRule`, the rule reporting presenters created with `new` or `on:` from another presenter, so without owner and under the default application.

## Responsibility:

- Check that `new` and `on:` sent to a presenter class from the instance side of a presenter (widgets included) are reported, one critique per node visit.
- Check that the correct ways (`instantiate:`, `instantiate:on:`, `self application instantiate:`, `newApplication:`, `owner:`) and the cases outside the scope (class side, non-presenters, non-presenter classes, classes known only at run time) are not reported.
- Check the method filter (`shouldCheckMethod:`).

## Collaborators: 

- `ReAbstractRuleTestCase`: derives the rule from my name, runs it on every node of a method (`myCritiquesOnMethod:`, which does not call `shouldCheckMethod:`) and removes the compiled methods in `tearDown`.
- Anonymous subclasses of `SpPresenter`, `SpAbstractWidgetPresenter` and `Object`, created in `setUp`, so that no violating fixture stays in the image.

## Public API and Key Messages

- One test per case, for example `testNewOfPresenterClassIsReported`.

```
RePresenterShouldBeInstantiatedWithOwnerRuleTest run: #testNewOfPresenterClassIsReported
```

## Internal Representation

- `presenter`: an anonymous subclass of `SpPresenter`.
- `widgetPresenter`: an anonymous subclass of `SpAbstractWidgetPresenter`.
- `nonPresenter`: an anonymous subclass of `Object`.

### Implementation Points

- Renraku visits the receiver of a cascade once per cascade message, so a cascade on `SpLabelPresenter new` is reported twice today (see `testCascadeReceiverIsReportedOncePerCascadeMessage`).

"
Class {
	#name : 'RePresenterShouldBeInstantiatedWithOwnerRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#instVars : [
		'presenter',
		'widgetPresenter',
		'nonPresenter'
	],
	#category : 'Spec2-Rules-Tests',
	#package : 'Spec2-Rules-Tests'
}

{ #category : 'helpers' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> critiquesOn: aSource in: aBehavior [
	"Compile aSource in aBehavior (removed in tearDown) and answer the critiques of my rule on it."

	^ self myCritiquesOnMethod: (self generateMethod: aSource classified: #tests in: aBehavior)
]

{ #category : 'helpers' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> fixedSourceOf: aSource [
	"Compile aSource in the presenter (removed in tearDown) and answer the source of the change proposed by the first critique."

	^ (self critiquesOn: aSource in: presenter) first change source
]

{ #category : 'running' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> setUp [

	super setUp.
	presenter := SpPresenter newAnonymousSubclass.
	widgetPresenter := SpAbstractWidgetPresenter newAnonymousSubclass.
	nonPresenter := Object newAnonymousSubclass
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testApplicationInstantiateIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ self application instantiate: SpButtonPresenter' in: presenter)
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testCascadeReceiverIsReportedOncePerCascadeMessage [
	"Renraku visits the receiver of a cascade once per cascade message, so the node is reported twice today. Change to 1 once Renraku visits each node once."

	self assert: (self critiquesOn: 'foo ^ SpLabelPresenter new label: ''a''; yourself' in: presenter) size equals: 2
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testClassKnownAtRunTimeIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo: aClass ^ self class new -> aClass new' in: presenter)
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testClassSideMethodOfPresenterIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ SpButtonPresenter new' in: presenter class)
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testClassVariableBoundToPresenterClassIsReported [

	presenter addClassVarNamed: #DetailPresenterClass.
	(presenter classVariableNamed: #DetailPresenterClass) write: SpButtonPresenter.
	self assert: (self critiquesOn: 'foo ^ DetailPresenterClass new' in: presenter) size equals: 1
]

{ #category : 'tests - fix' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testCritiqueProvidesChange [

	| critique |
	critique := (self critiquesOn: 'foo ^ SpButtonPresenter new' in: presenter) first.
	self assert: critique class name equals: #ReInstantiatePresenterWithOwnerCritique.
	self assert: critique providesChange
]

{ #category : 'tests - windows' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testDialogOpenedInCascadeIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ SpButtonPresenter new title: ''t''; openModal' in: presenter)
]

{ #category : 'tests - windows' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testDialogOpenedInsideCascadeIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ SpButtonPresenter new openModal; yourself' in: presenter)
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testEachOffendingNodeIsReported [

	self assert: (self critiquesOn: 'foo ^ SpButtonPresenter new -> (SpLabelPresenter on: 42)' in: presenter) size equals: 2
]

{ #category : 'tests - fix' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testFixAddsParenthesesWhenNeeded [

	self
		assert: (self fixedSourceOf: 'foo ^ (SpChooserPresenter new label: 1; yourself) -> (1 -> SpChooserPresenter new) -> (self foo: SpChooserPresenter new)')
		equals: 'foo ^ ((self instantiate: SpChooserPresenter) label: 1; yourself) -> (1 -> (self instantiate: SpChooserPresenter)) -> (self foo: (self instantiate: SpChooserPresenter))'
]

{ #category : 'tests - fix' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testFixKeepsCommentsAndFormatting [

	self
		assert: (self fixedSourceOf: 'foo
	"keep me"
	^   SpButtonPresenter new')
		equals: 'foo
	"keep me"
	^   self newButton'
]

{ #category : 'tests - fix' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testFixLeavesWindowsUntouched [

	self assert: (self fixedSourceOf: 'foo ^ SpButtonPresenter new -> SpLabelPresenter new open') equals: 'foo ^ self newButton -> SpLabelPresenter new open'
]

{ #category : 'tests - fix' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testFixOfCascadeReceiverWithFactory [

	self assert: (self fixedSourceOf: 'foo ^ SpLabelPresenter new label: ''a''; yourself') equals: 'foo ^ self newLabel label: ''a''; yourself'
]

{ #category : 'tests - fix' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testFixOfClassVariableReceiver [

	presenter addClassVarNamed: #DetailPresenterClass.
	(presenter classVariableNamed: #DetailPresenterClass) write: SpButtonPresenter.
	self assert: (self fixedSourceOf: 'foo ^ DetailPresenterClass new') equals: 'foo ^ self instantiate: DetailPresenterClass'
]

{ #category : 'tests - fix' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testFixOfOnUsesInstantiateOn [

	self assert: (self fixedSourceOf: 'foo ^ SpLabelPresenter on: 40 + 2') equals: 'foo ^ self instantiate: SpLabelPresenter on: 40 + 2'
]

{ #category : 'tests - fix' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testFixReplacesOnlyTheOutermostOfNestedCreations [
	"The nested creation is fixed by a second change."

	self assert: (self fixedSourceOf: 'foo ^ SpLabelPresenter on: SpChooserPresenter new') equals: 'foo ^ self instantiate: SpLabelPresenter on: SpChooserPresenter new'
]

{ #category : 'tests - fix' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testFixUsesBackendFactory [

	self assert: (self fixedSourceOf: 'foo ^ SpListPresenter new') equals: 'foo ^ self newList'
]

{ #category : 'tests - fix' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testFixUsesFactory [

	self assert: (self fixedSourceOf: 'foo ^ SpButtonPresenter new') equals: 'foo ^ self newButton'
]

{ #category : 'tests - fix' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testFixUsesMenuFactory [

	self assert: (self fixedSourceOf: 'foo ^ SpMenuPresenter new') equals: 'foo ^ self newMenu'
]

{ #category : 'tests - fix' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testFixWithoutFactoryUsesInstantiate [

	self assert: (self fixedSourceOf: 'foo | a | a := SpChooserPresenter new. ^ a') equals: 'foo | a | a := self instantiate: SpChooserPresenter. ^ a'
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testInstantiateIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ self instantiate: SpButtonPresenter' in: presenter)
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testInstantiateOnIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ self instantiate: SpLabelPresenter on: 42' in: presenter)
]

{ #category : 'tests - windows' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testMenuIsReported [

	self assert: (self critiquesOn: 'foo ^ SpMenuPresenter new' in: presenter) size equals: 1
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testNewApplicationAndOwnerAreNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ (SpButtonPresenter newApplication: self application) -> (SpButtonPresenter owner: self)' in: presenter)
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testNewOfPresenterClassIsReported [

	self assert: (self critiquesOn: 'foo ^ SpButtonPresenter new' in: presenter) size equals: 1
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testNonPresenterClassIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ OrderedCollection new' in: presenter)
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testNonPresenterIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ SpButtonPresenter new' in: nonPresenter)
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testOnOfPresenterClassIsReported [

	self assert: (self critiquesOn: 'foo ^ SpLabelPresenter on: 42' in: presenter) size equals: 1
]

{ #category : 'tests - fix' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testOneChangeFixesAllNodesOfTheMethod [

	| critiques expected |
	critiques := self critiquesOn: 'foo ^ SpButtonPresenter new -> (SpLabelPresenter on: 42)' in: presenter.
	expected := 'foo ^ self newButton -> (self instantiate: SpLabelPresenter on: 42)'.
	self assert: critiques size equals: 2.
	critiques do: [ :each | self assert: each change source equals: expected ]
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testShouldCheckPresenterInstanceMethods [

	self assert: (self subjectUnderTest new shouldCheckMethod: (self generateMethod: 'foo ^ 1' classified: #tests in: presenter))
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testShouldNotCheckNonPresenterMethods [

	self deny: (self subjectUnderTest new shouldCheckMethod: (self generateMethod: 'foo ^ 1' classified: #tests in: nonPresenter))
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testShouldNotCheckPresenterClassSideMethods [

	self deny: (self subjectUnderTest new shouldCheckMethod: (self generateMethod: 'foo ^ 1' classified: #tests in: presenter class))
]

{ #category : 'tests - fix' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testStaleCritiqueDoesNotRevertTheFix [

	| critiques fixed |
	critiques := self critiquesOn: 'foo ^ SpButtonPresenter new -> (SpLabelPresenter on: 42)' in: presenter.
	fixed := critiques first change source.
	presenter compile: fixed classified: #tests.
	self assert: critiques last change source equals: fixed
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testWidgetPresenterIsReported [

	self assert: (self critiquesOn: 'foo ^ SpButtonPresenter new' in: widgetPresenter) size equals: 1
]

{ #category : 'tests - windows' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testWindowOpenedAfterCascadeIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ (SpButtonPresenter new title: ''t''; yourself) asModalWindow' in: presenter)
]

{ #category : 'tests - windows' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testWindowOpenedInChainIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ SpButtonPresenter new open' in: presenter)
]
