"
An FastTablePresenter is a spec presenter for a FastTable
"
Class {
	#name : #SpFastTablePresenter,
	#superclass : #SpTablePresenter,
	#instVars : [
		'#handlesDoubleClick => SpObservableSlot',
		'#displayBlock',
		'#icon => SpObservableSlot'
	],
	#category : #'Spec2-Deprecated-Replaced'
}

{ #category : #'*Spec2-Deprecated' }
SpFastTablePresenter class >> example [
	<sampleInstance>
	| example |
	example := self new.
	example
		icons: [ :e | example iconNamed: #forwardIcon ];
		items: (1 to: 10) asArray;
		openWithSpec.
	^ example
]

{ #category : #'*Spec2-Deprecated' }
SpFastTablePresenter class >> exampleMultipleSelection [
	<sampleInstance>
	| example |
	example := self new.
	example
		items: (1 to: 10);
		beMultipleSelection;
		whenSelectionChangedDo: [ :selection | selection traceCr ];
		openWithSpec.
	^ example
]

{ #category : #'*Spec2-Deprecated' }
SpFastTablePresenter class >> isDeprecated [
	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpFastTablePresenter >> displayBlock [

	^ displayBlock
]

{ #category : #'*Spec2-Deprecated' }
SpFastTablePresenter >> displayBlock: aBlock [

	displayBlock := aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpFastTablePresenter >> getIconFor: anItem [
	^ self icons cull: anItem cull: self
]

{ #category : #'*Spec2-Deprecated' }
SpFastTablePresenter >> handlesDoubleClick [
	^ handlesDoubleClick
]

{ #category : #'*Spec2-Deprecated' }
SpFastTablePresenter >> handlesDoubleClick: aBoolean [
	"Enable or disable double click on the list."

	handlesDoubleClick := aBoolean
]

{ #category : #'*Spec2-Deprecated' }
SpFastTablePresenter >> icons [
	"Return the block which takes an item as argument and returns the icon to display in the list"

	^ icon
]

{ #category : #'*Spec2-Deprecated' }
SpFastTablePresenter >> icons: aBlock [
	"Set a block which takes an item as argument and returns the icon to display in the list"

	icon := aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpFastTablePresenter >> initialize [
	super initialize.
	displayBlock := #yourself.
	icon := [ :item | nil ].
	handlesDoubleClick := false
]

{ #category : #'*Spec2-Deprecated' }
SpFastTablePresenter >> numberOfColumns: aNumber [
	columns := OrderedCollection new.
	(1 to: aNumber) do: [ :index | self addColumn: (SpStringTableColumn evaluated: [ :entity | (self displayBlock value: entity) at: index ]) ]
]

{ #category : #'*Spec2-Deprecated' }
SpFastTablePresenter >> numberOfColumns: aNumber withWidths: widths [
	columns := OrderedCollection new.
	(1 to: aNumber)
		do: [ :index | 
			self
				addColumn:
					((SpStringTableColumn evaluated: [ :entity | (self displayBlock value: entity) at: index ])
						width: (widths at: index);
						yourself) ]
]

{ #category : #'*Spec2-Deprecated' }
SpFastTablePresenter >> registerEvents [
	super registerEvents.
	self property: #handlesDoubleClick whenChangedDo: [ :bool | self changed: { #handlesDoubleClick . bool } ].

]

{ #category : #'*Spec2-Deprecated' }
SpFastTablePresenter >> whenIconsChanged: aBlock [
	self deprecated: 'Use #whenIconsChangedDo: instead.' transformWith: '`@receiver whenIconsChanged: `@statements' -> '`@receiver whenIconsChangedDo: `@statements'.
	self whenIconsChangedDo: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpFastTablePresenter >> whenIconsChangedDo: aBlock [
	self property: #icon whenChangedDo: aBlock
]
