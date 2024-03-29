Class {
	#name : 'SpTreeTableSearchTest',
	#superclass : 'SpAbstractSearchTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpTreeTableSearchTest >> classToTest [

	^ SpTreeTablePresenter
]

{ #category : 'initialization' }
SpTreeTableSearchTest >> initializeTestedInstance [ 

	presenter roots: #(10 20 30).
]

{ #category : 'tests' }
SpTreeTableSearchTest >> selectIndex: index [ 

	self presenter selection selectPath: { index }
]

{ #category : 'tests' }
SpTreeTableSearchTest >> selectedIndex [

	^ self presenter selection selectedPath 
		ifNotEmpty: #first
		ifEmpty: [ 0 ]
]
