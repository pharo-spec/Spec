"
I am a LabelledContainer specialized to manage a DropListButton.
See LabelledContainer

self example

I provide the accessors dropListButton to be more intuitive than subwidget, and the shortcuts button and dropList.

I provide shortcuts for the most common methods to avoid the use of the DoesNotUnderstand or the writing of long chain of accessors.
"
Class {
	#name : #SpLabelledDropListButton,
	#superclass : #SpLabelledContainer,
	#category : #'Spec2-Deprecated-Obsolete'
}

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton class >> defaultSpec [
	<spec: #default>
	^ super labelLeft 
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton class >> example [
	<sampleInstance>
	| example |
	example := self abstractExample.
	example button label: 'I am a button'.
	example
		items: {'item 1' . 'item 2'};
		displayBlock: [ :item | item asString ];
		extent: 550 @ 50;
		openWithSpec.
	^ example
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton class >> exampleUse [
	<sampleInstance>
	| example |
	example := self new.
	example button label: 'Add'.
	example label: 'Compose your team';
		displayBlock: [ :item | item asString ];
		items: {'Swordian' . 'Gardian' . 'Wizard' . 'Sniper'};
		extent: 300 @ 120;
		title: 'LabelDropButton example of use';
		openWithSpec: #labelTop.
	^ example
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton class >> isDeprecated [
	"This presenter does not add enough value to Spec to be kept in it. If you are using it, please copy the code in your own application."

	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton >> action: aBlock [
	^self button action: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton >> button [
	^ self dropListButton button
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton >> displayBlock: aBlock [
	^ self dropList display: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton >> dropList [
	^ self dropListButton dropList
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton >> dropListButton [
	^ subwidget
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton >> emptyList [
	^self dropList emptyList
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton >> icon: anIcon [
^	self button icon: anIcon
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton >> initializePresenters [
super initializePresenters.
	self content: SpDropListButton.
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton >> items: aList [
	^self dropList items: aList
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton >> listSize [
	^ self dropList listSize
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton >> resetSelection [
^	self dropList resetSelection
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton >> selectedItem [
	^ self dropList selectedItem
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton >> setIndex: anIndex [
	^ self dropList setIndex: anIndex
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton >> whenSelectedItemChanged: aBlock [
	self dropList
		whenSelectedItemChanged: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton >> whenSelectionChanged: aBlock [
	self dropList
		whenSelectionChanged: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropListButton >> whenSelectionIndexChanged: aBlock [
	self dropList
		whenSelectionIndexChanged: aBlock
]
