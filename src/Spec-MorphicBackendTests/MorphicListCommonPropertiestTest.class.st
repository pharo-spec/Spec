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
MorphicListCommonPropertiestTest >> testDoubleClickActivatesRowInDoubleClickActivationMode [

	| activated |
	activated := false.
	self presenter activateOnDoubleClick.
	self presenter whenActivatedDo: [ activated := true ].
	
	self widget doubleClick: (MouseEvent new
		setPosition: 1@1;
		yourself).
	
	self assert: activated.
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

{ #category : #running }
MorphicListCommonPropertiestTest >> testSingleClickActivatesRowInSingleClickActivationMode [

	| activated |
	activated := false.
	self presenter activateOnSingleClick.
	self presenter whenActivatedDo: [ activated := true ].
	World doOneCycle.
	
	self widget mouseDown: (MouseEvent new
		setHand: HandMorph new;
		setPosition: self widget submorphs first submorphs first bounds center;
		yourself).
	
	self assert: activated.
]
