Class {
	#name : 'SpTreePresenterTest',
	#superclass : 'SpAbstractTreePresenterTest',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'accessing' }
SpTreePresenterTest >> classToTest [

	^ SpTreePresenter
]

{ #category : 'tests' }
SpTreePresenterTest >> testWhenSelectedItemChangedDoNotFiredIfWeSelectTheSameElementsInMultipleSelection [

	presenter beMultipleSelection.

	presenter selectPaths: #( #( 1 ) #( 2 1 ) ).

	presenter whenSelectedItemChangedDo: [ :item | self fail: 'We should not trigger this block if we set the same paths' ].

	presenter selectPaths: #( #( 1 ) #( 2 1 ) )
]

{ #category : 'tests' }
SpTreePresenterTest >> testWhenSelectedItemChangedDoNotFiredIfWeSelectTheSameElementsInSingleSelection [

	presenter beSingleSelection.

	presenter selectPath: #( 1 ).

	presenter whenSelectedItemChangedDo: [ :item | self fail: 'We should not trigger this block if we set the same paths' ].

	presenter selectPath: #( 1 )
]

{ #category : 'tests' }
SpTreePresenterTest >> testWhenSelectedItemChangedDoNotFiredIfWeSelectTheSameElementsWithDifferentCollectionInMultipleSelection [

	presenter beMultipleSelection.

	presenter selectPaths: #( #( 1 ) #( 2 1 ) ).

	presenter whenSelectedItemChangedDo: [ :item | self fail: 'We should not trigger this block if we set the same paths' ].

	presenter selectPaths: #( #( 1 ) #( 2 1 ) ) asOrderedCollection
]

{ #category : 'tests' }
SpTreePresenterTest >> testWhenSelectedItemChangedDoNotFiredIfWeSelectTheSameElementsWithDifferentCollectionInSingleSelection [

	presenter beSingleSelection.

	presenter selectPath: #( 1 ).

	presenter whenSelectedItemChangedDo: [ :item | self fail: 'We should not trigger this block if we set the same paths' ].

	presenter selectPath: #( 1 ) asOrderedCollection
]
