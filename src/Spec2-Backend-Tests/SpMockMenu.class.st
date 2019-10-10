Class {
	#name : #SpMockMenu,
	#superclass : #Object,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#realMenu',
		'#shown => ObservableSlot'
	],
	#category : #'Spec2-Backend-Tests'
}

{ #category : #initialization }
SpMockMenu >> initialize [
	
	self class initializeSlots: self.
	super initialize.
	shown := false
]

{ #category : #accessing }
SpMockMenu >> realMenu [
	^ realMenu
]

{ #category : #accessing }
SpMockMenu >> realMenu: anObject [
	realMenu := anObject
]

{ #category : #accessing }
SpMockMenu >> shown [
	^ shown
]

{ #category : #accessing }
SpMockMenu >> shown: anObject [
	shown := anObject
]

{ #category : #accessing }
SpMockMenu >> whenShownDo: aBlock [
	self property: #shown whenChangedDo: aBlock
]
