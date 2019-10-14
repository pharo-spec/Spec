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
SpMorphicComponentListAdapter >> selectedIndexes [

	^ widget selectedIndexes
]
