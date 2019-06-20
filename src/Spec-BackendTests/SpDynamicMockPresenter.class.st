Class {
	#name : #SpDynamicMockPresenter,
	#superclass : #SpComposablePresenter,
	#instVars : [
		'dynamicPresenter',
		'builder'
	],
	#category : #'Spec-BackendTests'
}

{ #category : #specs }
SpDynamicMockPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #dynamicPresenter;
		yourself
]

{ #category : #accessing }
SpDynamicMockPresenter >> dynamicPresenter [
	^ dynamicPresenter
]

{ #category : #accessing }
SpDynamicMockPresenter >> dynamicPresenter: anObject [
	dynamicPresenter := anObject
]

{ #category : #initialization }
SpDynamicMockPresenter >> initializeWidgets [
	dynamicPresenter := self newNullPresenter.
	self rebuildDynamicPresenter
]

{ #category : #'dynamic presenter' }
SpDynamicMockPresenter >> rebuildDynamicPresenter [

	builder := DynamicPresentersListBuilder new
		modelObjects: (1 to: 15);
		presenter: SpButtonPresenter configuredAs: [ :presenter :modelObject | presenter label: modelObject asString ];
		layoutBuilder: (DynamicLeftToRightColumnsLayout columns: 5);
		yourself.

	self newDynamicPresentersListIn: #dynamicPresenter usingBuilder: builder
]
