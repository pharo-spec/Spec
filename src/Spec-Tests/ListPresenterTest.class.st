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
	presenter items: #(10 20 30).
]

{ #category : #'tests-activation' }
ListPresenterTest >> testActivationOnDoubleClickShouldActivateOnDoubleClick [

	| activatedItem |
	activatedItem := nil.
	presenter
		activateOnDoubleClick;
		whenActivatedDo: [ :selection | activatedItem := selection selectedItem ].
	
	presenter doubleClickAtIndex: 1.
	
	self assert: activatedItem equals: 10.
]

{ #category : #'tests-activation' }
ListPresenterTest >> testActivationOnDoubleClickShouldNotActivateOnClick [

	| activatedItem |
	activatedItem := nil.
	presenter
		activateOnDoubleClick;
		whenActivatedDo: [ :selection  | activatedItem := selection selectionItem ].
	
	presenter clickAtIndex: 1.
	
	self assert: activatedItem equals: nil.
]

{ #category : #'tests-activation' }
ListPresenterTest >> testActivationOnSingleClickShouldActivateOnClick [

	| activatedItem |
	activatedItem := nil.
	presenter
		activateOnSingleClick;
		whenActivatedDo: [ :selection | activatedItem := selection selectedItem ].
	
	presenter clickAtIndex: 1.
	
	self assert: activatedItem equals: 10.
]

{ #category : #'tests-activation' }
ListPresenterTest >> testActivationOnSingleClickShouldNotActivateOnClickOutside [

	| activatedItem |
	activatedItem := nil.
	presenter
		activateOnSingleClick;
		whenActivatedDo: [ :selection | activatedItem := selection selectedIndex ].
	
	presenter clickAtIndex: 100.
	
	self assert: activatedItem equals: nil
]

{ #category : #'tests-activation' }
ListPresenterTest >> testActivationWithoutActivationBlockDoesNothing [

	| activatedItem |
	activatedItem := nil.
	presenter activateOnSingleClick.

	presenter clickAtIndex: 1.
	
	self assert: activatedItem equals: nil
]

{ #category : #'tests-header' }
ListPresenterTest >> testHideHeaderTitleUnsetsTitle [

	presenter
		headerTitle: 'title';
		hideHeaderTitle.
	
	self deny: presenter hasHeaderTitle
]

{ #category : #tests }
ListPresenterTest >> testSelectAll [
	| items |
	items := #(#AAA #BBB #CCC).
	presenter items: items.
	presenter beMultipleSelection.
	self assertCollection: presenter selectedItems hasSameElements: #().
	presenter selectAll.
	self assertCollection: presenter selectedItems hasSameElements: items
]

{ #category : #'tests-header' }
ListPresenterTest >> testSetHeaderTitleSetsTitle [

	presenter headerTitle: 'title'.
	
	self assert: presenter hasHeaderTitle
]

{ #category : #'tests-smoke' }
ListPresenterTest >> testSmokeOpenEmptyTablePresenter [

	window := presenter openWithSpec
]

{ #category : #'tests-smoke' }
ListPresenterTest >> testSmokeOpenTablePresenterWithItemsButNoColumns [

	window := presenter
		items: #(1 2 3);
		openWithSpec.
]
