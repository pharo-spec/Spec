Class {
	#name : #AthensStaticPresenterTests,
	#superclass : #AbstractAdapterTestCase,
	#category : #'Spec-BackendTests'
}

{ #category : #accessing }
AthensStaticPresenterTests >> classToTest [
	^ AthensStaticPresenter
]

{ #category : #accessing }
AthensStaticPresenterTests >> initializeTestedInstance [
	presenter drawBlock: [ "nothing to do" ]
]

{ #category : #accessing }
AthensStaticPresenterTests >> testSmokeCreates [
	self presenter.
]
