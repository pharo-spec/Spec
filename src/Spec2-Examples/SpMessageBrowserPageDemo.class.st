"
A small example to be used in the notebook demo.
"
Class {
	#name : #SpMessageBrowserPageDemo,
	#superclass : #SpPresenter,
	#instVars : [
		'messageList',
		'sourceText'
	],
	#category : #'Spec2-Examples-Demo-Notebook'
}

{ #category : #initialization }
SpMessageBrowserPageDemo >> connectPresenters [

	messageList 
		transmitTo: sourceText  
		transform: [ :aMethod | 
			aMethod 
				ifNotNil: [ aMethod sourceCode ]
				ifNil: [ '' ] ]
]

{ #category : #initialization }
SpMessageBrowserPageDemo >> initializePresenters [

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
SpMessageBrowserPageDemo >> messages [

	^ Object methods
]

{ #category : #initialization }
SpMessageBrowserPageDemo >> updatePresenter [

	messageList items: self messages
]
