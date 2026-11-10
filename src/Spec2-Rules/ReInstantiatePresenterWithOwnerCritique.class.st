"
I am the critique of `RePresenterShouldBeInstantiatedWithOwnerRule`: a presenter created with `new` or `on:` from another presenter, so without owner. I can fix it.

## Responsibility:

- Remember the class and the selector of the criticized method, so that my fix works on the method as it is now, not on the version the rule checked.
- Provide a change (`change`) rewriting every presenter created without owner in that method, not only the node I am about, so that applying a stale critique, or the duplicate critique Renraku creates for a cascade receiver, never reverts an earlier fix.

## Collaborators: 

- `RePresenterShouldBeInstantiatedWithOwnerRule`: creates me (`for:by:`) and computes the fixed source (`fixedSourceOf:`).
- `ReChangeFactory`: builds the `ReAddMethodChange` that Calypso and the Critic Browser preview and apply (""Automatically resolve the issue"").

## Public API and Key Messages

- `ReInstantiatePresenterWithOwnerCritique for: aNode by: aRule` creates me.
- `providesChange` answers true while the method still exists; `change` answers the change; `currentMethod` answers the method as it is now.

```
| method critique |
method := MyPresenter >> #initializePresenters.
critique := (ReCriticEngine nodeCritiquesOf: method) detect: [ :each |
	each rule class == RePresenterShouldBeInstantiatedWithOwnerRule ].
critique change source
```

## Internal Representation

- `methodClass`, `selector`: the class and the selector of the criticized method.

"
Class {
	#name : 'ReInstantiatePresenterWithOwnerCritique',
	#superclass : 'ReAbstractCritique',
	#instVars : [
		'methodClass',
		'selector'
	],
	#category : 'Spec2-Rules',
	#package : 'Spec2-Rules'
}

{ #category : 'instance creation' }
ReInstantiatePresenterWithOwnerCritique class >> for: aNode by: aRule [
	"Answer a critique of aRule about aNode, which remembers the method of aNode so that the fix works on its current version."

	^ (self withAnchor: (aRule anchorFor: aNode) by: aRule)
		methodClass: aNode methodNode methodClass selector: aNode methodNode selector;
		yourself
]

{ #category : 'accessing' }
ReInstantiatePresenterWithOwnerCritique >> change [
	"Answer a change rewriting every presenter created without owner in the current method."

	^ ReChangeFactory instance
		addMethodSource: (self rule fixedSourceOf: self currentMethod)
		in: methodClass
]

{ #category : 'accessing' }
ReInstantiatePresenterWithOwnerCritique >> currentMethod [
	"Answer the method as it is now, which may differ from the one the rule checked."

	^ methodClass ifNotNil: [ methodClass compiledMethodAt: selector ifAbsent: [ nil ] ]
]

{ #category : 'initialization' }
ReInstantiatePresenterWithOwnerCritique >> methodClass: aClass selector: aSymbol [

	methodClass := aClass.
	selector := aSymbol
]

{ #category : 'testing' }
ReInstantiatePresenterWithOwnerCritique >> providesChange [

	^ self currentMethod isNotNil
]
