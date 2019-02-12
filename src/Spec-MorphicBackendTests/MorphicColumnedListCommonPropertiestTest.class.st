Class {
	#name : #MorphicColumnedListCommonPropertiestTest,
	#superclass : #MorphicAbstractListCommonPropertiestTest,
	#category : #'Spec-MorphicBackendTests'
}

{ #category : #running }
MorphicColumnedListCommonPropertiestTest >> classToTest [
	^ ColumnedListPresenter
]

{ #category : #running }
MorphicColumnedListCommonPropertiestTest >> setUpPresenter [

	super setUpPresenter.
	presenter addColumn: (StringTableColumn title: 'Number' evaluated: #yourself).
	
	"Hide headers. We will try to click the first element, and the header is an extra element."
	presenter hideColumnHeaders.
]

{ #category : #tests }
MorphicColumnedListCommonPropertiestTest >> testHideColumnHeadersInPresenterHidesThemInWidget [

	self presenter hideColumnHeaders.
	World doOneCycle.
	
	self assert: self widget container headerRow isNil
]

{ #category : #tests }
MorphicColumnedListCommonPropertiestTest >> testListWithoutColumnsHasSingleColumn [

	self assert: self widget columns size equals: 1
]

{ #category : #tests }
MorphicColumnedListCommonPropertiestTest >> testShowColumnHeadersInPresenterShowsThemInWidget [

	self presenter showColumnHeaders.
	World doOneCycle.
	
	self assert: self widget container headerRow notNil
]
