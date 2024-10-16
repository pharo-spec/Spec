"
A morphic datasource for `SpListViewPresenter`, to be used on the `SpMorphicListViewAdapter`.
"
Class {
	#name : 'SpMorphicListViewDataSource',
	#superclass : 'SpMorphicListDataSource',
	#instVars : [
		'rowHeights'
	],
	#category : 'Spec2-Adapters-Morphic-ListView',
	#package : 'Spec2-Adapters-Morphic-ListView'
}

{ #category : 'accessing' }
SpMorphicListViewDataSource >> cellColumn: column row: rowIndex [
	| cell contentPresenter contentMorph |

	cell := FTCellMorph new.

	contentPresenter := self model setupAction value: self model.
	self model bindAction 
		value: contentPresenter
		value: (self elementAt: rowIndex).

	contentMorph := contentPresenter build.

	"register wor height"
	rowHeights at: rowIndex put: contentMorph height.

	^ cell addMorphBack: contentMorph
]

{ #category : 'initialization' }
SpMorphicListViewDataSource >> initialize [

	super initialize.
	rowHeights := Dictionary new
]

{ #category : 'accessing' }
SpMorphicListViewDataSource >> rowHeight: index [

	^ rowHeights 
		at: index 
		ifAbsent: [ super rowHeight: index ]
]
