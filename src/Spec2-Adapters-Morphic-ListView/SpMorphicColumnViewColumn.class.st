Class {
	#name : 'SpMorphicColumnViewColumn',
	#superclass : 'SpMorphicTableColumn',
	#category : 'Spec2-Adapters-Morphic-ListView',
	#package : 'Spec2-Adapters-Morphic-ListView'
}

{ #category : 'private' }
SpMorphicColumnViewColumn >> bindAction [

	^ self model bindAction
]

{ #category : 'testing' }
SpMorphicColumnViewColumn >> isExpandable [

	^ self model isExpand
]

{ #category : 'accessing' }
SpMorphicColumnViewColumn >> model: aColumnViewColumn [

	model := aColumnViewColumn
]

{ #category : 'private' }
SpMorphicColumnViewColumn >> setupAction [

	^ self model setupAction
]
