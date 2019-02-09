Class {
	#name : #SpecLayoutShowcaseInstance,
	#superclass : #ComposablePresenter,
	#instVars : [
		'layout',
		'presenter1',
		'presenter2',
		'presenter3',
		'presenter4'
	],
	#category : #'Spec-Layout-Examples'
}

{ #category : #specs }
SpecLayoutShowcaseInstance class >> defaultSpec [
	
	^ SpecBoxLayout newVertical
]

{ #category : #api }
SpecLayoutShowcaseInstance >> buildWithSpec [

	^ self buildWithSpecLayout: self layout
]

{ #category : #api }
SpecLayoutShowcaseInstance >> buildWithSpec: aSpec [

	^ self buildWithSpecLayout: self layout
]

{ #category : #initialization }
SpecLayoutShowcaseInstance >> initializeWidgets [
	
	presenter1 := self newLabel label: 'Presenter 1'. 
	presenter2 := self newLabel label: 'Presenter 2'. 
	presenter3 := self newLabel label: 'Presenter 3'. 
	presenter4 := self newLabel label: 'Presenter 4'
]

{ #category : #accessing }
SpecLayoutShowcaseInstance >> layout [
	^ layout ifNil: [ layout := self class defaultSpec ]
]

{ #category : #accessing }
SpecLayoutShowcaseInstance >> layout: anObject [
	layout := anObject
]
