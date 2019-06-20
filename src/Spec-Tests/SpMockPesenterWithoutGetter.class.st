Class {
	#name : #SpMockPesenterWithoutGetter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'buttonPresenter'
	],
	#category : #'Spec-Tests-Utils'
}

{ #category : #specs }
SpMockPesenterWithoutGetter class >> defaultSpec [
	^ SpLayout composed newColumn: [ :col | col newRow: [ :row | row add: #buttonPresenter ] ]
]

{ #category : #initialization }
SpMockPesenterWithoutGetter >> initializeWidgets [
	buttonPresenter := self newButton
]
