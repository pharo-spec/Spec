Class {
	#name : #SpExecutableLayoutWithDynamicPresenterTest,
	#superclass : #AbstractLayoutTestCase,
	#category : #'Spec-BackendTests-Layout'
}

{ #category : #accessing }
SpExecutableLayoutWithDynamicPresenterTest >> classToTest [
	^ DynamicMockPresenter
]

{ #category : #tests }
SpExecutableLayoutWithDynamicPresenterTest >> testSuceedToOpenInstance [
	self shouldnt: [ self openInstance ] raise: Error
]
