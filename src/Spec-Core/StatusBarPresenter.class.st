Class {
	#name : #StatusBarPresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'messageHolder'
	],
	#category : #'Spec-Core-Widgets-Toolbar'
}

{ #category : #specs }
StatusBarPresenter class >> adapterName [

	^ #StatusBarAdapter
]

{ #category : #specs }
StatusBarPresenter class >> defaultSpec [
	<spec: #default>
	
	^ #(StatusBarAdapter
		adapt: #(model))
]

{ #category : #initialization }
StatusBarPresenter >> initialize [

	super initialize.
	messageHolder := nil asValueHolder
]

{ #category : #accessing }
StatusBarPresenter >> message [

	^ messageHolder value
]

{ #category : #private }
StatusBarPresenter >> message: aString [

	messageHolder value: aString
]

{ #category : #accessing }
StatusBarPresenter >> popMessage [ 
	
	self message: nil.
	self changed: #popMessage
]

{ #category : #accessing }
StatusBarPresenter >> pushMessage: aString [ 
	
	self message: aString.
	self changed: #pushMessage
]
