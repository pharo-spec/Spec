Class {
	#name : 'SpEasyColumnCellPresenter',
	#superclass : 'SpEasyAbstractRowPresenter',
	#instVars : [
		'textPresenter'
	],
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

{ #category : 'layout' }
SpEasyColumnCellPresenter >> defaultLayout [

	^ SpBoxLayout newHorizontal
		borderWidth: 2;
		add: textPresenter;
		yourself
]

{ #category : 'initialization' }
SpEasyColumnCellPresenter >> initializePresenters [

	textPresenter := self newLabel
]

{ #category : 'layout' }
SpEasyColumnCellPresenter >> textLayout [

	^ SpBoxLayout newHorizontal
		borderWidth: 2;
		add: textPresenter;
		yourself
]

{ #category : 'initialization' }
SpEasyColumnCellPresenter >> updatePresenter [

	textPresenter label: self model asString
]
