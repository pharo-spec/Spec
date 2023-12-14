Class {
	#name : 'SpMorphicAllItemsStrategy',
	#superclass : 'FTAllItemsStrategy',
	#category : 'Spec2-Adapters-Morphic-Table',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Table'
}

{ #category : 'accessing' }
SpMorphicAllItemsStrategy >> isMatching: anItem [

	^ dataSource model 
		performSearch: anItem data 
		matching: pattern
]
