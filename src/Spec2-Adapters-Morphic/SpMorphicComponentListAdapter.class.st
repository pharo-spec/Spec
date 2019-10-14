Class {
	#name : #SpMorphicComponentListAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#category : #'Spec2-Adapters-Morphic-List'
}

{ #category : #factory }
SpMorphicComponentListAdapter >> buildWidget [

	widget := FTTableMorph new
		dataSource: self newDataSource;
		hideColumnHeaders;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		setBalloonText: self help;
		onAnnouncement: FTSelectionChanged send: #selectionChanged: to: self;
		onAnnouncement: FTStrongSelectionChanged send: #strongSelectionChanged: to: self;
		yourself.
		
	self presenter whenPresentersChangedDo: [ widget refresh ].
	self refreshWidgetSelection.
	self presenter whenSelectionChangedDo: [ self refreshWidgetSelection ].
	
	
	"widget connectSelectedRowsChanged: [ 
		self backendUpdatingDo: [  
			self presenter selection selectIndexes: self innerWidget selectedIndexes ] ]."
	
	^ widget
]

{ #category : #accessing }
SpMorphicComponentListAdapter >> children [

	^ self rows collect: [ :row | | cell | 
		cell := row submorphs first.
		cell submorphs first ]
]

{ #category : #factory }
SpMorphicComponentListAdapter >> newDataSource [
	
	^ SpComponentListFastTableDataSource new
		model: self presenter;
		yourself
]

{ #category : #factory }
SpMorphicComponentListAdapter >> refreshWidgetSelection [
	| rowIndexes |

	rowIndexes := self presenter selection selectedIndexes.
	rowIndexes = self widget selectedIndexes ifTrue: [ ^ self ].
	rowIndexes isEmpty
		ifTrue: [ self widget basicSelectIndexes: #() ]
		ifFalse: [ self widget basicSelectIndexes: rowIndexes ].
	^ self widget refresh
]

{ #category : #accessing }
SpMorphicComponentListAdapter >> rows [

	| tableContainer |
	tableContainer := self widget submorphs first.
	^ tableContainer submorphs
]

{ #category : #accessing }
SpMorphicComponentListAdapter >> selectIndex: aNumber [ 
	
	(aNumber = 0 and: [ widget selectedIndexes isEmpty ]) ifTrue: [ ^ self ].	
	(widget selectedIndexes includes: aNumber) ifTrue: [ ^ self ].
	widget selectIndex: aNumber
]

{ #category : #accessing }
SpMorphicComponentListAdapter >> selectedIndexes [

	^ widget selectedIndexes
]

{ #category : #'event handling' }
SpMorphicComponentListAdapter >> selectionChanged: ann [
	| diff |
	
	self presenter selection isMultipleSelection ifTrue: [ 
		self presenter selection selectIndexes: (ann newSelectedIndexes reject: [ :e | e = 0 ]) ].
	self presenter selection isMultipleSelection ifFalse: [ 
		self presenter selection selectIndex: (ann newSelectedIndexes
			ifNotEmpty: [ :indexes | indexes first ]
			ifEmpty: [ 0 ]) ].
	diff := ann newSelectedIndexes difference: ann oldSelectedIndexes.
	(diff notEmpty and: [ self presenter activatesOnSingleClick ])
		ifTrue: [ self presenter doActivateAtIndex: diff last ].
	
	ann newSelectedIndexes ifNotEmpty: [ ^ self ].
	self presenter selection unselectAll
]

{ #category : #factory }
SpMorphicComponentListAdapter >> strongSelectionChanged: aFTStrongSelectionChanged [
	
	self presenter activatesOnDoubleClick ifFalse: [ ^ self ]. 	
	self presenter doubleClickAtIndex: aFTStrongSelectionChanged selectedIndex
]
