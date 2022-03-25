Class {
	#name : #SpMenuPresenterTest,
	#superclass : #SpSmokeTest,
	#category : #'Spec2-Tests-Core-Widgets'
}

{ #category : #accessing }
SpMenuPresenterTest >> classToTest [
	^ SpMenuPresenter
]

{ #category : #tests }
SpMenuPresenterTest >> testValue [ 

	self assert: presenter value equals: presenter
]
