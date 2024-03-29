Class {
	#name : 'SpComponentListPresenterTest',
	#superclass : 'SpAbstractListPresenterTest',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'accessing' }
SpComponentListPresenterTest >> classToTest [
	^ SpComponentListPresenter
]

{ #category : 'tests - activation' }
SpComponentListPresenterTest >> testActivationOnDoubleClickShouldActivateOnDoubleClick [

	| activatedItem |
	activatedItem := nil.
	presenter
		activateOnDoubleClick;
		whenActivatedDo: [ :selection | activatedItem := selection selectedItem ].
	
	presenter doubleClickAtIndex: 1.
	
	self assert: activatedItem label equals: '10'.
]

{ #category : 'tests - activation' }
SpComponentListPresenterTest >> testActivationOnSingleClickShouldActivateOnClick [

	| activatedItem |
	activatedItem := nil.
	presenter
		activateOnSingleClick;
		whenActivatedDo: [ :selection | activatedItem := selection selectedItem ].
	
	presenter clickAtIndex: 1.
	
	self assert: activatedItem label equals: '10'.
]

{ #category : 'tests' }
SpComponentListPresenterTest >> testActivationWithTransformation [
	| activatedItem |

	activatedItem := nil.
	presenter
		activateOnSingleClick;
		whenActivatedDo: (SpActivationTransform
			activateDo: [ :selection | activatedItem := selection selectedItem ]
			transform: [ :selection | selection selectedItem label asInteger * 10 ]).
	
	presenter clickAtIndex: 1.
	
	self assert: activatedItem equals: 100
]

{ #category : 'tests' }
SpComponentListPresenterTest >> testAddNoPresenterToComponentListDoesNotRaiseEvent [
	| raised |
	
	raised := false.
	presenter whenPresentersChangedDo: [ raised := true ].
	self deny: raised
]

{ #category : 'tests' }
SpComponentListPresenterTest >> testAddPresenterToComponentListIsInPresenterCollection [
	| button |

	button := SpButtonPresenter new.
	presenter addPresenter: button.
	self assert: (presenter includes: button)
]

{ #category : 'tests' }
SpComponentListPresenterTest >> testAddPresenterToComponentListRaisesEvent [
	| button raised |
	raised := false.
	button := SpButtonPresenter new.
	presenter whenPresentersChangedDo: [ raised := true ].
	
	presenter addPresenter: button.
	
	self assert: raised
]

{ #category : 'tests' }
SpComponentListPresenterTest >> testAddPresenterToComponentListRaisesSingleEvent [
	| button raised |
	raised := 0.
	button := SpButtonPresenter new.
	presenter whenPresentersChangedDo: [ raised := raised + 1 ].
	
	presenter addPresenter: button.
	
	self assert: raised equals: 1
]

{ #category : 'tests' }
SpComponentListPresenterTest >> testAddPresenterToComponentListShouldNotBeEmpty [
	presenter addPresenter: SpButtonPresenter new.
	self deny: presenter isEmpty
]

{ #category : 'tests' }
SpComponentListPresenterTest >> testDisableActivationDuring [ 
	| activated |

	activated := false.
	presenter whenActivatedDo: [ activated := true ].
	
	self deny: activated.
	presenter disableActivationDuring: [ presenter clickAtIndex: 2 ].
	self deny: activated. "still not change"
	self assert: presenter selectedItem label equals: '20' "but the selection changed!"
]

{ #category : 'tests' }
SpComponentListPresenterTest >> testNewComponentListIsEmpty [

	self assertEmpty: self classToTest new
]

{ #category : 'tests' }
SpComponentListPresenterTest >> testReplaceItemList [
	| changed |

	changed := false.
	presenter whenModelChangedDo: [ changed := true ].
	presenter items: #(a b c).
	
	self 
		assert: (presenter model collection collect: #label)
		equals: #(a b c).
	self assert: changed
]

{ #category : 'tests' }
SpComponentListPresenterTest >> testSelectAll [

	presenter beSingleSelection.
	presenter selectAll.
	"in single mode selectAll has no effect"
	self assertEmpty: presenter selection selectedItems. 
	presenter beMultipleSelection.
	presenter selectAll.
	"but in multiple mode selectAll works"
	self 
		assert: (presenter selection selectedItems asArray collect: #label) 
		equals: #('10' '20' '30')
]

{ #category : 'tests' }
SpComponentListPresenterTest >> testSelectedItemsSortedByIndex [

	presenter beMultipleSelection.
	presenter 
		selectIndex: 3;
		selectIndex: 1.
	self 
		assert: (presenter selection selectedItems collect: #label as: Array)
		equals: #('30' '10'). 
	self 
		assert: (presenter selection selectedItemsSortedByIndex collect: #label as: Array)
		equals: #('10' '30')
]

{ #category : 'tests - smoke' }
SpComponentListPresenterTest >> testSetSortingBlockBeforeItems [
	| count |
	
	count := 0.
	presenter whenSortingBlockChangedDo: [ :sortFunction | count := count + 1 ].
	presenter sortingBlock: [ :each | each label asNumber ] ascending.
	presenter items: #(3 8 1 0).
	self assert: count equals: 1.
	self assert: (presenter model at: 1) label equals: '0'
]

{ #category : 'tests - smoke' }
SpComponentListPresenterTest >> testSortingBlock [
	| count |
	
	count := 0.
	presenter whenSortingBlockChangedDo: [ :sortFunction | count := count + 1 ].
	presenter items: #(3 8 1 0).
	presenter sortingBlock: [ :each | each label asNumber ] ascending.
	self assert: count equals: 1.
	self assert: (presenter model at: 1) label equals: '0'
]

{ #category : 'tests' }
SpComponentListPresenterTest >> testUnselectAll [

	presenter beMultipleSelection.
	presenter selectAll.
	self 
		assert: (presenter selection selectedItems collect: #label as: Array) 
		equals: #('10' '20' '30').
	presenter unselectAll.
	self assertEmpty: presenter selection selectedItems
]

{ #category : 'tests' }
SpComponentListPresenterTest >> testUpdateItemsKeepingSelection [ 
	| presenters |

	presenters := #($a $b $c) collect: #asPresenter.
	presenter items: presenters.
	presenter selectIndex: 3.
	presenter updateItemsKeepingSelection: (presenters copyWith: $d asPresenter).
	self assert: presenter selectedItem label equals: 'c'
]
