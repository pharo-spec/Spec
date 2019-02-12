Class {
	#name : #MorphicColumnedListCommonPropertiestTest,
	#superclass : #MorphicAbstractListCommonPropertiestTest,
	#category : #'Spec-MorphicBackendTests'
}

{ #category : #running }
MorphicColumnedListCommonPropertiestTest >> classToTest [
	^ ColumnedListPresenter
]

{ #category : #tests }
MorphicColumnedListCommonPropertiestTest >> testListWithoutColumnsHasSingleColumn [

	self assert: self widget columns size equals: 1
]
