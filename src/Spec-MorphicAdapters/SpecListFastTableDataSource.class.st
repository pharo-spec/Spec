Class {
	#name : #SpecListFastTableDataSource,
	#superclass : #FTDataSource,
	#instVars : [
		'model',
		'getListSelector',
		'getListElementSelector',
		'getIconSelector',
		'dropItemSelector',
		'wantsDropSelector'
	],
	#category : #'Spec-MorphicAdapters-List'
}

{ #category : #accessing }
SpecListFastTableDataSource >> cellColumn: column row: rowIndex [
	| displayValue cell |
	displayValue := column transform: (self model displayValueAt: rowIndex).
	cell := FTCellMorph new
		cellInset: 5;
		yourself.
	cell addMorphBack: displayValue asMorph.
	^ cell
]

{ #category : #accessing }
SpecListFastTableDataSource >> dragTransferType [
	^ self getListElementSelector
]

{ #category : #'drag and drop' }
SpecListFastTableDataSource >> dropElements: aCollection index: rowIndex [
	self dropItemSelector ifNil: [ ^ self ].
	self model 
		perform: self dropItemSelector 
		with: aCollection
		with: rowIndex
]

{ #category : #'accessing selectors' }
SpecListFastTableDataSource >> dropItemSelector [
	^ dropItemSelector 
]

{ #category : #'accessing selectors' }
SpecListFastTableDataSource >> dropItemSelector: aSelector [
	dropItemSelector := aSelector

]

{ #category : #accessing }
SpecListFastTableDataSource >> elementAt: rowIndex [

	^ self listModel at: rowIndex
]

{ #category : #accessing }
SpecListFastTableDataSource >> elements [
	^self model getList
]

{ #category : #'accessing selectors' }
SpecListFastTableDataSource >> getListElementSelector [
	^ getListElementSelector
]

{ #category : #'accessing selectors' }
SpecListFastTableDataSource >> getListElementSelector: anObject [
	getListElementSelector := anObject
]

{ #category : #'accessing selectors' }
SpecListFastTableDataSource >> getListSelector [
	^ getListSelector
]

{ #category : #'accessing selectors' }
SpecListFastTableDataSource >> getListSelector: anObject [
	getListSelector := anObject
]

{ #category : #accessing }
SpecListFastTableDataSource >> listModel [
	^ model model
]

{ #category : #accessing }
SpecListFastTableDataSource >> menuColumn: column row: rowIndex [
	| menu menuPresenter |
	menu := UIManager default newMenuIn: self table for: self model.
	menuPresenter := self model menu: menu shifted: false.
	^ menuPresenter
]

{ #category : #accessing }
SpecListFastTableDataSource >> model [
	^ model
]

{ #category : #accessing }
SpecListFastTableDataSource >> model: anObject [
	model := anObject
]

{ #category : #accessing }
SpecListFastTableDataSource >> newDataSourceMatching: aFTFilter [
	| newElements wrappedItem text newDataSource modelCopy |
	newElements := self elements select: [ :each | 
		wrappedItem := self model displayValueOf: each.
		table columns anySatisfy: [ :column | 
			text := column transform: wrappedItem.
			aFTFilter matches: text]].
	
	newDataSource := self copy.
	modelCopy := self model copy.
	modelCopy prepareForFilteredDataSourceWith: newElements.
	newDataSource model: modelCopy.
	
	^newDataSource
]

{ #category : #accessing }
SpecListFastTableDataSource >> numberOfRows [
	^ model
		ifNil: [ 0 ]
		ifNotNil: [ self listModel size ]
]

{ #category : #accessing }
SpecListFastTableDataSource >> searchText: aString [
	| search text result |
	aString isEmptyOrNil ifTrue: [ ^ #() ].
	result := OrderedCollection new.
	search := aString trimBoth asLowercase.
	1 to: self numberOfRows do: [ :rowIndex | 
		text := (self model displayValueAt: rowIndex) contents trimBoth asLowercase.
		(text beginsWith: search)
			ifTrue: [ result add: rowIndex ] ].
	^ result asArray
]

{ #category : #'drag and drop' }
SpecListFastTableDataSource >> transferFor: passenger from: aMorph [
    ^(self model transferFor: passenger from: self table) buildWithSpec
]

{ #category : #'drag and drop' }
SpecListFastTableDataSource >> wantsDropElements: aCollection type: type index: rowIndex [
	self dropItemSelector ifNil: [ ^ false ].
	self wantsDropSelector ifNil: [ ^ true ].
	^ self model 
		perform: self wantsDropSelector 
		with: aCollection
]

{ #category : #'accessing selectors' }
SpecListFastTableDataSource >> wantsDropSelector [
	^ wantsDropSelector
]

{ #category : #'accessing selectors' }
SpecListFastTableDataSource >> wantsDropSelector: aSelector [
	wantsDropSelector := aSelector
]
