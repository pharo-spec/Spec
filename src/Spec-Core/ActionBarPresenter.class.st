Class {
	#name : #ActionBarPresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'items'
	],
	#category : #'Spec-Core-Widgets'
}

{ #category : #specs }
ActionBarPresenter class >> adapterName [

	^ #ActionBarAdapter
]

{ #category : #adding }
ActionBarPresenter >> add: aButtonPresenter [
	
	items add: aButtonPresenter
]

{ #category : #initialization }
ActionBarPresenter >> initialize [

	super initialize.
	items := OrderedCollection new asValueHolder
]

{ #category : #api }
ActionBarPresenter >> items [
	^ items value
]
