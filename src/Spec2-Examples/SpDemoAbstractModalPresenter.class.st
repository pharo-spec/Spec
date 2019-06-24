"
Description
--------------------

I am an abstract class for example modals.
"
Class {
	#name : #SpDemoAbstractModalPresenter,
	#superclass : #SpComposablePresenter,
	#instVars : [
		'explanation'
	],
	#category : #'Spec2-Examples-Demo-Modals'
}

{ #category : #specs }
SpDemoAbstractModalPresenter class >> defaultSpec [
	^ SpLayout composed
		add: #explanation;
		yourself
]

{ #category : #accessing }
SpDemoAbstractModalPresenter >> content [
	^ self subclassResponsibility
]

{ #category : #accessing }
SpDemoAbstractModalPresenter >> explanation [
	^ explanation
]

{ #category : #initialization }
SpDemoAbstractModalPresenter >> initializeWidgets [
	explanation := self newText.
	
	explanation text: self content
]
