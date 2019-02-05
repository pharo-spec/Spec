"
testing ListComposablePresenter
"
Class {
	#name : #ListPresenterTest,
	#superclass : #SpecTestCase,
	#category : #'Spec-Tests-Core-Widgets'
}

{ #category : #running }
ListPresenterTest >> classToTest [
	^ ListPresenter
]

{ #category : #running }
ListPresenterTest >> setUp [

	super setUp.
	testedInstance items: #(10 20 30).
]

{ #category : #'tests-activation' }
ListPresenterTest >> testActivationOnSingleClickShouldActivateOnClick [

	| activatedItem |
	activatedItem := nil.
	testedInstance
		activateOnSingleClick;
		whenActivatedDo: [ :item | activatedItem := item ].
	
	testedInstance clickAtIndex: 1.
	
	self assert: activatedItem equals: 10.
]

{ #category : #'tests-activation' }
ListPresenterTest >> testActivationOnSingleClickShouldNotActivateOnClickOutside [

	| activatedItem |
	activatedItem := nil.
	testedInstance
		activateOnSingleClick;
		whenActivatedDo: [ :item | activatedItem := item ].
	
	testedInstance clickAtIndex: 100.
	
	self assert: activatedItem equals: nil
]

{ #category : #'tests-activation' }
ListPresenterTest >> testActivationWithoutActivationBlockDoesNothing [

	| activatedItem |
	activatedItem := nil.
	testedInstance
		activateOnSingleClick.

	testedInstance clickAtIndex: 1.
	
	self assert: activatedItem equals: nil
]

{ #category : #'tests-doubleClick' }
ListPresenterTest >> testDoubleClickCallsDoubleClickAction [

	| doubleClickInvoked |
	doubleClickInvoked := false.

	window := testedInstance
		items: #(10 20 30);
		doubleClickAction: [ doubleClickInvoked := true ];
		openWithSpec.

	testedInstance doubleClickAtIndex: 2.
	
	self assert: doubleClickInvoked
]

{ #category : #'tests-doubleClick' }
ListPresenterTest >> testDoubleClickOutsideSelectionUnsetsSelectedIndex [
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.
	testedInstance doubleClickAtIndex: 4.
	self assert: testedInstance selection selectedIndex equals: 0
]

{ #category : #'tests-doubleClick' }
ListPresenterTest >> testDoubleClickOutsideSelectionUnsetsSelectedItem [
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.
	testedInstance doubleClickAtIndex: 4.
	self assert: testedInstance selection selectedItem equals: nil
]

{ #category : #'tests-doubleClick' }
ListPresenterTest >> testDoubleClickSelectsItem [
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.
	testedInstance doubleClickAtIndex: 2.
	self assert: testedInstance selection selectedIndex equals: 2
]

{ #category : #'tests-header' }
ListPresenterTest >> testHideHeaderTitleUnsetsTitle [

	testedInstance
		headerTitle: 'title';
		hideHeaderTitle.
	
	self deny: testedInstance hasHeaderTitle
]

{ #category : #tests }
ListPresenterTest >> testSelectAll [
	| items |
	items := #(#AAA #BBB #CCC).
	testedInstance items: items.
	testedInstance beMultipleSelection.
	self assertCollection: testedInstance selectedItems hasSameElements: #().
	testedInstance selectAll.
	self assertCollection: testedInstance selectedItems hasSameElements: items
]

{ #category : #'tests-header' }
ListPresenterTest >> testSetHeaderTitleSetsTitle [

	testedInstance headerTitle: 'title'.
	
	self assert: testedInstance hasHeaderTitle
]

{ #category : #'tests-smoke' }
ListPresenterTest >> testSmokeOpenEmptyTablePresenter [

	window := testedInstance openWithSpec
]

{ #category : #'tests-smoke' }
ListPresenterTest >> testSmokeOpenTablePresenterWithItemsButNoColumns [

	window := testedInstance
		items: #(1 2 3);
		openWithSpec.
]

{ #category : #tests }
ListPresenterTest >> testWhenListChanged [
	"Two stages list changed notification."

	50
		timesRepeat: [ | ok |
			ok := false.
			testedInstance := ListPresenter new.
			testedInstance
				items: #(1 2);
				whenListChanged: [ :aList | ok := aList = testedInstance listItems ];
				listItems;
				"Call listItems to set the cache"
				items: #(1 2 3).
			self assert: ok ]
]

{ #category : #tests }
ListPresenterTest >> testWhenListChangedOldContents [
	"access to old and new contents in whenListChanged."

	| oldL newL |
	oldL := #(1 2).
	newL := #(1 2 3).
	testedInstance items: oldL.
	testedInstance
		whenListChanged: [ :aList :anOldList | 
			self assert: oldL equals: anOldList.
			self assert: newL equals: aList ].
	testedInstance listItems.	"Call listItems to set the cache"
	testedInstance items: #(1 2 3)
]
