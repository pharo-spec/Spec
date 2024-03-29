Class {
	#name : 'SpComponentListAdapterMultipleSelectionTest',
	#superclass : 'SpAbstractListAdapterMultipleSelectionTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpComponentListAdapterMultipleSelectionTest >> classToTest [

	^ SpComponentListPresenter
]

{ #category : 'tests - model-to-widget' }
SpComponentListAdapterMultipleSelectionTest >> testSelectPresenterItemSetsSelectedIndexInWidget [
	
	presenter selectItem: (presenter items at: 2).
	self assert: (self adapter selectedIndexes includes: 2)
]
