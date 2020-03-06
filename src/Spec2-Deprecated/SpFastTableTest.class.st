Class {
	#name : #SpFastTableTest,
	#superclass : #SpMorphicAdapterTestCase,
	#category : #'Spec2-Deprecated-Tests'
}

{ #category : #'Spec2-Deprecated' }
SpFastTableTest >> classToTest [

	^ SpFastTablePresenter
]

{ #category : #'Spec2-Deprecated' }
SpFastTableTest >> initializeTestedInstance [

	presenter
		numberOfColumns: 2;
		displayBlock: [ :item | { item . 42 . 1 } ];
		items: { 1 . 2 . 3 }
]

{ #category : #'Spec2-Deprecated' }
SpFastTableTest >> testColumnsAreExplicitlySetEvenIfDisplayBlockContainsMoreItems [

	self assert: presenter columns size equals: 2
]
