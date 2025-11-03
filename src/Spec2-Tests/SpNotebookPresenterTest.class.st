Class {
	#name : 'SpNotebookPresenterTest',
	#superclass : 'SpSpecTest',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'accessing' }
SpNotebookPresenterTest >> classToTest [
	^ SpNotebookPresenter
]

{ #category : 'accessing' }
SpNotebookPresenterTest >> mockPage [
	^ SpNotebookPage
		title: 'Mock'
		icon: (self iconNamed: #changeUpdate)
		provider: [ SpButtonPresenter new ]
]

{ #category : 'tests' }
SpNotebookPresenterTest >> testAddPage [
	self assertEmpty: presenter pages.
	presenter addPage: self mockPage.
	self assert: presenter pages size equals: 1
	
]

{ #category : 'tests' }
SpNotebookPresenterTest >> testPageAt [
	| page |
	presenter addPage: self mockPage.
	page := SpNotebookPage title: 'test' provider: [ SpButtonPresenter new ].
	presenter addPage: page.
	self assert: (presenter pageAt: 2) equals: page
]

{ #category : 'tests' }
SpNotebookPresenterTest >> testRemoveAfterSettingPagesWithAnArray [
	| page |
	
	page := SpNotebookPage title: 'test' provider: [ SpButtonPresenter new ].
	presenter pages: { 
	 	self mockPage.
		page } .
	self assert: presenter pages size equals: 2.
	presenter removePageAt: 1.
	self assertCollection: presenter pages hasSameElements: {page}
]

{ #category : 'tests' }
SpNotebookPresenterTest >> testRemoveAll [
	| page |
	
	presenter addPage: self mockPage.
	page := SpNotebookPage title: 'test' provider: [ SpButtonPresenter new ].
	presenter addPage: page.
	self assert: presenter pages size equals: 2.
	presenter removeAll.
	self assert: presenter pages size equals: 0
]

{ #category : 'tests' }
SpNotebookPresenterTest >> testRemoveAllCleansSelection [
	| page |
	
	presenter addPage: self mockPage.
	page := SpNotebookPage title: 'test' provider: [ SpButtonPresenter new ].
	presenter addPage: page.
	self assert: presenter pages size equals: 2.
	presenter selectPage: page.
	presenter removeAll.
	self assert: presenter pages size equals: 0.
	self assert: presenter selectedPage isNil
	
]

{ #category : 'tests' }
SpNotebookPresenterTest >> testRemoveAllDoesNotSelectsAnyPage [

	| page1 page2 selected |
	page1 := SpNotebookPage title: 'test 1' provider: [ 
		         selected := 1.
		         SpButtonPresenter new ].
	presenter addPage: page1.
	page2 := SpNotebookPage title: 'test 2' provider: [ 
		         selected := 2.
		         SpButtonPresenter new ].
	presenter addPage: page2.
	self assert: presenter pages size equals: 2.

	"it needs to be open"
	[ presenter open ] ensure: [ presenter withWindowDo: #close ].

	presenter selectPage: page1.
	presenter removeAll.
	self assert: presenter pages size equals: 0.
	self assert: presenter selectedPage isNil.
	self assert: selected equals: 1
]

{ #category : 'tests' }
SpNotebookPresenterTest >> testRemovePage [
	| page |
	presenter addPage: self mockPage.
	page := SpNotebookPage title: 'test' provider: [ SpButtonPresenter new ].
	presenter addPage: page.
	self assert: presenter pages size equals: 2.
	presenter removePage: page.
	self assert: presenter pages size equals: 1
]

{ #category : 'tests' }
SpNotebookPresenterTest >> testRemovePageAt [
	| page |
	presenter addPage: self mockPage.
	page := SpNotebookPage title: 'test' provider: [ SpButtonPresenter new ].
	presenter addPage: page.
	self assert: presenter pages size equals: 2.
	presenter removePageAt: 1.
	self assertCollection: presenter pages hasSameElements: {page}
]

{ #category : 'tests' }
SpNotebookPresenterTest >> testSelectAPageWillSetAnActivePresenter [
	| app mainPresenter notebookPresenter results |
	
	app := SpApplication new.
	
	mainPresenter := SpPresenter newApplication: app.
	mainPresenter layout: (SpBoxLayout new 
		add: (notebookPresenter := mainPresenter newNotebook);
		yourself).
		
	notebookPresenter addPage: (SpNotebookPage 
		title: 'Test 1' 
		provider: [ mainPresenter newLabel label: 'Added 1' ]).

	 notebookPresenter addPage: (SpNotebookPage 
		title: 'Test 2' 
		provider: [ mainPresenter newLabel label: 'Added 2' ]).	

	notebookPresenter whenSelectedPageChangedDo: [ :page |
		results add: page activePresenter isNotNil ].
	results := OrderedCollection new.
	[ 
		mainPresenter open.
		10 milliSeconds wait.
		notebookPresenter selectPageIndex: 2.
		10 milliSeconds wait.
		notebookPresenter selectPageIndex: 1.
		10 milliSeconds wait ] 
	ensure: [
		mainPresenter withWindowDo: [ :each | each close ] ].

	self assert: (notebookPresenter pages count: [ :each | each activePresenter isNotNil ]) equals: 2.
	self assert: results asArray equals: #(true true true)
]

{ #category : 'tests' }
SpNotebookPresenterTest >> testSelectPage [
	| mock mock2 |
	mock := self mockPage.
	mock2 := SpNotebookPage title: 'test' provider: [ SpButtonPresenter new ].
	presenter addPage: mock.
	presenter addPage: mock2.
	presenter selectPage: mock2.
	self assert: presenter selectedPage equals: mock2
]

{ #category : 'tests' }
SpNotebookPresenterTest >> testSelectPageIndex [
	| mock mock2 |
	mock := self mockPage.
	mock2 := SpNotebookPage title: 'test' provider: [ SpButtonPresenter new ].
	presenter addPage: mock.
	presenter addPage: mock2.
	presenter selectPageIndex: 2.
	self assert: presenter selectedPage equals: mock2
]

{ #category : 'tests' }
SpNotebookPresenterTest >> testWhenPagesChangedDo [
	| counter |
	counter := 0.
	self assertEmpty: presenter pages.
	presenter whenPagesChangedDo: [ counter := counter + 1 ].
	presenter addPage: self mockPage.
	self assert: counter equals: 1
]

{ #category : 'tests' }
SpNotebookPresenterTest >> testWhenSelectedPageChangedDo [
	| mock mock2 counter selected |
	
	counter := 0.
	mock := self mockPage.
	mock2 := SpNotebookPage title: 'test' provider: [ SpButtonPresenter new ].
	presenter whenSelectedPageChangedDo: [ :page | 
		selected := page.
		counter := counter + 1 ].
	presenter addPage: mock.
	presenter addPage: mock2.
	presenter selectPageIndex: 2.
	self assert: counter equals: 1.
	self assert: selected equals: mock2
]
