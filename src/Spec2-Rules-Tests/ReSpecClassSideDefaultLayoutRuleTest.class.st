"
I test `ReSpecClassSideDefaultLayoutRule`, the rule asking composite presenters to define `#defaultLayout` on the instance side.

## Responsibility:

- Check that a class-side `#defaultLayout` of a composite presenter is reported.
- Check that instance-side layouts, other class-side selectors, widget presenters and non-presenter classes are not reported.
- Check that the backward-compatible `SpAbstractWidgetPresenter class >> #defaultLayout` of the image is not reported.

## Collaborators: 

- `ReAbstractRuleTestCase`: derives the rule from my name, compiles methods with `generateMethod:classified:in:` and removes them in `tearDown`.
- Anonymous subclasses of `SpPresenter`, `SpAbstractWidgetPresenter` and `Object`, created in `setUp`, so that no presenter violating the rule stays in the image.

## Public API and Key Messages

- One test per case, for example `testClassSideDefaultLayoutInCompositePresenterIsReported`.

```
ReSpecClassSideDefaultLayoutRuleTest run: #testClassSideDefaultLayoutInCompositePresenterIsReported
```

## Internal Representation

- `compositePresenter`: an anonymous subclass of `SpPresenter`.
- `widgetPresenter`: an anonymous subclass of `SpAbstractWidgetPresenter`.
- `plainClass`: an anonymous subclass of `Object`.
"
Class {
	#name : 'ReSpecClassSideDefaultLayoutRuleTest',
	#superclass : 'ReAbstractRuleTestCase',
	#instVars : [
		'compositePresenter',
		'widgetPresenter',
		'plainClass'
	],
	#category : 'Spec2-Rules-Tests',
	#package : 'Spec2-Rules-Tests'
}

{ #category : 'helpers' }
ReSpecClassSideDefaultLayoutRuleTest >> critiquesOnLayoutMethod: aSource in: aBehavior [
	"Compile aSource in aBehavior (removed in tearDown) and answer the critiques of my rule on it."

	^ self myCritiquesOnMethod: (self generateMethod: aSource classified: #specs in: aBehavior)
]

{ #category : 'running' }
ReSpecClassSideDefaultLayoutRuleTest >> setUp [

	super setUp.
	compositePresenter := SpPresenter newAnonymousSubclass.
	widgetPresenter := SpAbstractWidgetPresenter newAnonymousSubclass.
	plainClass := Object newAnonymousSubclass
]

{ #category : 'tests' }
ReSpecClassSideDefaultLayoutRuleTest >> testBackwardCompatibleWidgetDefaultLayoutIsNotReported [

	self assertEmpty: (self myCritiquesOnMethod: SpAbstractWidgetPresenter class >> #defaultLayout)
]

{ #category : 'tests' }
ReSpecClassSideDefaultLayoutRuleTest >> testClassSideDefaultLayoutInCompositePresenterIsReported [

	self
		assert: (self critiquesOnLayoutMethod: 'defaultLayout ^ SpBoxLayout newTopToBottom' in: compositePresenter class) size
		equals: 1
]

{ #category : 'tests' }
ReSpecClassSideDefaultLayoutRuleTest >> testClassSideDefaultLayoutInWidgetPresenterIsNotReported [

	self assertEmpty: (self critiquesOnLayoutMethod: 'defaultLayout ^ SpBoxLayout newTopToBottom' in: widgetPresenter class)
]

{ #category : 'tests' }
ReSpecClassSideDefaultLayoutRuleTest >> testClassSideDefaultLayoutOutsidePresentersIsNotReported [

	self assertEmpty: (self critiquesOnLayoutMethod: 'defaultLayout ^ SpBoxLayout newTopToBottom' in: plainClass class)
]

{ #category : 'tests' }
ReSpecClassSideDefaultLayoutRuleTest >> testClassSideDefaultLayoutOutsideSpPresenterIsNotReported [

	self assertEmpty:
		(self critiquesOnLayoutMethod: 'defaultLayout ^ SpBoxLayout newTopToBottom' in: SpAbstractPresenter newAnonymousSubclass class)
]

{ #category : 'tests' }
ReSpecClassSideDefaultLayoutRuleTest >> testInstanceSideDefaultLayoutIsNotReported [

	self assertEmpty: (self critiquesOnLayoutMethod: 'defaultLayout ^ SpBoxLayout newTopToBottom' in: compositePresenter)
]

{ #category : 'tests' }
ReSpecClassSideDefaultLayoutRuleTest >> testOtherClassSideLayoutMethodIsNotReported [

	self assertEmpty:
		(self critiquesOnLayoutMethod: 'layoutWithOrdering: aBoolean ^ SpBoxLayout newTopToBottom' in: compositePresenter class)
]
