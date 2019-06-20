"
Basic API that a Miller Presenter should implement
"
Class {
	#name : #SpMillerPresenter,
	#superclass : #SpComposablePresenter,
	#category : #'Spec-Core-Miller'
}

{ #category : #initialization }
SpMillerPresenter >> whenActivatedDo: aBlock [

	self subclassResponsibility
]
