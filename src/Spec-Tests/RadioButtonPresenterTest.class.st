Class {
	#name : #RadioButtonPresenterTest,
	#superclass : #SpecSmokeTestCase,
	#category : #'Spec-Tests-Core-Widgets'
}

{ #category : #running }
RadioButtonPresenterTest >> classToTest [
	^  RadioButtonPresenter
]

{ #category : #tests }
RadioButtonPresenterTest >> testCanDeselectByClick [
	self deny: presenter canDeselectByClick.
	presenter click.
	self assert: presenter state.
	presenter click.
	self assert: presenter state.
	presenter canDeselectByClick: true.
	presenter click.
	self deny: presenter state
]

{ #category : #tests }
RadioButtonPresenterTest >> testToggleState [
	self deny: presenter state.
	presenter toggleState.
	self assert: presenter state
]
