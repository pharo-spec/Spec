Class {
	#name : #SpTreeTableAdapterMultiColumnTest,
	#superclass : #SpAbstractTreeTableAdapterTest,
	#category : #'Spec2-Backend-Tests-Base'
}

{ #category : #initialization }
SpTreeTableAdapterMultiColumnTest >> initializeTestedInstance [
	super initializeTestedInstance.
	presenter addColumn: (SpImageTableColumn title: 'Icon' evaluated: [ :x | self iconNamed: #add ])
]

{ #category : #tests }
SpTreeTableAdapterMultiColumnTest >> testAddingColumnUpdatesWidget [

	self presenter addColumn: (SpStringTableColumn title: 'Value' evaluated: #printString).
	
	self assert: self adapter columnCount equals: 3
]
