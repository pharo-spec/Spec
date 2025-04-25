Class {
	#name : 'SpComponentListDataSource',
	#superclass : 'FTDataSource',
	#instVars : [
		'model'
	],
	#category : 'Spec2-Adapters-Morphic-List',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'List'
}

{ #category : 'accessing' }
SpComponentListDataSource >> cellColumn: column row: rowIndex [
	| cell item |
	
	item := self elementAt: rowIndex.
	cell := FTCellMorph new
		cellInset: 5;
		yourself.
	cell addMorphBack: (self widgetFor: item).
	
	^ cell
]

{ #category : 'accessing' }
SpComponentListDataSource >> elementAt: rowIndex [

	^ self presenters at: rowIndex
]

{ #category : 'accessing' }
SpComponentListDataSource >> elements [

	^ self presenters
]

{ #category : 'accessing' }
SpComponentListDataSource >> headerColumn: column [

	column id ifNil: [ ^ nil ]. 
	^ FTCellMorph new 
		listCentering: #left;
		addMorph: column id asMorph asReadOnlyMorph;
		yourself
]

{ #category : 'accessing' }
SpComponentListDataSource >> menuColumn: column row: rowIndex [
	| menuPresenter |
	
	"apply actions"
	self model actions ifNotNil: [ :actions |
		menuPresenter := self model newMenu.
		menuPresenter fillWith: actions ].
	"apply context menu if there is one"
	self model contextMenu ifNotNil: [ :aContextMenu | 
		self model actions ifNotNil: [ 
			Error signal: 'You are using contextMenu: and actions: at the same time. Both mechanisms are mutually exclusive.' ].
		menuPresenter := aContextMenu ].

	^ SpBindings
		value: self model application adapterBindings
		during: [
			menuPresenter value ifNotNil: [ :aMenuOrBlock |
				aMenuOrBlock isMorph
					ifTrue: [ aMenuOrBlock ]
					ifFalse: [ aMenuOrBlock build ] ] ]
]

{ #category : 'accessing' }
SpComponentListDataSource >> model [
	^ model
]

{ #category : 'accessing' }
SpComponentListDataSource >> model: anObject [
	model := anObject
]

{ #category : 'accessing' }
SpComponentListDataSource >> newDataSourceMatching: aFTFilter [
	| newElements wrappedItem text newDataSource modelCopy |
	
	newElements := self elements select: [ :each | 
		wrappedItem := self model displayValueFor: each.
		table columns anySatisfy: [ :column | 
			text := column transform: wrappedItem.
			aFTFilter matches: text]].
	
	newDataSource := self copy.
	modelCopy := self model copy.
	modelCopy prepareForFilteredDataSourceWith: newElements.
	newDataSource model: modelCopy.
	
	^newDataSource
]

{ #category : 'accessing' }
SpComponentListDataSource >> numberOfRows [

	^ model
		ifNil: [ 0 ]
		ifNotNil: [ self presenters size ]
]

{ #category : 'accessing' }
SpComponentListDataSource >> presenters [

	^ self model presenters
]

{ #category : 'accessing' }
SpComponentListDataSource >> rowHeight: rowIndex [

	rowIndex = 0 ifTrue: [ ^ super rowHeight: rowIndex ].
	^ (self widgetFor: (self elementAt: rowIndex)) height
]

{ #category : 'drag and drop' }
SpComponentListDataSource >> transferFor: passenger from: aMorph [

	^ (self model adapter 
		transferFor: passenger 
		from: self table) 
		build
]

{ #category : 'private' }
SpComponentListDataSource >> widgetFor: aPresenter [

	| widget |
	aPresenter adapter ifNotNil: [ :adapter | ^ adapter widget ].
	widget := aPresenter build
		          vResizing: #shrinkWrap;
		          yourself.
	aPresenter adapter applyStyle: widget.

	^ widget
]
