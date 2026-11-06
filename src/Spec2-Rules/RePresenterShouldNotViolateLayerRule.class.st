"
I report a Spec presenter that reaches the backend directly. Presenters describe the interface and must stay backend-neutral; only adapters may use Morphic, Toplo or Bloc.

For example, this method of a presenter is reported, on `WorldMorph`:

```
StWelcomeSetupPresenter >> toggleFullScreen: aBoolean

	WorldMorph fullscreen: aBoolean
```

The fix is to go through Spec (the application, the window presenter, a presenter API) or to move the backend code into an adapter, so that the presenter works on every backend.

## Responsibility:

- Check the nodes of methods (both sides) of classes in the `SpPresenter` hierarchy, widgets included, and report each node that references the backend: a class defined in a package whose name starts with `Morphic`, `Toplo` or `Bloc` (unless it is itself a Spec presenter), the `World` global, and the sends of `#currentWorld` and `#scaledByDisplayScaleFactor`, which are defined only by Morphic.
- Leave out presenters living in backend-specific packages (`isBackendPackageName:`): a name starting with `Morphic`, `Toplo` or `Bloc`, or having `Morphic` as one of its dash-separated parts, such as `Spec2-Morphic` or `Spec2-Morphic-Examples`.
- Explain the fix; I offer no automatic transformation.

## Collaborators: 

- `ReNodeBasedRule`: Renraku calls `shouldCheckMethod:` before parsing a method, then `basicCheck:` on each node, and highlights the reported node.
- `SpPresenter` and `SpAbstractPresenter`: the hierarchy checked, and the classes that are never reported as backend classes.

## Public API and Key Messages

- `shouldCheckMethod:` answers whether a method belongs to my scope; `basicCheck:` answers whether a node references the backend (it also checks the scope, since some callers do not use `shouldCheckMethod:`).
- `isBackendPackageName:` (class side) tells whether a package name marks a backend.
- `ruleName`, `rationale`, `group` ('Spec') and `severity` ('warning') describe me in the Critic Browser.

```
RePresenterShouldNotViolateLayerRule isBackendPackageName: 'Spec2-Morphic-Examples'.
	""true""
```

### Implementation Points

- No presenter names `World` directly: they send `currentWorld` (`Object>>#currentWorld`, from `Morphic-Core`). `scaledByDisplayScaleFactor` also ends in `self currentWorld`; Spec has no backend-neutral display scale factor yet.
- `withAdapterDo:` is the official way for a presenter to talk to its adapter and is not reported.
"
Class {
	#name : 'RePresenterShouldNotViolateLayerRule',
	#superclass : 'ReNodeBasedRule',
	#category : 'Spec2-Rules',
	#package : 'Spec2-Rules'
}

{ #category : 'accessing' }
RePresenterShouldNotViolateLayerRule class >> backendPackagePrefixes [
	"Prefixes of the names of the packages defining a backend."

	^ #( 'Morphic' 'Toplo' 'Bloc' )
]

{ #category : 'accessing' }
RePresenterShouldNotViolateLayerRule class >> groupSelector [

	^ #specGroup
]

{ #category : 'testing' }
RePresenterShouldNotViolateLayerRule class >> isBackendDefinitionPackageName: aString [
	"Answer whether aString names a package defining a backend (Morphic-Core, Toplo-Core, Bloc-Layout)."

	^ self backendPackagePrefixes anySatisfy: [ :prefix | aString beginsWith: prefix ]
]

{ #category : 'testing' }
RePresenterShouldNotViolateLayerRule class >> isBackendPackageName: aString [
	"Answer whether aString names a backend-specific package: one defining a backend, or one having Morphic as a dash-separated part (Spec2-Morphic, Spec2-Morphic-Examples)."

	^ (self isBackendDefinitionPackageName: aString) or: [ (aString substrings: '-') includes: 'Morphic' ]
]

{ #category : 'accessing' }
RePresenterShouldNotViolateLayerRule class >> rationale [

	^ 'Spec presenters must stay backend-neutral: only adapters may use Morphic, Toplo or Bloc. Referencing a backend class, the World, #currentWorld or #scaledByDisplayScaleFactor ties the presenter to one backend. Packages whose name marks a backend (starting with Morphic, Toplo or Bloc, or with a Morphic part such as Spec2-Morphic) are not checked.'
]

{ #category : 'accessing' }
RePresenterShouldNotViolateLayerRule class >> ruleName [

	^ 'Presenters should not reference the backend; only adapters may'
]

{ #category : 'running' }
RePresenterShouldNotViolateLayerRule >> basicCheck: aNode [
	"Answer whether aNode, in a presenter method of my scope, references the backend."

	(self isBackendReference: aNode) ifFalse: [ ^ false ].
	^ aNode methodNode methodClass ifNil: [ false ] ifNotNil: [ :class | self isInScope: class ]
]

{ #category : 'private' }
RePresenterShouldNotViolateLayerRule >> isBackendClass: anObject [
	"Answer whether anObject is a class defined by a backend package, Spec presenters excepted."

	anObject isClass ifFalse: [ ^ false ].
	(anObject includesBehavior: SpAbstractPresenter) ifTrue: [ ^ false ].
	^ self class isBackendDefinitionPackageName: anObject package name
]

{ #category : 'private' }
RePresenterShouldNotViolateLayerRule >> isBackendReference: aNode [
	"Answer whether aNode reaches the backend: a backend class, the World global, or a Morphic-only message."

	aNode isMessage ifTrue: [ ^ #( #currentWorld #scaledByDisplayScaleFactor ) includes: aNode selector ].
	(aNode isVariable and: [ aNode isGlobalVariable ]) ifFalse: [ ^ false ].
	aNode name asSymbol = #World ifTrue: [ ^ true ].
	^ self isBackendClass: aNode variable value
]

{ #category : 'private' }
RePresenterShouldNotViolateLayerRule >> isInScope: aBehavior [
	"Answer whether methods of aBehavior (either side) are checked: presenters outside backend-specific packages."

	| class |
	class := aBehavior instanceSide.
	^ (class includesBehavior: SpPresenter) and: [ (self class isBackendPackageName: class package name) not ]
]

{ #category : 'running' }
RePresenterShouldNotViolateLayerRule >> shouldCheckMethod: aMethod [

	^ self isInScope: aMethod methodClass
]
