"
I report a presenter created with `new` or `on:` from another presenter. Such a presenter has no owner: it silently uses `SpApplication defaultApplication` instead of the application of its owner, and can lose the styles, the backend and the configuration of that application.

For example, these methods of a presenter are reported:

```
MyPresenter >> initializePresenters

	list := SpListPresenter new

MyPresenter >> openPlayground

	StPlaygroundPresenter new open
```

The fix is to create a subpresenter through its owner, and a new window or dialog through the application:

```
MyPresenter >> initializePresenters

	list := self instantiate: SpListPresenter    ""or self newList""

MyPresenter >> openPlayground

	(self application instantiate: StPlaygroundPresenter) open
```

`X on: aModel` becomes `self instantiate: X on: aModel` (or `self application instantiate: X on: aModel`).

## Responsibility:

- Check the nodes of the instance-side methods of classes in the `SpPresenter` hierarchy, widgets included, whatever their package.
- Report each `new` or `on:` message whose receiver is a global, class or pool variable bound to a presenter class (a class including `SpAbstractPresenter`), such as `SpListPresenter new` or `DetailPresenterClass new`.
- Explain the fix; I offer no automatic transformation, because a subpresenter and a window need different fixes.

## Collaborators: 

- `ReNodeBasedRule`: Renraku calls `shouldCheckMethod:` before parsing a method, then `basicCheck:` on each node, and highlights the reported node.
- `SpPresenter>>#instantiate:` and `SpApplication>>#instantiate:`: the correct ways I recommend.

## Public API and Key Messages

- `shouldCheckMethod:` answers whether a method belongs to my scope; `basicCheck:` answers whether a node creates a presenter without owner (it also checks the scope, since some callers do not use `shouldCheckMethod:`).
- `ruleName`, `rationale`, `group` ('Spec') and `severity` ('warning') describe me in the Critic Browser.

Run me on a package:

```
| rule checker |
rule := RePresenterShouldBeInstantiatedWithOwnerRule new.
checker := ReSmalllintChecker new
	rule: { rule };
	environment: (PackageOrganizer default packageNamed: 'Spec2-Examples') asEnvironment;
	yourself.
checker run.
checker criticsOf: rule
```

### Implementation Points

- The class side is not checked: `XPresenter new open` in an `example…` method is the normal way to start a presenter.
- `owner:`, `owner:on:`, `newApplication:` and `newApplication:model:` are not reported; nor are classes known only at run time (`self class new`, `aClass new`). A class or pool variable is checked with its value at analysis time.

"
Class {
	#name : 'RePresenterShouldBeInstantiatedWithOwnerRule',
	#superclass : 'ReNodeBasedRule',
	#category : 'Spec2-Rules',
	#package : 'Spec2-Rules'
}

{ #category : 'accessing' }
RePresenterShouldBeInstantiatedWithOwnerRule class >> groupSelector [

	^ #specGroup
]

{ #category : 'accessing' }
RePresenterShouldBeInstantiatedWithOwnerRule class >> rationale [

	^ 'A presenter created with #new or #on: from another presenter has no owner and silently uses SpApplication defaultApplication instead of the application of its owner, so it can lose its styles, backend and configuration. Use self instantiate: (or instantiate:on:, or a newXxx factory) for a subpresenter, and self application instantiate: (or instantiate:on:) for a new window or dialog.'
]

{ #category : 'accessing' }
RePresenterShouldBeInstantiatedWithOwnerRule class >> ruleName [

	^ 'Instantiate presenters through their owner or application using instantiate:, not with new or on:'
]

{ #category : 'running' }
RePresenterShouldBeInstantiatedWithOwnerRule >> basicCheck: aNode [
	"Answer whether aNode, in a presenter method of my scope, creates a presenter without owner."

	(self isOrphanPresenterCreation: aNode) ifFalse: [ ^ false ].
	^ aNode methodNode methodClass ifNil: [ false ] ifNotNil: [ :class | self isInScope: class ]
]

{ #category : 'private' }
RePresenterShouldBeInstantiatedWithOwnerRule >> isInScope: aBehavior [
	"Answer whether methods of aBehavior are checked: the instance side of presenters."

	^ aBehavior isMeta not and: [ aBehavior includesBehavior: SpPresenter ]
]

{ #category : 'private' }
RePresenterShouldBeInstantiatedWithOwnerRule >> isOrphanPresenterCreation: aNode [
	"Answer whether aNode sends #new or #on: to a presenter class named directly (a global, class or pool variable)."

	| receiver |
	aNode isMessage ifFalse: [ ^ false ].
	(#( #new #on: ) includes: aNode selector) ifFalse: [ ^ false ].
	receiver := aNode receiver.
	(receiver isVariable and: [ receiver variable isLiteralVariable ]) ifFalse: [ ^ false ].
	^ self isPresenterClass: receiver variable value
]

{ #category : 'private' }
RePresenterShouldBeInstantiatedWithOwnerRule >> isPresenterClass: anObject [

	^ anObject isClass and: [ anObject includesBehavior: SpAbstractPresenter ]
]

{ #category : 'testing' }
RePresenterShouldBeInstantiatedWithOwnerRule >> shouldCheckMethod: aMethod [

	^ self isInScope: aMethod methodClass
]
