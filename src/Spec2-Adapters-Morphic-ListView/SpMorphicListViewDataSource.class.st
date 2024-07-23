"
A morphic datasource for `SpListViewPresenter`, to be used on the `SpMorphicListViewAdapter`.
"
Class {
	#name : 'SpMorphicListViewDataSource',
	#superclass : 'SpMorphicListDataSource',
	#category : 'Spec2-Adapters-Morphic-ListView',
	#package : 'Spec2-Adapters-Morphic-ListView'
}

{ #category : 'accessing' }
SpMorphicListViewDataSource >> cellColumn: column row: rowIndex [
	| cell contentPresenter |

	cell := FTCellMorph new.

	contentPresenter := self model setupAction value: self model.
	self model bindAction 
		value: contentPresenter
		value: (self elementAt: rowIndex).

	^ cell addMorphBack: contentPresenter build
]
