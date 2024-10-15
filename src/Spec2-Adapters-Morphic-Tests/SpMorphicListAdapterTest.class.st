Class {
	#name : 'SpMorphicListAdapterTest',
	#superclass : 'TestCase',
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
	presenter 
		open;
		withWindowDo: [ : w | w resize: (200 @ 400) ].
	self 
		assert: presenter scrollIndex
		equals: 1.
	
	presenter scrollToIndex: 50.
	
	self 
		assert: presenter scrollIndex > 1
		description: 'For now we only check if the scroller worked, the CI returns 39 but running the test interactively returns 38 without loading preferences'
]
