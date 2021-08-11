Class {
	#name : #SpChooserPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'chooserPresenter'
	],
	#category : #'Spec2-Common-Widgets-Tests'
}

{ #category : #running }
SpChooserPresenterTest >> initializeChooser [

	chooserPresenter := SpChooserPresenter
		                    sourceItems: self items
		                    displayBlock: #name
]

{ #category : #running }
SpChooserPresenterTest >> items [

	^ RBBrowserEnvironment default allClasses
]

{ #category : #running }
SpChooserPresenterTest >> setUp [

	super setUp.
	self initializeChooser
]

{ #category : #tests }
SpChooserPresenterTest >> testAddAll [

	self assert: chooserPresenter sourceList unfilteredItems isNotEmpty.
	self assert: chooserPresenter targetList unfilteredItems isEmpty.
	chooserPresenter addAll.
	self assert: chooserPresenter sourceList unfilteredItems isEmpty.
	self assert: chooserPresenter targetList unfilteredItems isNotEmpty
]

{ #category : #tests }
SpChooserPresenterTest >> testAddItemUsingFilter [

chooserPresenter sourceList applyFilter: 'HashedCollection'.
	chooserPresenter addAll.
	self
		assert: chooserPresenter sourceList unfilteredItems size
		equals: self items size - 3.
	self
		assertCollection: chooserPresenter targetList unfilteredItems
		hasSameElements: { 
				FLHashedCollectionSerializationTest.
				FLLargeIdentityHashedCollection.
				HashedCollection }
]

{ #category : #tests }
SpChooserPresenterTest >> testAddSelected [

	self assert: chooserPresenter sourceList selectedItems isEmpty.
	chooserPresenter sourceList selectItem:
		chooserPresenter sourceList unfilteredItems first.
	chooserPresenter addSelected.
	self
		assert: chooserPresenter targetList unfilteredItems size
		equals: 1.
	self
		assert: chooserPresenter sourceList unfilteredItems size
		equals: self items size - 1
]

{ #category : #tests }
SpChooserPresenterTest >> testRemoveAll [

	chooserPresenter removeAll.
	self assert: chooserPresenter sourceList unfilteredItems isNotEmpty.
	self assert: chooserPresenter targetList unfilteredItems isEmpty
]

{ #category : #tests }
SpChooserPresenterTest >> testRemoveItemUsingFilter [

	chooserPresenter addAll.
	chooserPresenter targetList applyFilter: 'HashedCollection'.
	chooserPresenter removeAll.
	self
		assert: chooserPresenter targetList unfilteredItems size
		equals: self items size - 3.
	self
		assertCollection: chooserPresenter sourceList unfilteredItems
		hasSameElements: { 
				FLHashedCollectionSerializationTest.
				FLLargeIdentityHashedCollection.
				HashedCollection }
]

{ #category : #tests }
SpChooserPresenterTest >> testRemoveSelected [

	chooserPresenter addAll.
	chooserPresenter targetList selectItem:
		chooserPresenter targetList unfilteredItems first.
	chooserPresenter removeSelected.
	self
		assert: chooserPresenter sourceList unfilteredItems size
		equals: 1.
	self
		assert: chooserPresenter targetList unfilteredItems size
		equals: self items size - 1
]
