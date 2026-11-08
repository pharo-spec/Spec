"
I report a presenter created with `new` or `on:` from another presenter, and I can fix it. Such a presenter has no owner: it silently uses `SpApplication defaultApplication` instead of the application of its owner, and can lose the styles, the backend and the configuration of that application.

For example, this method of a presenter is reported twice:

```
MyPresenter >> initializePresenters

	list := SpListPresenter new.
	detail := MyDetailPresenter on: self model
```

My automatic fix (""Automatically resolve the issue"" in Calypso and in the Critic Browser) rewrites it as:

```
MyPresenter >> initializePresenters

	list := self newList.
	detail := self instantiate: MyDetailPresenter on: self model
```

A presenter class having a factory in `SpPresenter` (`factorySelectors`, e.g. `SpMenuPresenter` -> `newMenu`) gets its factory; any other gets `self instantiate:`, and `X on: aModel` gets `self instantiate: X on: aModel`.

## Responsibility:

- Check the nodes of the instance-side methods of classes in the `SpPresenter` hierarchy, widgets included, whatever their package, and report each `new` or `on:` message whose receiver is a global, class or pool variable bound to a presenter class (a class including `SpAbstractPresenter`), such as `SpListPresenter new` or `DetailPresenterClass new`.
- Leave out presenters opened as a window or a dialog (a `windowSelectors` message such as `open` or `openModal` in their message chain or cascade): how they should be created is not decided yet, see https://github.com/pharo-spec/Spec/issues/1967.
- Answer the source of a method where every reported creation goes through its owner (`fixedSourceOf:`), used by my critiques.

## Collaborators: 

- `ReNodeBasedRule`: Renraku calls `shouldCheckMethod:` before parsing a method, then `check:forCritiquesDo:` on each node.
- `ReInstantiatePresenterWithOwnerCritique`: my critique; its change fixes the current version of the whole method.
- `SpPresenter>>#instantiate:`, `instantiate:on:` and the `newXxx` factories: the code my fix writes.

## Public API and Key Messages

- `shouldCheckMethod:` answers whether a method belongs to my scope; `basicCheck:` answers whether a node creates a presenter without owner (it also checks the scope, since some callers do not use `shouldCheckMethod:`).
- `fixedSourceOf: aMethod` answers the fixed source of aMethod.
- `factorySelectors` and `windowSelectors` (class side) hold the presenter classes with a factory and the messages opening a window.
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
- The fix replaces the source text of each node, from the end, so the formatting and the comments of the method are kept; a keyword replacement is parenthesized when it is a receiver or an argument of a binary or keyword message. A creation nested in another reported one is fixed by a second change.
- The factories of lists, tables, trees, drop lists, component lists and diffs ask the backend for their class; `factorySelectors` maps the classes of the Morphic backend.

"
Class {
	#name : 'RePresenterShouldBeInstantiatedWithOwnerRule',
	#superclass : 'ReNodeBasedRule',
	#category : 'Spec2-Rules',
	#package : 'Spec2-Rules'
}

{ #category : 'accessing' }
RePresenterShouldBeInstantiatedWithOwnerRule class >> factorySelectors [
	"Presenter class names and the SpPresenter factory creating such a presenter through its owner. The factories of lists, tables, trees, drop lists, component lists and diffs ask the backend for the class; these are the classes of the Morphic backend."

	^ Dictionary newFrom: {
		#SpActionBarPresenter -> #newActionBar.
		#SpAthensPresenter -> #newAthens.
		#SpButtonBarPresenter -> #newButtonBar.
		#SpButtonPresenter -> #newButton.
		#SpCheckBoxPresenter -> #newCheckBox.
		#SpCodeEditorPresenter -> #newCodeEditor.
		#SpCodePresenter -> #newCode.
		#SpColorPicker -> #newColorPicker.
		#SpColumnViewPresenter -> #newColumnView.
		#SpComponentListPresenter -> #newComponentList.
		#SpDiffPresenter -> #newDiff.
		#SpDropDownPresenter -> #newDropDown.
		#SpDropListPresenter -> #newDropList.
		#SpEasyColumnViewPresenter -> #newEasyColumnView.
		#SpEasyListViewPresenter -> #newEasyListView.
		#SpEasyTreeColumnViewPresenter -> #newEasyTreeColumnView.
		#SpEasyTreeListViewPresenter -> #newEasyTreeListView.
		#SpFilteringListPresenter -> #newFilteringList.
		#SpImagePresenter -> #newImage.
		#SpLabelPresenter -> #newLabel.
		#SpLinkPresenter -> #newLink.
		#SpListPresenter -> #newList.
		#SpListViewPresenter -> #newListView.
		#SpMenuBarPresenter -> #newMenuBar.
		#SpMenuButtonPresenter -> #newMenuButton.
		#SpMenuPresenter -> #newMenu.
		#SpMorphPresenter -> #newMorph.
		#SpNotebookPresenter -> #newNotebook.
		#SpNullPresenter -> #newNullPresenter.
		#SpNumberInputFieldPresenter -> #newNumberInput.
		#SpPopoverPresenter -> #newPopover.
		#SpPresenter -> #newPresenter.
		#SpPresenterSelectorPresenter -> #newPresenterSelector.
		#SpProgressBarPresenter -> #newProgressBar.
		#SpRadioButtonPresenter -> #newRadioButton.
		#SpRoassalPresenter -> #newRoassal.
		#SpSearchInputFieldPresenter -> #newSearchInput.
		#SpSliderPresenter -> #newSlider.
		#SpSpinnerPresenter -> #newSpinner.
		#SpStatusBarPresenter -> #newStatusBar.
		#SpSwitchPresenter -> #newSwitch.
		#SpTablePresenter -> #newTable.
		#SpTextInputFieldPresenter -> #newTextInput.
		#SpTextPresenter -> #newText.
		#SpToggleButtonPresenter -> #newToggleButton.
		#SpToolbarButtonPresenter -> #newToolbarButton.
		#SpToolbarMenuButtonPresenter -> #newToolbarMenuButton.
		#SpToolbarPopoverButtonPresenter -> #newToolbarPopoverButton.
		#SpToolbarPresenter -> #newToolbar.
		#SpToolbarToggleButtonPresenter -> #newToolbarToggleButton.
		#SpTreeColumnViewPresenter -> #newTreeColumnView.
		#SpTreeListViewPresenter -> #newTreeListView.
		#SpTreePresenter -> #newTree.
		#SpTreeTablePresenter -> #newTreeTable }
]

{ #category : 'accessing' }
RePresenterShouldBeInstantiatedWithOwnerRule class >> groupSelector [

	^ #specGroup
]

{ #category : 'accessing' }
RePresenterShouldBeInstantiatedWithOwnerRule class >> rationale [

	^ 'A presenter created with #new or #on: from another presenter has no owner and silently uses SpApplication defaultApplication instead of the application of its owner, so it can lose its styles, backend and configuration. Use a newXxx factory, self instantiate: or self instantiate:on: (the automatic fix does it). Presenters opened as a window or a dialog are not reported yet (https://github.com/pharo-spec/Spec/issues/1967).'
]

{ #category : 'accessing' }
RePresenterShouldBeInstantiatedWithOwnerRule class >> ruleName [

	^ 'Instantiate presenters through their owner or application using instantiate:, not with new or on:'
]

{ #category : 'accessing' }
RePresenterShouldBeInstantiatedWithOwnerRule class >> windowSelectors [
	"Messages opening a presenter as a window or a dialog. Such presenters are not reported until https://github.com/pharo-spec/Spec/issues/1967 is answered."

	^ #( #open #openModal #openDialog #openBlockedDialog #openWithLayout: #openModalWithLayout: #openDialogWithLayout: #openBlockedDialogWithLayout: #asWindow #asModalWindow #asDialogWindow #asBlockedDialogWindow #asWorldWindow )
]

{ #category : 'running' }
RePresenterShouldBeInstantiatedWithOwnerRule >> basicCheck: aNode [
	"Answer whether aNode, in a presenter method of my scope, creates a presenter without owner."

	(self isOrphanPresenterCreation: aNode) ifFalse: [ ^ false ].
	^ aNode methodNode methodClass ifNil: [ false ] ifNotNil: [ :class | self isInScope: class ]
]

{ #category : 'running' }
RePresenterShouldBeInstantiatedWithOwnerRule >> check: aNode forCritiquesDo: aBlock [

	(self basicCheck: aNode) ifTrue: [ aBlock cull: (ReInstantiatePresenterWithOwnerCritique for: aNode by: self) ]
]

{ #category : 'fixing' }
RePresenterShouldBeInstantiatedWithOwnerRule >> fixedSourceOf: aMethod [
	"Answer the source of aMethod where every presenter created without owner is created through its owner. Replacements are done on the source text, from the end, to keep the formatting and the comments."

	| source |
	source := aMethod sourceCode.
	((self outermostOrphanCreationsIn: aMethod ast) asSortedCollection: [ :a :b | a startWithoutParentheses >= b startWithoutParentheses ]) do: [ :each |
		source := source copyReplaceFrom: each startWithoutParentheses to: each stopWithoutParentheses with: (self replacementSourceFor: each) ].
	^ source
]

{ #category : 'private' }
RePresenterShouldBeInstantiatedWithOwnerRule >> isInScope: aBehavior [
	"Answer whether methods of aBehavior are checked: the instance side of presenters."

	^ aBehavior isMeta not and: [ aBehavior includesBehavior: SpPresenter ]
]

{ #category : 'fixing' }
RePresenterShouldBeInstantiatedWithOwnerRule >> isNode: aNode nestedInOneOf: someNodes [
	"Answer whether aNode lies inside the source of another node of someNodes."

	^ someNodes anySatisfy: [ :other |
		other ~~ aNode and: [ aNode start >= other start and: [ aNode stop <= other stop ] ] ]
]

{ #category : 'private' }
RePresenterShouldBeInstantiatedWithOwnerRule >> isOpenedAsWindow: aNode [
	"Answer whether a window selector is sent to the presenter created by aNode, in its message chain or its cascade."

	| current parent |
	current := aNode.
	[ parent := current parent.
	parent isNotNil and: [ parent isMessage and: [ parent receiver == current ] ] ] whileTrue: [
		(self class windowSelectors includes: parent selector) ifTrue: [ ^ true ].
		current := parent.
		(parent parent isNotNil and: [ parent parent isCascade ]) ifTrue: [
			(parent parent messages anySatisfy: [ :each | self class windowSelectors includes: each selector ]) ifTrue: [ ^ true ].
			current := parent parent ] ].
	^ false
]

{ #category : 'private' }
RePresenterShouldBeInstantiatedWithOwnerRule >> isOrphanPresenterCreation: aNode [
	"Answer whether aNode sends #new or #on: to a presenter class named directly (a global, class or pool variable), unless the presenter is opened as a window or a dialog."

	| receiver |
	aNode isMessage ifFalse: [ ^ false ].
	(#( #new #on: ) includes: aNode selector) ifFalse: [ ^ false ].
	receiver := aNode receiver.
	(receiver isVariable and: [ receiver variable isLiteralVariable ]) ifFalse: [ ^ false ].
	^ (self isPresenterClass: receiver variable value) and: [ (self isOpenedAsWindow: aNode) not ]
]

{ #category : 'private' }
RePresenterShouldBeInstantiatedWithOwnerRule >> isPresenterClass: anObject [

	^ anObject isClass and: [ anObject includesBehavior: SpAbstractPresenter ]
]

{ #category : 'fixing' }
RePresenterShouldBeInstantiatedWithOwnerRule >> needsParenthesesAround: aNode [
	"Answer whether a keyword message replacing the unary aNode must be parenthesized: aNode is a receiver, or an argument of a binary or keyword message."

	| parent |
	aNode hasParentheses ifTrue: [ ^ false ].
	parent := aNode parent.
	(parent isNil or: [ parent isMessage not ]) ifTrue: [ ^ false ].
	parent receiver == aNode ifTrue: [ ^ true ].
	^ parent isUnary not and: [ parent arguments includes: aNode ]
]

{ #category : 'fixing' }
RePresenterShouldBeInstantiatedWithOwnerRule >> outermostOrphanCreationsIn: aMethodNode [
	"Answer the reported nodes of aMethodNode, each once, without those nested in another one (a second fix handles them)."

	| nodes |
	nodes := IdentitySet new.
	aMethodNode nodesDo: [ :each | (self basicCheck: each) ifTrue: [ nodes add: each ] ].
	^ nodes asArray reject: [ :each | self isNode: each nestedInOneOf: nodes ]
]

{ #category : 'fixing' }
RePresenterShouldBeInstantiatedWithOwnerRule >> replacementSourceFor: aNode [
	"Answer the source creating the presenter of aNode through its owner: a factory, instantiate: or instantiate:on:."

	| className |
	className := aNode receiver name.
	aNode selector = #on: ifFalse: [
		self class factorySelectors at: className asSymbol ifPresent: [ :factory | ^ 'self ', factory ] ].
	^ String streamContents: [ :stream |
		| parenthesized |
		parenthesized := self needsParenthesesAround: aNode.
		parenthesized ifTrue: [ stream nextPut: $( ].
		stream nextPutAll: 'self instantiate: '; nextPutAll: className.
		aNode selector = #on: ifTrue: [ stream nextPutAll: ' on: '; nextPutAll: aNode arguments first sourceCode ].
		parenthesized ifTrue: [ stream nextPut: $) ] ]
]

{ #category : 'testing' }
RePresenterShouldBeInstantiatedWithOwnerRule >> shouldCheckMethod: aMethod [

	^ self isInScope: aMethod methodClass
]
