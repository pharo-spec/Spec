"
I test that the Morphic layout adapter honours the actions declared on a composite presenter (a presenter whose widget is built by a layout, such as `SpBoxLayout`).

## Responsibility:

- I check that a right click on a composite with menu-visible actions opens a context menu built from them.
- I check that a composite declaring only shortcut actions gets no context menu.
- I check that the shortcut of an action declared on a composite fires when one of its children has the focus.

## Collaborators: 

- `SpMorphicLayoutAdapter`: the adapter under test, it builds the widget of a composite presenter.
- `SpAction`: the actions declared on the composite.
- `MenuMorph`: the context menu opened in the world.

## Public API and Key Messages

- `newCompositeWith:` builds a composite presenter holding a text input, and lets a block declare its actions.
- Run the tests with the test runner, for example:

```
SpMorphicLayoutActionsTest suite run
```

## Internal Representation

- `presenter`: the composite presenter under test.
- `window`: the window opened on it, closed in `tearDown`.
- `fired`: set to true by the action blocks so tests know they ran.
"
Class {
	#name : 'SpMorphicLayoutActionsTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter',
		'window',
		'fired'
	],
	#category : 'Spec2-Morphic-Backend-Tests',
	#package : 'Spec2-Morphic-Backend-Tests'
}

{ #category : 'helpers' }
SpMorphicLayoutActionsTest >> ctrlJEvent [

	^ KMDispatcherTest new
		  eventKey: $j
		  alt: false
		  ctrl: true
		  command: false
		  shift: false
]

{ #category : 'helpers' }
SpMorphicLayoutActionsTest >> menuItemLabelsOf: aMenu [

	^ aMenu items collect: [ :item | item contents asString ]
]

{ #category : 'helpers' }
SpMorphicLayoutActionsTest >> menuOpenedDuring: aBlock [
	"Answer the menu opened while evaluating aBlock, nil if none. Context menus are modal: the capturing morph closes the menu during the world cycle so aBlock returns."

	| jailor |
	jailor := MenuCapturingMorph new openInWorld.
	[ aBlock value ] ensure: [ jailor delete ].
	^ jailor menu
]

{ #category : 'helpers' }
SpMorphicLayoutActionsTest >> newCompositeWith: aBlock [
	"Answer an opened composite presenter holding a text input. aBlock receives the presenter to declare its actions."

	presenter := SpPresenter new.
	presenter layout: (SpBoxLayout newTopToBottom
			 add: presenter newTextInput;
			 yourself).
	aBlock value: presenter.
	window := presenter open.
	^ presenter
]

{ #category : 'helpers' }
SpMorphicLayoutActionsTest >> openedMenus [
	"Answer the menus currently opened in the world"

	^ self currentWorld submorphs select: [ :each | each isKindOf: MenuMorph ]
]

{ #category : 'running' }
SpMorphicLayoutActionsTest >> setUp [

	super setUp.
	fired := false
]

{ #category : 'running' }
SpMorphicLayoutActionsTest >> tearDown [

	self openedMenus do: [ :each | each delete ].
	window ifNotNil: [ window close ].
	super tearDown
]

{ #category : 'tests' }
SpMorphicLayoutActionsTest >> testRightClickOnCompositeWithActionOpensContextMenu [

	| menu |
	self newCompositeWith: [ :composite |
			composite addActionWith: [ :action |
					action
						name: 'Do it';
						action: [ fired := true ] ] ].

	menu := self menuOpenedDuring: [ presenter adapter widget simulateRightMouseDown ].

	self assert: menu isNotNil.
	self assert: (self menuItemLabelsOf: menu) asArray equals: #( 'Do it' )
]

{ #category : 'tests' }
SpMorphicLayoutActionsTest >> testRightClickOnCompositeWithOnlyShortcutsOpensNoMenu [

	self newCompositeWith: [ :composite |
			composite addShortcutWith: [ :action |
					action
						shortcutKey: $j ctrl;
						action: [ fired := true ] ] ].

	self assert: (self menuOpenedDuring: [ presenter adapter widget simulateRightMouseDown ]) isNil
]

{ #category : 'tests' }
SpMorphicLayoutActionsTest >> testRightClickOnCompositeWithoutActionsOpensNoMenu [

	self newCompositeWith: [ :composite |  ].

	self assert: (self menuOpenedDuring: [ presenter adapter widget simulateRightMouseDown ]) isNil
]

{ #category : 'tests' }
SpMorphicLayoutActionsTest >> testShortcutOfCompositeActionFiresFromFocusedChild [

	| child |
	self newCompositeWith: [ :composite |
			composite addActionWith: [ :action |
					action
						name: 'Do it';
						shortcutKey: $j ctrl;
						action: [ fired := true ] ] ].
	child := presenter layout children first.

	child adapter widget kmDispatcher dispatchKeystroke: self ctrlJEvent.

	self assert: fired
]

{ #category : 'tests' }
SpMorphicLayoutActionsTest >> testShortcutOnlyActionOfCompositeFiresFromFocusedChild [

	| child |
	self newCompositeWith: [ :composite |
			composite addShortcutWith: [ :action |
					action
						shortcutKey: $j ctrl;
						action: [ fired := true ] ] ].
	child := presenter layout children first.

	child adapter widget kmDispatcher dispatchKeystroke: self ctrlJEvent.

	self assert: fired
]
