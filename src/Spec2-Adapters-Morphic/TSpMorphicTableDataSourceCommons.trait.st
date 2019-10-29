Trait {
	#name : #TSpMorphicTableDataSourceCommons,
	#instVars : [
		'model'
	],
	#category : #'Spec2-Adapters-Morphic-Table'
}

{ #category : #accessing }
TSpMorphicTableDataSourceCommons >> headerColumn: column [
	| headerMorph |

	column id ifNil: [ ^ nil ].
	headerMorph := SpHeaderCellMorph new 
		addMorph: column id asMorph asReadOnlyMorph;
		yourself.
		
	column isSortable ifTrue: [ 
		headerMorph eventHandler: (MorphicEventHandler new 
			on: #click 
			send: #sortByColumn:event:morph:
			to: self
			withValue: column) ].

	^ headerMorph
]

{ #category : #accessing }
TSpMorphicTableDataSourceCommons >> menuColumn: column row: rowIndex [
	| menuPresenter |

	menuPresenter := self model contextMenu.
	menuPresenter ifNil: [ ^ nil ].
	^ SpBindings
		value: self model application adapterBindings
		during: [ menuPresenter value buildWithSpec ]
]

{ #category : #accessing }
TSpMorphicTableDataSourceCommons >> model [

	^ model
]

{ #category : #accessing }
TSpMorphicTableDataSourceCommons >> model: aTablePresenter [

	model := aTablePresenter
]

{ #category : #sorting }
TSpMorphicTableDataSourceCommons >> sortByColumn: aColumn event: anEvent morph: aMorph [

	aColumn sortDataSource: self
]
