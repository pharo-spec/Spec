"
I'm a kind of API that a `SpMillerPresenter` should implement: basically one single method `whenActivedDo:`.
"
Class {
	#name : #SpMillerPresenter,
	#superclass : #SpPresenter,
	#category : #'Spec2-Core-Miller'
}

{ #category : #initialization }
SpMillerPresenter >> whenActivatedDo: aBlock [

	self subclassResponsibility
]
