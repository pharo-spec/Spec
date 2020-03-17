"
SearchableList 
	new items: #( aaa abc axz bbb bfbg bof c);
	openWithSpec
	
should it be a subclass of ListPresenter?
Because now I will have to delegate a lot? and I cannot plug a IconList

How do I make textModel react to every keystroke without an accept
"
Class {
	#name : #SpSearchableList,
	#superclass : #SpPresenter,
	#instVars : [
		'listPresenter',
		'searchPresenter',
		'baseItems'
	],
	#category : #'Spec2-Deprecated-Replaced'
}

{ #category : #'*Spec2-Deprecated' }
SpSearchableList class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #searchPresenter withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #listPresenter;
		yourself
]

{ #category : #'*Spec2-Deprecated' }
SpSearchableList class >> example [
	<sampleInstance>
	"self example"

	^ self new
		items: #(#aaa #abc #axz #bbb #bfbg #bof #c); openWithSpec
]

{ #category : #'*Spec2-Deprecated' }
SpSearchableList class >> isDeprecated [
	"Now lists have a filter integrated in them."

	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpSearchableList >> connectPresenters [
	searchPresenter
		whenTextChangedDo: [ :newText | 
			searchPresenter text asLowercase
				ifEmpty: [ listPresenter items: baseItems ]
				ifNotEmpty: [ :text | 
					listPresenter
						items:
							(baseItems select: [ :element | element asLowercase beginsWith: text ]) ] ]
]

{ #category : #'*Spec2-Deprecated' }
SpSearchableList >> initializePresenters [
	listPresenter := self newList.
	searchPresenter := self newTextInput.
	searchPresenter
		autoAccept: true;
		placeholder: 'Filter'
]

{ #category : #'*Spec2-Deprecated' }
SpSearchableList >> items: aCollection [
	baseItems := aCollection.
	listPresenter items: aCollection
]

{ #category : #'*Spec2-Deprecated' }
SpSearchableList >> listPresenter [
	^ listPresenter
]

{ #category : #'*Spec2-Deprecated' }
SpSearchableList >> searchPresenter [
	^ searchPresenter
]
