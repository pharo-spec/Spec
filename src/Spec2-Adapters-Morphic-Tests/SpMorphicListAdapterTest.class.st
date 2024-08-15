Class {
	#name : 'SpMorphicListAdapterTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'Spec2-Adapters-Morphic-Tests',
	#package : 'Spec2-Adapters-Morphic-Tests'
}

{ #category : 'private' }
SpMorphicListAdapterTest >> configureList: aNumber [

	presenter := SpListPresenter new
		items: (1 to: aNumber);
		yourself.

]

{ #category : 'running' }
SpMorphicListAdapterTest >> tearDown [

	presenter delete.
	super tearDown.
]

{ #category : 'tests' }
SpMorphicListAdapterTest >> testScrollToIndexInvisibleScrollbars [

	self configureList: 5.
	presenter open.
	presenter scrollToIndex: 100.
	self 
		assert: presenter scrollIndex
		equals: 1.
]

{ #category : 'tests' }
SpMorphicListAdapterTest >> testScrollToIndexVisibleScrollbars [

	self configureList: 100.
	presenter open.
	self 
		assert: presenter scrollIndex
		equals: 1.
	
	presenter scrollToIndex: 50.
	
	self 
		assert: presenter scrollIndex 
		equals: 39.
		
	presenter scrollToIndex: 100.

	self 
		assert: presenter scrollIndex 
		equals: 89.
]
