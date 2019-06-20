Class {
	#name : #SpExecutableLayoutWithDynamicPresenterTest,
	#superclass : #AbstractLayoutTestCase,
	#category : #'Spec-BackendTests-Layout'
}

{ #category : #accessing }
SpExecutableLayoutWithDynamicPresenterTest >> classToTest [
	^ SpDynamicMockPresenter
]

{ #category : #tests }
SpExecutableLayoutWithDynamicPresenterTest >> testSuceedToOpenInstance [
	self shouldnt: [ self openInstance ] raise: Error
]
