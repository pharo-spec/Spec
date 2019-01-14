Class {
	#name : #SpecDemoListsPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'list1',
		'list2',
		'list3'
	],
	#category : #'Spec-Examples-Demo-Lists'
}

{ #category : #specs }
SpecDemoListsPresenter class >> defaultSpec [
	^ SpecLayout composed
		newRow: [ :mainRow | 
			mainRow
				newColumn: #list1;
				newColumn: #list2;
				newColumn: #list3 ];
		yourself
]

{ #category : #initialization }
SpecDemoListsPresenter >> initializeWidgets [
	list1 := self newList.
	list2 := self newList.
	list3 := self newList.

	list1
		items: Smalltalk globals allClasses;
		backgroundColorBlock: [ :object :rowIndex | rowIndex odd ifTrue: [ Smalltalk ui theme lightBackgroundColor ] ifFalse: [ Smalltalk ui theme backgroundColor ] ].
	list2 items: Smalltalk globals allClasses.
	list3 items: Smalltalk globals allClasses
]

{ #category : #accessing }
SpecDemoListsPresenter >> list1 [
	^ list1
]

{ #category : #accessing }
SpecDemoListsPresenter >> list2 [
	^ list2
]

{ #category : #accessing }
SpecDemoListsPresenter >> list3 [
	^ list3
]
