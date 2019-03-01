Class {
	#name : #DropListAdapterTest,
	#superclass : #AbstractAdapterTestCase,
	#category : #'Spec-BackendTests'
}

{ #category : #accessing }
DropListAdapterTest >> classToTest [

	^ DropListPresenter 
]

{ #category : #accessing }
DropListAdapterTest >> initializeTestedInstance [ 
	
	super initializeTestedInstance.
	presenter items: #(10 20 30).
]

{ #category : #accessing }
DropListAdapterTest >> testAddingAnItemSelectsItIfThereIsNone [

	self presenter addItemLabeled: 40 do: [].

	self assert: self presenter selectedItem equals: 40.
	self assert: self adapter selectedIndexes equals: #(4).
	
]

{ #category : #accessing }
DropListAdapterTest >> testResetingSelectionResetsSelection [

	self presenter selectedItem: 10.
	
	self presenter resetSelection.

	self assert: self presenter selectedItem equals: nil.
	self assert: self adapter selectedIndexes isEmpty.
	
]

{ #category : #accessing }
DropListAdapterTest >> testSelectingASecondElementSelectsIt [

	self presenter selectedItem: 10.
	self presenter selectedItem: 20.

	self assert: self presenter selectedItem equals: 20.
	self assert: self adapter selectedIndexes equals: #(2).
	
]

{ #category : #accessing }
DropListAdapterTest >> testSelectingAnElementInWidgetUpdatePresenter [

	self adapter selectIndex: 2.

	self assert: self presenter selectedItem equals: 20.
	self assert: self adapter selectedIndexes equals: #(2).
	
]

{ #category : #accessing }
DropListAdapterTest >> testSelectingAnElementSelectsIt [

	self presenter selectedItem: 10.

	self assert: self presenter selectedItem equals: 10.
	self assert: self adapter selectedIndexes equals: #(1).
	
]

{ #category : #accessing }
DropListAdapterTest >> testSelectionExecutesBlock [

	| selected |

	self presenter dropListItems: (#(10 20 30) 
		collect: [ :e | DropListItem on: e do: [ selected := e ] ]).

	self presenter selectedItem: 20.
	self assert: selected equals: 20	
]

{ #category : #accessing }
DropListAdapterTest >> testSelectionStartsEmpty [

	self assert: self presenter selectedItem equals: nil.
	self assert: self adapter selectedIndexes isEmpty.
	
]

{ #category : #accessing }
DropListAdapterTest >> testSettingNilResetsGeneratesEvent [

	| changed |
	
	self presenter selectedItem: 10.
	
	self presenter whenSelectionChanged: [ changed := true ].

	self presenter selectedItem: nil.

	self assert: changed
	
]

{ #category : #accessing }
DropListAdapterTest >> testSettingNilResetsSelection [

	self presenter selectedItem: 10.
	self presenter selectedItem: nil.

	self assert: self presenter selectedItem equals: nil.
	self assert: self adapter selectedIndexes isEmpty.
	
]
