Class {
	#name : 'SpEasyColumnViewPresenterTest',
	#superclass : 'SpColumnViewPresenterTest',
	#category : 'Spec2-ListView-Tests',
	#package : 'Spec2-ListView-Tests'
}

{ #category : 'accessing' }
SpEasyColumnViewPresenterTest >> classToTest [

	^ SpEasyColumnViewPresenter
]

{ #category : 'initialization' }
SpEasyColumnViewPresenterTest >> initializeTestedInstance [

	presenter addColumn: (SpStringTableColumn 
		title: 'Test'
		evaluated: [ :anObject | anObject asString ])
]

{ #category : 'tests' }
SpEasyColumnViewPresenterTest >> testDisableActivationDuring [ 

	self skip
]

{ #category : 'tests' }
SpEasyColumnViewPresenterTest >> testEasyColumnViewAnswersItsColumns [

	presenter := SpEasyColumnViewPresenter new.
	presenter columns: { (SpStringTableColumn title: 'Name' evaluated: [ :each | each printString ]) }.
	self assert: (presenter columns collect: [ :each | each title ] as: Array) equals: #( 'Name' )
]

{ #category : 'tests - smoke' }
SpEasyColumnViewPresenterTest >> testSetSortingBlockBeforeItems [

	"this does not has sense in a column (or table) view."
	self skip
]

{ #category : 'tests - smoke' }
SpEasyColumnViewPresenterTest >> testSortingBlock [

	"this does not has sense in a column (or table) view."
	self skip
]
