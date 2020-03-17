"
I am an elementary Spec widget that associates a DropListPresenter and a ButtonPresenter.

self example

I provide accessors dropList and input and shortcuts for the most common methods of their api.
"
Class {
	#name : #SpDropListButton,
	#superclass : #SpPresenter,
	#instVars : [
		'dropList',
		'button'
	],
	#category : #'Spec2-Deprecated-Obsolete'
}

{ #category : #'*Spec2-Deprecated' }
SpDropListButton class >> defaultSpec [
	<spec: #default>
	^ SpLayout composed
		newRow: [ :row | 
			row
				add: #dropList origin: 0 @ 0 corner: 0.8 @ 1;
				add: #button origin: 0.8 @ 0 corner: 1 @ 1 ];
		yourself
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton class >> example [
	<sampleInstance>
	| example |
	example := self new.
	example
		displayBlock: [ :item | item asString ];
		items: {'Swordian' . 'Gardian' . 'Wizard' . 'Sniper'};
		label: 'Add';
		extent: 300 @ 70;
		openWithSpec.
	example withWindowDo: [ :window | window title: 'DropListButton example' ].
	^ example
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton class >> isDeprecated [
	"This presenter does not add enough value to Spec to be kept in it. If you are using it, please copy the code in your own application."

	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton >> action: aBlock [
	self button action: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton >> button [
	^ button
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton >> displayBlock: aBlock [
	self dropList display: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton >> dropList [
	^ dropList
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton >> emptyList [
	self dropList emptyList
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton >> icon: anIcon [
	self button icon: anIcon
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton >> initializePresenters [
	dropList := self instantiate: SpDropListPresenter.
	button := self instantiate: SpButtonPresenter.
	self focusOrder
		add: dropList;
		add: button
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton >> items: aList [
	self dropList items: aList
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton >> label [
	self button label
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton >> label: aStringOrImageMorph [
	self button label: aStringOrImageMorph
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton >> listSize [
	self dropList listSize
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton >> resetSelection [
	self dropList resetSelection
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton >> selectedItem [
	self dropList selectedItem
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton >> setIndex: anIndex [
	self dropList setIndex: anIndex
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton >> whenSelectedItemChanged: aBlock [
	self dropList
		whenSelectedItemChanged: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton >> whenSelectionChanged: aBlock [
	self dropList
		whenSelectionChanged: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpDropListButton >> whenSelectionIndexChanged: aBlock [
	self dropList
		whenSelectionIndexChanged: aBlock
]
