Class {
	#name : #MessageList,
	#superclass : #ComposablePresenter,
	#instVars : [
		'listModel',
		'cachedHierarchy'
	],
	#category : #'Spec-Tools-Senders'
}

{ #category : #specs }
MessageList class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add: #listModel;
		yourself
]

{ #category : #initialization }
MessageList >> initializeWidgets [
	listModel := self newTable.

	listModel
		addColumn: (StringTableColumn title: 'Location' evaluated: [ :item | self locationOf: item ]);
		addColumn: (StringTableColumn title: 'Selector' evaluated: [ :item | self selectorOf: item ]);
		addColumn: (StringTableColumn title: 'Package' evaluated: [ :item | self packageOf: item ]);
		beResizable
]

{ #category : #private }
MessageList >> methodClassNameForItem: anItem [
	^ anItem methodClass ifNotNil: [ :class | class name ] ifNil: [ '' ]
]

{ #category : #private }
MessageList >> packageNameForItem: anItem [
	^ anItem package ifNil: [ '' ] ifNotNil: [ :package | package name ]
]

{ #category : #private }
MessageList >> packageOf: anItem [
	^ '[' , (self packageNameForItem: anItem) , ']'
]

{ #category : #private }
MessageList >> protocolNameForItem: anItem [
	^ anItem category ifNil: [ '' ]
]

{ #category : #accessing }
MessageList >> selectorOf: anItem [
	^ anItem selector
]
