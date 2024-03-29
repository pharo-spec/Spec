Class {
	#name : 'SpComponentListAdapterSingleSelectionTest',
	#superclass : 'SpAbstractListAdapterSingleSelectionTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpComponentListAdapterSingleSelectionTest >> classToTest [

	^ SpComponentListPresenter
]

{ #category : 'tests - model-to-widget' }
SpComponentListAdapterSingleSelectionTest >> testSelectPresenterItemSetsSelectedIndexInWidget [
	
	presenter selectItem: (presenter items at: 2).
	self assert: (self adapter selectedIndexes includes: 2)
]
