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

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testEachOffendingNodeIsReported [

	self assert: (self critiquesOn: 'foo ^ SpButtonPresenter new -> (SpLabelPresenter on: 42)' in: presenter) size equals: 2
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testInstantiateIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ self instantiate: SpButtonPresenter' in: presenter)
]

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testInstantiateOnIsNotReported [

	self assertEmpty: (self critiquesOn: 'foo ^ self instantiate: SpLabelPresenter on: 42' in: presenter)
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

{ #category : 'tests' }
RePresenterShouldBeInstantiatedWithOwnerRuleTest >> testWidgetPresenterIsReported [

	self assert: (self critiquesOn: 'foo ^ SpButtonPresenter new' in: widgetPresenter) size equals: 1
]
