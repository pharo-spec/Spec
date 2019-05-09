Class {
	#name : #CodePresenterTest,
	#superclass : #TextPresenterTest,
	#category : #'Spec-Tests-Core-Widgets'
}

{ #category : #running }
CodePresenterTest >> classToTest [

	^ CodePresenter
]

{ #category : #tests }
CodePresenterTest >> testContextKeyBindings [

	self assert: presenter contextKeyBindings notNil
]
