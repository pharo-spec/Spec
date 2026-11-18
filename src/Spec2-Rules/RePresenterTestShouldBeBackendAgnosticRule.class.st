"
I report a test of presenters that reaches the backend: it sends `widget`, `allMorphs`, `submorphs` or `currentWorld`, or references the `World` or `UIManager` global. Tests of presenters must stay backend agnostic, so that they run with every backend (Morphic, Toplo) and in CI.

For example, this method of a presenter test is reported:

```
SpButtonPresenterTest >> morph

	^ presenter adapter widget
```

The fix is to test at the presenter level: the presenter state and API, the presenters of a layout (`layout presenters`), the layout identity, or user actions simulated through presenters (`aButton click`, `aLink performAction`) or through the adapter (`presenter adapter keyDown: $a shift: false meta: false control: false option: false`). To wait for the UI, use `SpMorphicBackendForTest new waitUntilUIRedrawed`. When a behavior can only be observed through the widget, a presenter or adapter API is missing. I offer no automatic transformation.

## Life cycle: who creates me and who uses me

1. Renraku finds me among the rules (`ReRuleManager visibleRuleClasses`) and creates me when the Critic Browser, Calypso or `ReSmalllintChecker` checks code; my group is 'Spec'.
2. Renraku sends me `shouldCheckMethod:` for each method, then `check:forCritiquesDo:` (inherited from `ReNodeBasedRule`) for each node; I answer through `basicCheck:` and Renraku anchors a critique on the reported node.

## Responsibility:

- Check the methods (both sides) of the presenter tests: subclasses of `TestCase` that, themselves or through a superclass below `TestCase`, reference a presenter class (a class including `SpAbstractPresenter`) in one of their methods.
- Leave out the backend and adapter test packages (`isBackendTestPackageName:`), whose tests check widgets: the backend-specific packages of `RePresenterShouldNotViolateLayerRule` (a `Morphic` part, or starting with `Morphic`, `Toplo` or `Bloc`) and those having `Backend` or `Adapters` as a dash-separated part, such as `Spec2-Backend-Tests`.
- Report each node sending a selector of `reportedSelectors` or referencing a global of `reportedGlobalNames`.

## Collaborators: 

- `ReNodeBasedRule`: my superclass; Renraku calls `shouldCheckMethod:` then `basicCheck:` on each node.
- `RePresenterShouldNotViolateLayerRule`: checks the presenters themselves; I reuse its backend package names (`isBackendPackageName:`).
- `SpAbstractPresenter` and `TestCase`: tell which classes are presenter tests.

## Public API and Key Messages

- `shouldCheckMethod:` answers whether a method may be reported: it holds a reported selector or global (inner blocks included) and belongs to my scope; `basicCheck:` answers whether a node is reported (it also checks the scope, since some callers do not use `shouldCheckMethod:`).
- `reportedSelectors` and `reportedGlobalNames` (class side) list what I report.
- `isBackendTestPackageName:` (class side) tells whether a package holds backend or adapter tests.
- `ruleName`, `rationale` and `group` ('Spec') describe me in the Critic Browser.

## Examples

Run me on the package `Spec2-Tests` and inspect the critiques:

```
RePresenterTestShouldBeBackendAgnosticRule scriptCritiquesOfSpec2Tests
```

### Implementation Points

- A presenter class referenced only at run time (`self classToTest new`, answered by a method returning the class) is found, since the method returning it references it.
- The literals are read with `literalsEvenTheOnesInTheInnerBlocks`: `allLiterals` misses those of clean blocks such as `[ :each | each widget ]`.
- `World` and `UIManager` are recognized by name, so the rule needs no backend loaded.
"
Class {
	#name : 'RePresenterTestShouldBeBackendAgnosticRule',
	#superclass : 'ReNodeBasedRule',
	#category : 'Spec2-Rules-Rules',
	#package : 'Spec2-Rules',
	#tag : 'Rules'
}

{ #category : 'accessing' }
RePresenterTestShouldBeBackendAgnosticRule class >> groupSelector [

	^ #specGroup
]

{ #category : 'testing' }
RePresenterTestShouldBeBackendAgnosticRule class >> isBackendTestPackageName: aString [
	"Answer whether aString names a package of backend or adapter tests, whose tests check widgets: a backend-specific package (see RePresenterShouldNotViolateLayerRule) or one having Backend or Adapters as a dash-separated part."

	^ (RePresenterShouldNotViolateLayerRule isBackendPackageName: aString) or: [
		  (aString substrings: '-') includesAny: #( 'Backend' 'Adapters' ) ]
]

{ #category : 'accessing' }
RePresenterTestShouldBeBackendAgnosticRule class >> rationale [

	^ 'Tests of presenters must be backend agnostic: test the presenter state and API, the presenters of a layout, or simulate user actions through presenters (click, performAction) or the adapter. Sending #widget, #allMorphs, #submorphs or #currentWorld, or referencing World or UIManager, ties the test to one backend and to the Morphic UI loop; to wait for the UI, use SpMorphicBackendForTest new waitUntilUIRedrawed. Tests in backend and adapter packages (a Backend, Adapters or Morphic part, or starting with Morphic, Toplo or Bloc) are not checked, since they test the widgets.'
]

{ #category : 'accessing' }
RePresenterTestShouldBeBackendAgnosticRule class >> reportedGlobalNames [
	"Globals of the Morphic world or of the old UI manager."

	^ #( #World #UIManager )
]

{ #category : 'accessing' }
RePresenterTestShouldBeBackendAgnosticRule class >> reportedSelectors [
	"Messages that reach a backend widget or the Morphic world."

	^ #( #widget #allMorphs #submorphs #currentWorld )
]

{ #category : 'accessing' }
RePresenterTestShouldBeBackendAgnosticRule class >> ruleName [

	^ 'Presenter tests should not reach the backend widgets or the world'
]

{ #category : 'script' }
RePresenterTestShouldBeBackendAgnosticRule class >> scriptCritiquesOfSpec2Tests [
	"Run the rule on the package Spec2-Tests and answer its critiques: the presenter tests that send #widget, #currentWorld, ... or reference World or UIManager."

	<example>
	| rule checker |
	rule := self new.
	checker := ReSmalllintChecker new
		           rule: { rule };
		           environment: (PackageOrganizer default packageNamed: 'Spec2-Tests') asEnvironment;
		           yourself.
	checker run.
	^ (checker criticsOf: rule) inspect
]

{ #category : 'running' }
RePresenterTestShouldBeBackendAgnosticRule >> basicCheck: aNode [
	"Answer whether aNode, in a presenter test of my scope, reaches a backend widget or the Morphic world."

	(self isBackendReach: aNode) ifFalse: [ ^ false ].
	^ aNode methodNode methodClass ifNil: [ false ] ifNotNil: [ :class | self isInScope: class ]
]

{ #category : 'private' }
RePresenterTestShouldBeBackendAgnosticRule >> isBackendReach: aNode [
	"Answer whether aNode sends one of my reported selectors or references one of my reported globals."

	aNode isMessage ifTrue: [ ^ self class reportedSelectors includes: aNode selector ].
	^ aNode isVariable and: [ aNode isGlobalVariable and: [ self class reportedGlobalNames includes: aNode name asSymbol ] ]
]

{ #category : 'private' }
RePresenterTestShouldBeBackendAgnosticRule >> isInScope: aBehavior [
	"Answer whether methods of aBehavior (either side) are checked: tests of presenters outside backend and adapter test packages."

	| class |
	class := aBehavior instanceSide.
	(class includesBehavior: TestCase) ifFalse: [ ^ false ].
	(class package isNil or: [ self class isBackendTestPackageName: class package name ]) ifTrue: [ ^ false ].
	^ self testsPresenters: class
]

{ #category : 'private' }
RePresenterTestShouldBeBackendAgnosticRule >> isPresenterClass: anObject [

	^ anObject isClass and: [ anObject includesBehavior: SpAbstractPresenter ]
]

{ #category : 'private' }
RePresenterTestShouldBeBackendAgnosticRule >> mayReachBackend: aMethod [
	"Answer whether the literals of aMethod, inner blocks included, hold a reported selector or a reported global, a quick filter before parsing it."

	^ aMethod literalsEvenTheOnesInTheInnerBlocks anySatisfy: [ :each |
			  (self class reportedSelectors includes: each) or: [
				  each isVariableBinding and: [ self class reportedGlobalNames includes: each key ] ] ]
]

{ #category : 'private' }
RePresenterTestShouldBeBackendAgnosticRule >> referencesPresenter: aMethod [

	^ aMethod literalsEvenTheOnesInTheInnerBlocks anySatisfy: [ :each |
		  each isVariableBinding and: [ self isPresenterClass: each value ] ]
]

{ #category : 'testing' }
RePresenterTestShouldBeBackendAgnosticRule >> shouldCheckMethod: aMethod [

	^ (self mayReachBackend: aMethod) and: [ self isInScope: aMethod methodClass ]
]

{ #category : 'private' }
RePresenterTestShouldBeBackendAgnosticRule >> testsPresenters: aTestClass [
	"Answer whether aTestClass, or one of its superclasses below TestCase, references a presenter class in one of its methods."

	^ (aTestClass withAllSuperclasses copyUpTo: TestCase) anySatisfy: [ :each |
			  (each methods anySatisfy: [ :method | self referencesPresenter: method ]) or: [
				  each class methods anySatisfy: [ :method | self referencesPresenter: method ] ] ]
]
