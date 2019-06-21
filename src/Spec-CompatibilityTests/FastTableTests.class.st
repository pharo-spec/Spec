Class {
	#name : #FastTableTests,
	#superclass : #SpMorphicAdapterTestCase,
	#category : #'Spec-CompatibilityTests'
}

{ #category : #running }
FastTableTests >> classToTest [

	^ SpFastTablePresenter
]

{ #category : #running }
FastTableTests >> initializeTestedInstance [

	presenter
		numberOfColumns: 2;
		displayBlock: [ :item | { item . 42 . 1 } ];
		items: { 1 . 2 . 3 }
]

{ #category : #running }
FastTableTests >> testColumnsAreExplicitlySetEvenIfDisplayBlockContainsMoreItems [

	self assert: presenter columns size equals: 2
]
