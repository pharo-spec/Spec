Class {
	#name : #MorphicListCommonPropertiestTest,
	#superclass : #MorphicAdapterTestCase,
	#category : #'Spec-MorphicBackendTests'
}

{ #category : #running }
MorphicListCommonPropertiestTest >> classToTest [
	^ ListPresenter
]

{ #category : #running }
MorphicListCommonPropertiestTest >> setUp [

	super setUp.

	window := presenter
		items: #(10 20 30);
		openWithSpec.
]

{ #category : #running }
MorphicListCommonPropertiestTest >> testRemoveHeaderTitleInPresenterRemovesColumnHeaderMorph [

	| tableContainer |
	self presenter headerTitle: 'test'.
	World doOneCycle.

	self presenter headerTitle: nil.
	World doOneCycle.

	tableContainer := self widget submorphs first.
	self assert: tableContainer submorphs size equals: 3
]

{ #category : #running }
MorphicListCommonPropertiestTest >> testSetColumnTitleInPresenterPutsColumnHeaderMorph [

	| tableContainer tableRowMorph cellMorph |
	self presenter headerTitle: 'test'.
	World doOneCycle.

	tableContainer := self widget submorphs first.
	tableRowMorph := tableContainer submorphs first.
	cellMorph := tableRowMorph submorphs first.
	self assert: cellMorph submorphs first contents equals: 'test'.
]

{ #category : #running }
MorphicListCommonPropertiestTest >> testSetColumnTitleInPresenterShowsThemInWidget [

	self presenter headerTitle: 'test'.
	
	self assert: self widget isShowColumnHeaders
]
