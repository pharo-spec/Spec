"
An FastTablePresenter is a spec presenter for a FastTable
"
Class {
	#name : #FastTablePresenter,
	#superclass : #ListPresenter,
	#instVars : [
		'iconHolder',
		'handlesDoubleClick'
	],
	#category : #'Spec-Core-Widgets'
}

{ #category : #example }
FastTablePresenter class >> example [
	<sampleInstance>
	| example |
	example := self new.
	example
		icons: [ :e | example iconNamed: #forwardIcon ];
		items: (1 to: 10) asArray;
		openWithSpec.
	^ example
]

{ #category : #example }
FastTablePresenter class >> exampleMultipleSelection [
	<sampleInstance>
	| example |
	example := self new.
	example
		items: (1 to: 10);
		beMultipleSelection;
		whenSelectionChangedDo: [ :selection | selection logCr ];
		openWithSpec.
	^ example
]

{ #category : #api }
FastTablePresenter >> getIconFor: anItem [

	^ iconHolder value cull: anItem cull: self
]

{ #category : #api }
FastTablePresenter >> handlesDoubleClick [

	^ handlesDoubleClick value
]

{ #category : #api }
FastTablePresenter >> handlesDoubleClick: aBoolean [
	"<api: #block getter:#handlesDoubleClick registration: #whenHandlesDoubleClickChanged:>"
	"Enable or disable double click on the list."
	
	handlesDoubleClick value: aBoolean
]

{ #category : #api }
FastTablePresenter >> icons [
	"<api: #inspect>"
	"Return the block which takes an item as argument and returns the icon to display in the list"
	
	^ iconHolder value
]

{ #category : #api }
FastTablePresenter >> icons: aBlock [
	"<api: #block getter: #icon registration: #whenIconsChanged: >"
	"Set a block which takes an item as argument and returns the icon to display in the list"
	iconHolder value: aBlock
]

{ #category : #initialization }
FastTablePresenter >> initializeValueHolders [

	super initializeValueHolders.

	iconHolder := [:item | nil ] asValueHolder.
	handlesDoubleClick := false asValueHolder.
]

{ #category : #initialization }
FastTablePresenter >> registerEvents [
	super registerEvents.
	handlesDoubleClick whenChangedDo: [ :bool | self changed: { #handlesDoubleClick . bool } ].

]

{ #category : #'api-events' }
FastTablePresenter >> whenIconsChanged: aBlock [ 
	
	iconHolder whenChangedDo: aBlock 


]
