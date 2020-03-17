"
I am a LabelledContainer specialized to manage a InputTextDropList.
See LabelledContainer

self example

I provide the accessors inputTextDropList to be more intuitive than subwidget, and the shortcuts input and dropList.

I provide shortcuts for the most common methods to avoid the use of the DoesNotUnderstand or the writing of long chain of accessors.
"
Class {
	#name : #SpLabelledInputTextDropList,
	#superclass : #SpLabelledContainer,
	#category : #'Spec2-Deprecated-Obsolete'
}

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList class >> defaultSpec [
	<spec: #default>
	^ super labelLeft 
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList class >> example [
	<sampleInstance>
	| example |
	example := self abstractExample.
	example
		placeholder: 'ghost text';
		items: {'item 1' . 'item 2'};
		displayBlock: [ :item | item asString ];
		extent: 450 @ 50;
		openWithSpec.
	^ example
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList class >> isDeprecated [
	"This presenter does not add enough value to Spec to be kept in it. If you are using it, please copy the code in your own application."

	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> acceptOnCR: aBoolean [
	^ self input acceptOnCR: aBoolean
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> beEncrypted [
	^ self input beEncrypted
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> displayBlock: aBlock [
	^ self dropList displayBlock: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> dropList [
	^  self inputTextDropList dropList
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> emptyList [
	^ self dropList emptyList
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> encrypted: aBoolean [
	^ self input encrypted: aBoolean
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> entryCompletion: anEntryCompletion [
	^ self input entryCompletion: anEntryCompletion
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> ghostText: aText [
	self deprecated: 'This API is too tight to Morph. Use #placeholder: instead.' transformWith: '`@receiver ghostText: `@statement' -> '`@receiver placeholder: `@statement'.
	self placeholder: aText
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> initializePresenters [
super initializePresenters.
	self content: SpInputTextDropList.
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> input [
	^ self inputTextDropList input
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> inputTextDropList [
	^ subwidget
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> items: aList [
^ 	self dropList items: aList
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> listSize [
	^ self dropList listSize
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> placeholder: aText [
	^ self input placeholder: aText
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> resetSelection [
	^ self dropList resetSelection
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> selectedItem [
	^ self dropList selectedItem
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> setIndex: anIndex [
^ 	self dropList setIndex: anIndex
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> text [
	^ self input text
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> text: aText [
	^ self input text: aText
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> whenSelectedItemChanged: aBlock [
	self dropList
		whenSelectedItemChanged: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> whenSelectionChanged: aBlock [
	self dropList
		whenSelectionChanged: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledInputTextDropList >> whenSelectionIndexChanged: aBlock [
	self dropList
		whenSelectionIndexChanged: aBlock
]
