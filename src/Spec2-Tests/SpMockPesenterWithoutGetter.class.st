Class {
	#name : #SpMockPesenterWithoutGetter,
	#superclass : #SpComposablePresenter,
	#instVars : [
		'buttonPresenter'
	],
	#category : #'Spec2-Tests-Utils'
}

{ #category : #specs }
SpMockPesenterWithoutGetter class >> defaultSpec [
	^ SpLayout composed newColumn: [ :col | col newRow: [ :row | row add: #buttonPresenter ] ]
]

{ #category : #initialization }
SpMockPesenterWithoutGetter >> initializeWidgets [
	buttonPresenter := self newButton
]
