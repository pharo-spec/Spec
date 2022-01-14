"
I am an example of a presenter chooser.
I will show a list and a way to select it.
"
Class {
	#name : #SpPresenterSelectorExample,
	#superclass : #SpPresenter,
	#instVars : [
		'list',
		'choice'
	],
	#category : #'Spec2-Examples-Standalone'
}

{ #category : #specs }
SpPresenterSelectorExample class >> defaultSpec [

	^ nil
]

{ #category : #initialization }
SpPresenterSelectorExample >> initializePresenters [
	"self new openWithSpec"

	self layout: (SpPanedLayout newLeftToRight
		add: (list := self newList);
		add: (choice := self newPresenterSelector);
		yourself).

	list items: #(1 2 3).
	choice
		when: [ :aNumber | aNumber = 1 ] show: [ self newLabel label: 'One' ];
		when: [ :aNumber | aNumber = 2 ] show: [ self newLabel label: 'Two' ];
		when: [ :aNumber | aNumber = 3 ] show: [ self newLabel label: 'Three' ];
		defaultShow: [ self newLabel label: 'Choose one!' ];
		"update presenter is needed to make sure the presenter will have correct initial 
		 value (before anything happens)"
		updatePresenter.
		
	list transmitTo: choice
]

{ #category : #initialization }
SpPresenterSelectorExample >> initializeWindow: aWindowPresenter [

	aWindowPresenter title: 'Presenter Selector Example'
]
