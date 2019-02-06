Class {
	#name : #FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies,
	#superclass : #FTDataSource,
	#instVars : [
		'model',
		'getListSelector',
		'getListElementSelector',
		'wrapSelector',
		'getIconSelector',
		'getMenuSelector',
		'dropItemSelector',
		'wantsDropSelector'
	],
	#category : #'Spec-MorphicAdapters-List'
}

{ #category : #accessing }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> cellColumn: column row: rowIndex [
	| object text icon |
	object := self elementAt: rowIndex.
	
	icon := self getIconSelector ifNotNil: [ :selector | 
		self model perform: selector with: object ].
	text := column transform: (self elementWrapped: object).
	
	^ self createCellText: text icon: icon.
]

{ #category : #private }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> createCellText: aString icon: anIcon [ 
	| text icon cell |
	text := aString.
	icon := anIcon.
	cell := FTCellMorph new
		cellInset: 5;
		yourself.
	icon
		ifNotNil:
			[ icon := icon asMorph.
			icon class = ImageMorph
				ifTrue: [ icon form: (icon form scaledToSize: 16 @ 16) ]
				ifFalse: [ icon bounds: (0 @ 0 corner: 16 @ 16) ].
			cell addMorphBack: icon ].
	cell addMorphBack: text asMorph.
	^ cell
]

{ #category : #accessing }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> dragTransferType [
	^ self getListElementSelector
]

{ #category : #'drag and drop' }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> dropElements: aCollection index: rowIndex [
	self dropItemSelector ifNil: [ ^ self ].
	self model 
		perform: self dropItemSelector 
		with: aCollection
		with: rowIndex
]

{ #category : #'accessing selectors' }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> dropItemSelector [
	^ dropItemSelector 
]

{ #category : #'accessing selectors' }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> dropItemSelector: aSelector [
	dropItemSelector := aSelector

]

{ #category : #accessing }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> elementAt: rowIndex [

	^ self listModel at: rowIndex
]

{ #category : #private }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> elementWrapped: object [
	^ self wrapSelector 
		ifNotNil: [ :selector | self model perform: selector with: object ] 
		ifNil: [ object ]
]

{ #category : #accessing }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> elements [
	^self model getList
]

{ #category : #'accessing selectors' }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> getIconSelector [
	^ getIconSelector
]

{ #category : #'accessing selectors' }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> getIconSelector: anObject [
	getIconSelector := anObject
]

{ #category : #'accessing selectors' }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> getListElementSelector [
	^ getListElementSelector
]

{ #category : #'accessing selectors' }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> getListElementSelector: anObject [
	getListElementSelector := anObject
]

{ #category : #'accessing selectors' }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> getListSelector [
	^ getListSelector
]

{ #category : #'accessing selectors' }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> getListSelector: anObject [
	getListSelector := anObject
]

{ #category : #'accessing selectors' }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> getMenuSelector [
	^ getMenuSelector
]

{ #category : #'accessing selectors' }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> getMenuSelector: anObject [
	getMenuSelector := anObject
]

{ #category : #accessing }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> listModel [
	^ model model
]

{ #category : #accessing }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> menuColumn: column row: rowIndex [
	| menu menuPresenter |
	self getMenuSelector ifNil: [ ^ nil ].
	
	menu := UIManager default newMenuIn: self table for: self model.
	menuPresenter := self getMenuSelector numArgs = 1
		ifTrue: [ self model perform: self getMenuSelector with: menu ]
		ifFalse: [ self model perform: self getMenuSelector with: menu with: false ].
	^ menuPresenter
]

{ #category : #accessing }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> model [
	^ model
]

{ #category : #accessing }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> model: anObject [
	model := anObject
]

{ #category : #accessing }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> newDataSourceMatching: aFTFilter [
	| newElements wrappedItem text newDataSource modelCopy |
	newElements := self elements select: [ :each | 
		wrappedItem := self elementWrapped: each.
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
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> numberOfRows [
	^ model
		ifNil: [ 0 ]
		ifNotNil: [ self listModel size ]
]

{ #category : #accessing }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> searchText: aString [
	| search text result |
	aString isEmptyOrNil ifTrue: [ ^ #() ].
	result := OrderedCollection new.
	search := aString trimBoth asLowercase.
	1 to: self numberOfRows do: [ :rowIndex | 
		text := (self elementWrapped: (self elementAt: rowIndex)) contents trimBoth asLowercase.
		(text beginsWith: search)
			ifTrue: [ result add: rowIndex ] ].
	^ result asArray
]

{ #category : #'drag and drop' }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> transferFor: passenger from: aMorph [
    ^(self model transferFor: passenger from: self table) buildWithSpec
]

{ #category : #'drag and drop' }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> wantsDropElements: aCollection type: type index: rowIndex [
	self dropItemSelector ifNil: [ ^ false ].
	self wantsDropSelector ifNil: [ ^ true ].
	^ self model 
		perform: self wantsDropSelector 
		with: aCollection
]

{ #category : #'accessing selectors' }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> wantsDropSelector [
	^ wantsDropSelector
]

{ #category : #'accessing selectors' }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> wantsDropSelector: aSelector [
	wantsDropSelector := aSelector
]

{ #category : #'accessing selectors' }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> wrapSelector [
	^ wrapSelector
]

{ #category : #'accessing selectors' }
FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies >> wrapSelector: anObject [
	wrapSelector := anObject
]
