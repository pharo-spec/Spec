Class {
	#name : #ColumnedListCommonPropertiestTest,
	#superclass : #AbstractListCommonPropertiestTest,
	#category : #'Spec-BackendTests'
}

{ #category : #running }
ColumnedListCommonPropertiestTest >> classToTest [
	^ ColumnedListPresenter
]

{ #category : #running }
ColumnedListCommonPropertiestTest >> initializeTestedInstance [

	super initializeTestedInstance.
	presenter addColumn: (StringTableColumn title: 'Number' evaluated: #yourself).
	
	"Hide headers. We will try to click the first element, and the header is an extra element."
	presenter hideColumnHeaders.
]

{ #category : #tests }
ColumnedListCommonPropertiestTest >> testAddColumnInPresenterAddsItToWidget [

	| newColumn |
	newColumn := StringTableColumn title: 'Hex' evaluated: #hex.
	self presenter
		addColumn: newColumn.

	self assert: self widget columns last id equals: newColumn title
]

{ #category : #tests }
ColumnedListCommonPropertiestTest >> testHideColumnHeadersInPresenterHidesThemInWidget [

	self presenter hideColumnHeaders.
	
	self deny: self adapter isShowColumnHeaders  
]

{ #category : #tests }
ColumnedListCommonPropertiestTest >> testListWithoutColumnsHasSingleColumn [

	self assert: self widget columns size equals: 1
]

{ #category : #tests }
ColumnedListCommonPropertiestTest >> testShowColumnHeadersInPresenterShowsThemInWidget [

	SystemVersion current major = 7
		ifTrue: [
			"Test failing in Pharo7 due to a bug in FastTable"
			^ self skip ].

	self presenter showColumnHeaders.
	
	self assert: self adapter isShowColumnHeaders
]
