"
I test the Morphic adapter of `SpListViewPresenter`.
"
Class {
	#name : 'SpMorphicListViewAdapterTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Adapters-Morphic-Tests',
	#package : 'Spec2-Adapters-Morphic-Tests'
}

{ #category : 'tests' }
SpMorphicListViewAdapterTest >> testRowsCanHaveDifferentHeights [
	"The data source records the height of each row presenter, so the table must not force one height for all rows"

	| list table |
	list := SpListViewPresenter new
		        items: #( 1 2 );
		        setup: [ :aPresenter | aPresenter newLabel ];
		        bind: [ :label :each | label label: each printString ];
		        yourself.
	table := list build.
	self assert: table container class equals: FTTableContainerRowNotHomogeneousMorph
]
