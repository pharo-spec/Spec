Class {
	#name : 'SpMorphicTreeColumnViewAdapter',
	#superclass : 'SpMorphicTreeTableAdapter',
	#category : 'Spec2-Adapters-Morphic-ListView',
	#package : 'Spec2-Adapters-Morphic-ListView'
}

{ #category : 'private - factory' }
SpMorphicTreeColumnViewAdapter >> newColumnFrom: aTableColumn [

	^ (SpMorphicColumnViewColumn on: aTableColumn)
		width: aTableColumn width;
		yourself
]

{ #category : 'private - factory' }
SpMorphicTreeColumnViewAdapter >> newDataSource [ 

	^ SpMorphicTreeColumnViewDataSource new
		model: self model; 
		rootItem: (self rootForItems: (self model roots ifNil: [ #() ]));
		childrenBlock: [ :data :item | self model childrenFor: data ];
		yourself
]

{ #category : 'api - selection' }
SpMorphicTreeColumnViewAdapter >> selectedRowPresenter [
	| item exposedRows |
	
	item := self presenter selectedItem.
	item ifNil: [ ^ nil ].
	exposedRows := self widget container submorphs 
		select: [ :each | each class = FTTableRowMorph ].
	^ exposedRows
		detect: [ :each | 	
			| morph |
			"FTTableRowMorph, 
			 FTIndentedCellMorph, 
			 last morph = our morph"
			morph := each submorphs first submorphs last.
			(morph valueOfProperty: #treeItemModel ifAbsent: []) = item ]
		ifFound: [ :aRow | aRow submorphs first submorphs last presenter ]
		ifNone: [ nil ] 
]

{ #category : 'api - selection' }
SpMorphicTreeColumnViewAdapter >> traversePresentersDo: aBlock excluding: aSet [
	| exposedRows |
	
	exposedRows := self widget container submorphs 
		select: [ :each | each class = FTTableRowMorph ].
	
	(exposedRows
		flatCollect: [ :each | 	
			"FTTableRowMorph, 
			 FTIndentedCellMorph, 
			 last morph = our morph"
			each submorphs first submorphs collect: #presenter ])
		do: [ :each | 
			each ifNotNil: [
				each 
					traversePresentersDo: aBlock 
					excluding: aSet ] ]
]
