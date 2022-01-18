Class {
	#name : #SpMockMenuPresenter,
	#superclass : #SpMenuPresenter,
	#instVars : [
		'shown'
	],
	#category : #'Spec2-Backend-Tests-Base'
}

{ #category : #building }
SpMockMenuPresenter >> build [

	^ SpMockMenu new
		realMenu: super build;
		whenShownDo: [ shown := true ];
		yourself
]

{ #category : #initialization }
SpMockMenuPresenter >> initialize [ 

	super initialize.
	shown := false.
]

{ #category : #accessing }
SpMockMenuPresenter >> shown [
	^ shown
]

{ #category : #accessing }
SpMockMenuPresenter >> shown: anObject [
	^ shown := anObject
]
