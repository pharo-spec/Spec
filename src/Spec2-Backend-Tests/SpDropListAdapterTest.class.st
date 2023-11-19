Class {
	#name : 'SpDropListAdapterTest',
	#superclass : 'SpAbstractWidgetAdapterTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpDropListAdapterTest >> classToTest [

	^ SpDropListPresenter 
]

{ #category : 'initialization' }
SpDropListAdapterTest >> initializeTestedInstance [ 
	
	super initializeTestedInstance.
	presenter items: #(10 20 30).
]

{ #category : 'tests' }
SpDropListAdapterTest >> testAddingIconsShowTheIcon [
	#(pharo add book) do: [ :each | self presenter addItemLabeled: each do: [  ] icon: (self iconNamed: each) ].

	self presenter selectItem: #pharo.

	self assert: self adapter selectedIndexes equals: #(4).
	backendForTest assertIcon: self adapter displayedIcon equals: (self iconNamed: #pharo)
]

{ #category : 'tests' }
SpDropListAdapterTest >> testDoesNotShowIcons [

	backendForTest assertIcon: self adapter displayedIcon equals: nil. 
]

{ #category : 'tests' }
SpDropListAdapterTest >> testRemovingIconsAfterAddingThem [
	#(pharo add book) do: [ :each | self presenter addItemLabeled: each do: [  ] icon: (self iconNamed: each) ].

	self presenter selectItem: nil.
	self presenter model removeAll.

	#(pharo add book) do: [ :each | self presenter addItemLabeled: each do: [  ] icon: nil ].

	self assert: self adapter selectedIndexes equals: #(1).
	backendForTest assertIcon: self adapter displayedIcon equals: nil
]

{ #category : 'tests' }
SpDropListAdapterTest >> testResetingSelectionResetsSelection [

	"reseting selection before start does not has sense if we set startWithSelection 
	(the default) because a selection will be forced."
	self presenter startWithoutSelection.

	self presenter selectItem: 10.

	self presenter resetSelection.

	self assert: self presenter selectedItem equals: nil.
	self assert: self adapter selectedIndexes isEmpty
]

{ #category : 'tests' }
SpDropListAdapterTest >> testSelectingASecondElementSelectsIt [
	self presenter selectItem: 10.
	self presenter selectItem: 20.

	self assert: self presenter selectedItem equals: 20.
	self assert: self adapter selectedIndexes equals: #(2)
]

{ #category : 'tests' }
SpDropListAdapterTest >> testSelectingAnElementInWidgetUpdatePresenter [

	self adapter selectIndex: 2.

	self assert: self presenter selectedItem equals: 20.
	self assert: self adapter selectedIndexes equals: #(2).
	
]

{ #category : 'tests' }
SpDropListAdapterTest >> testSelectingAnElementSelectsIt [
	self presenter selectItem: 10.

	self assert: self presenter selectedItem equals: 10.
	self assert: self adapter selectedIndexes equals: #(1)
]

{ #category : 'tests' }
SpDropListAdapterTest >> testSelectionExecutesBlock [
	| selected |
	self presenter
		dropListItems:
			(#(10 20 30)
				collect: [ :e | 
					SpDropListItem
						on: e
						do: [ selected := e ] ]).

	self presenter selectItem: 20.
	self assert: selected equals: 20
]

{ #category : 'tests' }
SpDropListAdapterTest >> testSelectionStartsSelectingFirst [

	self assert: self presenter selectedItem equals: 10.
	self assert: self adapter selectedIndexes equals: #(1).
	
]

{ #category : 'tests' }
SpDropListAdapterTest >> testSettingNilResetsGeneratesEvent [
	| changed |
	self presenter selectItem: 10.
	self presenter whenSelectionChangedDo: [ changed := true ].
	self presenter selectItem: nil.
	self assert: changed
]

{ #category : 'tests' }
SpDropListAdapterTest >> testSettingNilResetsSelection [

	"reseting selection before start does not has sense if we set startWithSelection 
	(the default) because a selection will be forced."
	self presenter startWithoutSelection.

	self presenter selectItem: 10.
	self presenter selectItem: nil.

	self assert: self presenter selectedItem equals: nil.
	self assert: self adapter selectedIndexes isEmpty
]
