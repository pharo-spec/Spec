Class {
	#name : 'SpMillerColumnAdapterTest',
	#superclass : 'SpAbstractWidgetAdapterTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'private' }
SpMillerColumnAdapterTest >> addNullMillerPresenters: aNumber [

	aNumber timesRepeat: [ self presenter addPresenter: (SpNullMillerPresenter on: SpLabelPresenter new) ]
]

{ #category : 'accessing' }
SpMillerColumnAdapterTest >> classToTest [

	^ SpMillerColumnPresenter
]

{ #category : 'private' }
SpMillerColumnAdapterTest >> requireGtkMillerAdapter [

	(self adapter isKindOf: GtkMillerAdapter) ifFalse: [ self skip ]
]

{ #category : 'tests' }
SpMillerColumnAdapterTest >> testAddedPresenterIsStoredOnColumnWidget [

	| childWidget millerPresenter |
	self requireGtkMillerAdapter.
	millerPresenter := SpNullMillerPresenter on: SpLabelPresenter new.
	self presenter addPresenter: millerPresenter.
	childWidget := self adapter childrenWidgets first.
	self assert: childWidget data equals: millerPresenter
]

{ #category : 'tests' }
SpMillerColumnAdapterTest >> testAddingColumnsScrollsToLastLogicalStart [

	self requireGtkMillerAdapter.
	self addNullMillerPresenters: 3.
	self assert: self adapter visibleStart equals: self adapter maximumStart
]

{ #category : 'tests' }
SpMillerColumnAdapterTest >> testChangingHelpAffectTheWidget [

	"This test is not valid for non-widget presenters"
	^ self skip
]

{ #category : 'tests' }
SpMillerColumnAdapterTest >> testEmptyMillerListHasNoWidgets [

	self assert: self adapter childrenWidgets isEmpty
]

{ #category : 'tests' }
SpMillerColumnAdapterTest >> testEnabledAffectWidget [

	"This test is not valid for non-widget presenters"
	^ self skip
]

{ #category : 'tests' }
SpMillerColumnAdapterTest >> testManyPresentersShowManyWidgets [

	3 timesRepeat: [ self presenter addPresenter: (SpNullMillerPresenter on: SpLabelPresenter new).].
	self assert: self adapter childrenWidgets size equals: 3
]

{ #category : 'tests' }
SpMillerColumnAdapterTest >> testOnePresenterShowsOneWidget [

	self presenter addPresenter: (SpNullMillerPresenter on: SpLabelPresenter new).
	
	self assert: self adapter childrenWidgets size equals: 1
]

{ #category : 'tests' }
SpMillerColumnAdapterTest >> testRemoveAllKeepsOuterScrollerChild [

	self requireGtkMillerAdapter.
	self addNullMillerPresenters: 3.
	self adapter removeAll.
	self assert: self adapter childrenWidgets isEmpty.
	self assert: self adapter widget child equals: self adapter innerWidget.
	self assert: self adapter visibleStart equals: 0
]

{ #category : 'tests' }
SpMillerColumnAdapterTest >> testRemovingColumnsClampsVisibleStart [

	self requireGtkMillerAdapter.
	self addNullMillerPresenters: 4.
	self adapter selectPage: 3.
	self presenter resetTo: 2.
	self assert: self adapter visibleStart equals: self adapter maximumStart
]

{ #category : 'tests' }
SpMillerColumnAdapterTest >> testResettingMillerListRemovesWidgets [

	3 timesRepeat: [ self presenter addPresenter: (SpNullMillerPresenter on: SpLabelPresenter new).].
	
	self presenter resetTo: 0.
	self assert: self adapter childrenWidgets isEmpty
]

{ #category : 'tests' }
SpMillerColumnAdapterTest >> testSelectPageClampsToMaximumStart [

	self requireGtkMillerAdapter.
	self addNullMillerPresenters: 4.
	self adapter selectPage: 10.
	self assert: self adapter visibleStart equals: self adapter maximumStart
]

{ #category : 'tests' }
SpMillerColumnAdapterTest >> testSelectPageSetsLogicalStart [

	self requireGtkMillerAdapter.
	self addNullMillerPresenters: 4.
	self adapter selectPage: 2.
	self assert: self adapter visibleStart equals: 1
]

{ #category : 'tests' }
SpMillerColumnAdapterTest >> testViewportWidthCalculationUsesAvailablePagesBelowVisiblePages [

	self requireGtkMillerAdapter.
	self addNullMillerPresenters: 2.
	self assert: self adapter visibleCount equals: 2.
	self assert: (self adapter columnWidthForViewportWidth: 600) equals: 300
]

{ #category : 'tests' }
SpMillerColumnAdapterTest >> testViewportWidthCalculationUsesSingleAvailablePage [

	self requireGtkMillerAdapter.
	self addNullMillerPresenters: 1.
	self assert: self adapter visibleCount equals: 1.
	self assert: (self adapter columnWidthForViewportWidth: 600) equals: 600
]

{ #category : 'tests' }
SpMillerColumnAdapterTest >> testViewportWidthCalculationUsesVisiblePagesForOverflow [

	self requireGtkMillerAdapter.
	self addNullMillerPresenters: 3.
	self assert: self adapter visibleCount equals: 2.
	self assert: (self adapter columnWidthForViewportWidth: 600) equals: 300
]
