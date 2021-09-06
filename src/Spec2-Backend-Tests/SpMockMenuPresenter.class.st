Class {
	#name : #SpMockMenuPresenter,
	#superclass : #SpMenuPresenter,
	#instVars : [
		'shown'
	],
	#category : #'Spec2-Backend-Tests-Base'
}

{ #category : #building }
SpMockMenuPresenter >> buildWithSpec [

	^ SpMockMenu new
		realMenu: super buildWithSpec;
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
