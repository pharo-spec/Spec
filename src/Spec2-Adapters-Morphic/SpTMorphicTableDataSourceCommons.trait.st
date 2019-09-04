Trait {
	#name : #SpTMorphicTableDataSourceCommons,
	#instVars : [
		'model'
	],
	#category : #'Spec2-Adapters-Morphic-Table'
}

{ #category : #accessing }
SpTMorphicTableDataSourceCommons >> headerColumn: column [

	column id ifNil: [ ^ nil ].
	^ FTCellMorph new 
		listCentering: #left;
		addMorph: column id asMorph;
		yourself
]

{ #category : #accessing }
SpTMorphicTableDataSourceCommons >> menuColumn: column row: rowIndex [
	| menuPresenter |

	menuPresenter := self model contextMenu.
	menuPresenter ifNil: [ ^ nil ].
	^ SpBindings
		value: self model application adapterBindings
		during: [ menuPresenter value buildWithSpec ]
]

{ #category : #accessing }
SpTMorphicTableDataSourceCommons >> model [

	^ model
]

{ #category : #accessing }
SpTMorphicTableDataSourceCommons >> model: aTablePresenter [

	model := aTablePresenter
]
