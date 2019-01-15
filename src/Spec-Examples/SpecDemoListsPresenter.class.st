"
Description
--------------------

I am a demo showing how to use Spec lists.
"
Class {
	#name : #SpecDemoListsPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'list1',
		'list2',
		'list3',
		'label'
	],
	#category : #'Spec-Examples-Demo-Lists'
}

{ #category : #specs }
SpecDemoListsPresenter class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :mainColumn | 
			mainColumn
				newRow: [ :lists | 
					lists
						newColumn: #list1;
						newColumn: #list2;
						newColumn: #list3 ];
				newRow: #label height: self labelHeight ];
		yourself
]

{ #category : #initialization }
SpecDemoListsPresenter >> initializePresenter [
	list1 whenSelectedItemChanged: [ :elem | label label: (elem ifNil: [ 'Deselection from list 1' ] ifNotNil: [ 'Selection from list 1: ' , elem asString ]) ].
	list2 whenSelectedItemChanged: [ :elem | label label: (elem ifNil: [ 'Deselection from list 2' ] ifNotNil: [ 'Selection from list 2: ' , elem asString ]) ].
	list3 whenSelectedItemChanged: [ :elem | label label: (elem ifNil: [ 'Deselection from list 3' ] ifNotNil: [ 'Selection from list 3: ' , elem asString ]) ]
]

{ #category : #initialization }
SpecDemoListsPresenter >> initializeWidgets [
	list1 := self newList.
	list2 := self newList.
	list3 := self newList.
	label := self newLabel.

	list1
		items: Smalltalk globals allClasses;
		backgroundColorBlock:
				[ :object :rowIndex | rowIndex odd ifTrue: [ Smalltalk ui theme lightBackgroundColor alpha: 0.5 ] ifFalse: [ Smalltalk ui theme backgroundColor alpha: 0.5 ] ].
	list2
		items: Smalltalk globals allClasses;
		sortingBlock: [ :a :b | a asString size < b asString size ].
	list3
		items: Smalltalk globals allClasses;
		itemFilterBlock: [ :item :string | item asString includesSubstring: string ].
	label label: ''
]

{ #category : #accessing }
SpecDemoListsPresenter >> label [
	^ label
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
