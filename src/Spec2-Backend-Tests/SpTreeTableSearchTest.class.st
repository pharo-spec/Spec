Class {
	#name : #SpTreeTableSearchTest,
	#superclass : #SpAbstractSearchTest,
	#category : #'Spec2-Backend-Tests'
}

{ #category : #accessing }
SpTreeTableSearchTest >> classToTest [

	^ SpTreeTablePresenter
]

{ #category : #running }
SpTreeTableSearchTest >> initializeTestedInstance [ 

	presenter roots: #(10 20 30).
]

{ #category : #tests }
SpTreeTableSearchTest >> testTypePerformsSearch [

	self presenter selection selectPath: #(1). "10"
	self adapter type: '2'. 
	self 
		assert: self presenter selection selectedPath
		equals: #(2) "20"
]
