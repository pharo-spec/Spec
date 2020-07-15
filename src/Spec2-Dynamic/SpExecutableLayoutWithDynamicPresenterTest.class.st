Class {
	#name : #SpExecutableLayoutWithDynamicPresenterTest,
	#superclass : #SpAbstractLayoutTest,
	#category : #'Spec2-Dynamic-Backend-Tests-Layout'
}

{ #category : #accessing }
SpExecutableLayoutWithDynamicPresenterTest >> classToTest [
	^ SpDynamicMockPresenter
]

{ #category : #tests }
SpExecutableLayoutWithDynamicPresenterTest >> testSuceedToOpenInstance [
	self shouldnt: [ self openInstance ] raise: Error
]
