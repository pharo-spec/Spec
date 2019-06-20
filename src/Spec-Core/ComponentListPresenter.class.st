"
I am a list of components ( Widgets :) )
"
Class {
	#name : #ComponentListPresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'#presenters => SpObservableSlot'
	],
	#category : #'Spec-Core-Widgets'
}

{ #category : #specs }
ComponentListPresenter class >> adapterName [
	^ #ComponentListAdapter
]

{ #category : #initialization }
ComponentListPresenter >> addPresenter: aPresenter [
	presenters add: aPresenter.
	self notifyPropertyChanged: #presenters
]

{ #category : #initialization }
ComponentListPresenter >> initialize [

	super initialize.
	presenters := OrderedCollection new
]

{ #category : #accessor }
ComponentListPresenter >> presenters [
	^ presenters
]

{ #category : #initialization }
ComponentListPresenter >> presenters: aCollection [
	presenters := aCollection.
"	self notifyPropertyChanged: #presenters"
]
