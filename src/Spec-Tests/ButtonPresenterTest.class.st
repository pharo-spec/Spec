"
SUnit tests for Button model
"
Class {
	#name : #ButtonPresenterTest,
	#superclass : #SpecSmokeTestCase,
	#category : #'Spec-Tests-Core-Widgets'
}

{ #category : #running }
ButtonPresenterTest >> classToTest [
^ ButtonPresenter
]

{ #category : #running }
ButtonPresenterTest >> morph [
	^ presenter adapter widget
]

{ #category : #tests }
ButtonPresenterTest >> testAskBeforeChanging [
	| state |
	self assert: presenter askBeforeChanging not.
	self openInstance.
	state := presenter adapter askBeforeChanging.
	self assert: state not.
	presenter askBeforeChanging: true.
	state := presenter adapter askBeforeChanging.
	self assert: state
]

{ #category : #tests }
ButtonPresenterTest >> testEnabled [
	self assert: presenter enabled.
	self openInstance.
	self assert: self morph enabled.
	presenter enabled: false.
	self deny: self morph enabled
]
