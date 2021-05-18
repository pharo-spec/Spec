"
A small example to be used in the notebook demo.
"
Class {
	#name : #SpDemoMessageBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'messageList',
		'sourceText',
		'messages'
	],
	#category : #'Spec2-Examples-Demo-Other'
}

{ #category : #initialization }
SpDemoMessageBrowser >> connectPresenters [

	messageList 
		transmitTo: sourceText  
		transform: [ :aMethod | 
			aMethod 
				ifNotNil: [ aMethod sourceCode ]
				ifNil: [ '' ] ]
]

{ #category : #initialization }
SpDemoMessageBrowser >> initializePresenters [

	self layout: (SpBoxLayout newTopToBottom
		add: (messageList := self newTable);
		add: (sourceText := self newCode);
		yourself).
		
	messageList 
		addColumn: (SpStringTableColumn title: 'Class' evaluated: [ :each | each origin name ]);
		addColumn: (SpStringTableColumn title: 'Name' evaluated: [ :each | each selector ]).
		
	sourceText beNotEditable
]

{ #category : #accessing }
SpDemoMessageBrowser >> messages [

	^ messages ifNil: [ #() ]
]

{ #category : #accessing }
SpDemoMessageBrowser >> messages: anOrderedCollection [

	messages := anOrderedCollection asOrderedCollection.
	self updatePresenter
]

{ #category : #initialization }
SpDemoMessageBrowser >> updatePresenter [

	messageList items: self messages
]
