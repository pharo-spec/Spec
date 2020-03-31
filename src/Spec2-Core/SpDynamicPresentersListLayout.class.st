"
I am an abstract layout builder for a DynamicComposablePresenter built using DynamicPresentersListBuilder.
"
Class {
	#name : #SpDynamicPresentersListLayout,
	#superclass : #Object,
	#instVars : [
		'constraintsBlock'
	],
	#category : #'Spec2-Core-Dynamic-Builder'
}

{ #category : #building }
SpDynamicPresentersListLayout >> buildFor: aDynamicPresentersListBuilder [
	aDynamicPresentersListBuilder
		createNullPresenters: (self nullPresentersNeededFor: aDynamicPresentersListBuilder).
	^ self buildLayoutFor: aDynamicPresentersListBuilder
]

{ #category : #building }
SpDynamicPresentersListLayout >> buildLayoutFor: aDynamicPresentersListBuilder [
	^ self subclassResponsibility
]

{ #category : #accessing }
SpDynamicPresentersListLayout >> constraintsBlock [
	^ constraintsBlock ifNil: [ constraintsBlock := [ :c |  ] ]
]

{ #category : #accessing }
SpDynamicPresentersListLayout >> constraintsBlock: anObject [
	constraintsBlock := anObject
]

{ #category : #building }
SpDynamicPresentersListLayout >> instVarNamesFrom: aDynamicPresentersListBuilder [
	^ aDynamicPresentersListBuilder instVarNames , aDynamicPresentersListBuilder nullPresentersInstVarNames
]

{ #category : #building }
SpDynamicPresentersListLayout >> nullPresentersNeededFor: aDynamicPresentersListBuilder [
	"Compute the number of empty presenters required to fill additional space if the number of model objects modulo the number of columns/rows is not equals to 0."
	^ self subclassResponsibility
]
