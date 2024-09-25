"
Description
--------------------

I am a demo showing how to use Spec lists.
"
Class {
	#name : 'SpDemoListsPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'list1',
		'list2',
		'list3',
		'label',
		'multiLabel'
	],
	#category : 'Spec2-Examples-Demo-Lists',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Lists'
}

{ #category : 'initialization' }
SpDemoListsPresenter >> connectPresenters [

	list1 whenSelectionChangedDo: [ :selection | 
		[ :elem | 
		label label: (elem
				 ifNil: [ 'Deselection from list 1' ]
				 ifNotNil: [ 'Selection from list 1: ' , elem asString ]) ] cull:
			selection selectedItem ].

	list2 whenSelectionChangedDo: [ :selection | 
		[ :elems | 
		multiLabel label: (elems
				 ifEmpty: [ 'Not multi selection (from list 2 only)' ]
				 ifNotEmpty: [ 'Multi-selection from list 2: ' , elems asString ]) ] 
			cull: selection selectedItems ].
	list3 whenSelectionChangedDo: [ :selection | 
		[ :elem | 
		label label: (elem
				 ifNil: [ 'Deselection from list 3' ]
				 ifNotNil: [ 'Selection from list 3: ' , elem asString ]) ] cull:
			selection selectedItem ]
]

{ #category : 'layout' }
SpDemoListsPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: (SpBoxLayout newTopToBottom
						    add: 'Menu' expand: false;
						    add: list1;
						    yourself);
				   add: (SpBoxLayout newTopToBottom
						    add: 'Multi selection/Sorting' expand: false;
						    add: list2;
						    yourself);
				   add: (SpBoxLayout newTopToBottom
						    add: 'Icons/Filter' expand: false;
						    add: list3;
						    yourself);
				   yourself);
		  add: (SpBoxLayout newLeftToRight
				   add: multiLabel;
				   add: label;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : 'defaults' }
SpDemoListsPresenter >> iconFor: class [
	((class includesBehavior: (Smalltalk globals at: #TestCase ifAbsent: [ false ])) and: [ class isAbstract not ])
		ifTrue: [ class hasPassedTest ifTrue: [ ^ self iconNamed: #testGreen ].
			class hasFailedTest ifTrue: [ ^ self iconNamed: #testYellow ].
			class hasErrorTest ifTrue: [ ^ self iconNamed: #testRed ].
			^ self iconNamed: #testNotRun ].
	class comment ifEmpty: [ ^ self iconNamed: #uncommentedClass ].
	((class includesBehavior: (Smalltalk globals at: #TestCase ifAbsent: [ false ])) and: [ class isAbstract not ])
		ifTrue: [ class hasPassedTest ifTrue: [ ^ self iconNamed: #testGreen ].
			class hasFailedTest ifTrue: [ ^ self iconNamed: #testYellow ].
			class hasErrorTest ifTrue: [ ^ self iconNamed: #testRed ].
			^ self iconNamed: #testNotRun ].
	^ self iconNamed: class systemIconName
]

{ #category : 'initialization' }
SpDemoListsPresenter >> initializePresenters [

	list1 := self newList.
	list2 := self newList.
	list3 := self instantiate: SpFilteringListPresenter.
	label := self newLabel.
	multiLabel := self newLabel.

	list1
		items: self class environment allClasses;
		actions: self list1MenuActions.
	list2
		items: self class environment allClasses;
		sortingBlock: [ :a :b | a asString size < b asString size ];
		beMultipleSelection.
	list3
		items: self class environment allClasses;
		itemFilter: [ :item :string | item asString includesSubstring: string ];
		displayIcon: [ :elem | self iconFor: elem ].
	label label: 'No selection'.
	multiLabel label: 'No multi selection (from list 2 only)'
]

{ #category : 'accessing' }
SpDemoListsPresenter >> label [
	^ label
]

{ #category : 'accessing' }
SpDemoListsPresenter >> list1 [
	^ list1
]

{ #category : 'menu' }
SpDemoListsPresenter >> list1MenuActions [

	^ SpActionGroup new
		addActionWith: [ :anItem | anItem
			name: 'Print in transcript';
			shortcutKey: $p meta;
			description: 'Print the selected class on Transcript';
			action: [ list1 selectedItem traceCr ] ];
		addActionWith: [ :anItem | anItem
			name: 'Browse';
			iconName: #open;
			action: [ list1 selectedItem browse ] ];
		addGroupWith: [ :aGroup | aGroup
			name: 'Print infos';
			beDisplayedAsSubMenu;
			addActionWith: [ :item | item
				name: 'Print number of methods';
				action: [ list1 selectedItem methods size traceCr ] ];
			addActionWith: [ :item | item
				name: 'Print number of variables';
				action: [ list1 selectedItem instanceVariables size traceCr ] ] ];
		addGroupWith: [ :aGroup | aGroup
			addActionWith: [ :anItem | anItem
				name: 'Item showing only if item a odd number of letters';
				actionEnabled: [ list1 selectedItem printString size odd ];
				action: [ list1 selectedItem traceCr ] ];
			addActionWith: [ :anItem | anItem
				name: 'Disabled in second group';
				actionEnabled: [ false ];
				action: [ list1 selectedItem traceCr ] ];
			addActionWith: [ :anItem | anItem
				name: 'Disabled if class begins with A';
				enabled: [ list1 selectedItem printString first ~= $A ];
				action: [ list1 selectedItem traceCr ] ] ];
			yourself
]

{ #category : 'accessing' }
SpDemoListsPresenter >> list2 [
	^ list2
]

{ #category : 'accessing' }
SpDemoListsPresenter >> list3 [
	^ list3
]

{ #category : 'accessing' }
SpDemoListsPresenter >> multiLabel [
	^ multiLabel
]
