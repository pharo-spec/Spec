Class {
	#name : 'SpMockPesenterWithoutGetter',
	#superclass : 'SpPresenter',
	#instVars : [
		'buttonPresenter'
	],
	#category : 'Spec2-Tests-Utils',
	#package : 'Spec2-Tests',
	#tag : 'Utils'
}

{ #category : 'layout' }
SpMockPesenterWithoutGetter class >> defaultLayout [
	^ SpBoxLayout newLeftToRight
		add: #buttonPresenter;
		yourself
]

{ #category : 'initialization' }
SpMockPesenterWithoutGetter >> initializePresenters [
	buttonPresenter := self newButton
]
