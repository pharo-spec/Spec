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
		'label',
		'multiLabel'
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
				newRow: [ :row | 
					row
						newColumn: #multiLabel;
						newColumn: #label ]
					height: self labelHeight ];
		yourself
]

{ #category : #defaults }
SpecDemoListsPresenter >> iconFor: class [
	((class includesBehavior: (Smalltalk globals at: #TestCase ifAbsent: [ false ])) and: [ class isAbstract not ])
		ifTrue: [ class hasPassedTest ifTrue: [ ^ self iconNamed: #testGreenIcon ].
			class hasFailedTest ifTrue: [ ^ self iconNamed: #testYellowIcon ].
			class hasErrorTest ifTrue: [ ^ self iconNamed: #testRedIcon ].
			^ self iconNamed: #testNotRunIcon ].
	class organization classComment ifEmpty: [ ^ self iconNamed: #uncommentedClassIcon ].
	((class includesBehavior: (Smalltalk globals at: #TestCase ifAbsent: [ false ])) and: [ class isAbstract not ])
		ifTrue: [ class hasPassedTest ifTrue: [ ^ self iconNamed: #testGreenIcon ].
			class hasFailedTest ifTrue: [ ^ self iconNamed: #testYellowIcon ].
			class hasErrorTest ifTrue: [ ^ self iconNamed: #testRedIcon ].
			^ self iconNamed: #testNotRunIcon ].
	class organization classComment ifEmpty: [ ^ self iconNamed: #uncommentedClassIcon ].
	^ class systemIcon
]

{ #category : #initialization }
SpecDemoListsPresenter >> initializePresenter [
	list1
		whenSelectedItemChanged: [ :elem | label label: (elem ifNil: [ 'Deselection from list 1' ] ifNotNil: [ 'Selection from list 1: ' , elem asString ]) ].
	list2
		whenSelectedItemChanged: [ :elem | label label: (elem ifNil: [ 'Deselection from list 1' ] ifNotNil: [ 'Selection from list 1: ' , elem asString ]) ].
	list2
		whenSelectedItemsChanged: [ :elems | multiLabel label: (elems ifEmpty: [ 'Not multi selection (from list 2 only)' ] ifNotEmpty: [ 'Multi-selection from list 2: ' , elems asString ]) ].
	list3
		whenSelectedItemChanged: [ :elem | label label: (elem ifNil: [ 'Deselection from list 3' ] ifNotNil: [ 'Selection from list 3: ' , elem asString ]) ]
]

{ #category : #initialization }
SpecDemoListsPresenter >> initializeWidgets [
	list1 := self newList.
	list2 := self newList.
	list3 := self newIconList.
	label := self newLabel.
	multiLabel := self newLabel.

	list1
		items: Smalltalk globals allClasses;
		backgroundColorBlock:
				[ :object :rowIndex | rowIndex odd ifTrue: [ Smalltalk ui theme lightBackgroundColor alpha: 0.5 ] ifFalse: [ Smalltalk ui theme backgroundColor alpha: 0.5 ] ].
	list2
		items: Smalltalk globals allClasses;
		sortingBlock: [ :a :b | a asString size < b asString size ];
		multiSelection: true.
	list3
		items: Smalltalk globals allClasses;
		itemFilterBlock: [ :item :string | item asString includesSubstring: string ];
		icons: [ :elem | self iconFor: elem ].
	label label: 'No selection'.
	multiLabel label: 'Not multi selection (from list 2 only)'
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

{ #category : #accessing }
SpecDemoListsPresenter >> multiLabel [
	^ multiLabel
]
