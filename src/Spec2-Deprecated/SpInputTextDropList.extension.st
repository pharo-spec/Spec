Extension { #name : #SpInputTextDropList }

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> acceptOnCR: aBoolean [
	self input acceptOnCR: aBoolean
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> beEncrypted [
	self input beEncrypted
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList class >> defaultSpec [
	<spec: #default>
	^ SpLayout composed
		newRow: [ :row | 
			row
				add: #input origin: 0 @ 0 corner: 0.3 @ 1;
				add: #dropList origin: 0.3 @ 0 corner: 1 @ 1 ];
			yourself
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> display: aBlock [

	self dropList display: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> displayBlock: aBlock [

	self
		deprecated: 'Please use #display: instead'
		transformWith: '`@receiver displayBlock: `@arg' 
						-> '`@receiver display: `@arg'.

	self dropList display: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> dropList [
	^ dropList
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> emptyList [
	self dropList emptyList
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> encrypted: aBoolean [
	self input encrypted: aBoolean
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> entryCompletion: anEntryCompletion [
	self input entryCompletion: anEntryCompletion
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList class >> example [
	<sampleInstance>
	| example |
	example := self new
		placeholder: 'a Number';
		display: [ :item | item asString ];
		items: {'Potatoes' . 'Carrots' . 'Onions'};
		extent: 350 @ 50;
		openWithSpec;
		yourself.
	example withWindowDo: [ :window | window title: 'InputTextDropList example' ].
	^ example
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> ghostText: aText [
	self deprecated: 'This API is too tight to Morph. Use #placeholder: instead.' transformWith: '`@receiver ghostText: `@statement' -> '`@receiver placeholder: `@statement'.
	self placeholder: aText
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> initializeWidgets [
	input := self instantiate: SpTextInputFieldPresenter.
	dropList := self instantiate: SpDropListPresenter.
	self focusOrder
		add: input;
		add: dropList
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> input [
	^ input
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList class >> isDeprecated [
	"This presenter does not add enough value to Spec to be kept in it. If you are using it, please copy the code in your own application."

	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> items: aList [
	self dropList items: aList
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> listSize [
	self dropList listSize
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> placeholder: aText [
	self input placeholder: aText
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> resetSelection [
	self dropList resetSelection
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> selectedItem [
	self dropList selectedItem
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> setIndex: anIndex [
	self dropList setIndex: anIndex
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> text [
	self input text
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> text: aText [
	self input text: aText
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> whenSelectedItemChanged: aBlock [
	self dropList whenSelectedItemChanged: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> whenSelectionChanged: aBlock [
	self dropList whenSelectionChanged: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpInputTextDropList >> whenSelectionIndexChanged: aBlock [
	self dropList whenSelectionIndexChanged: aBlock
]
