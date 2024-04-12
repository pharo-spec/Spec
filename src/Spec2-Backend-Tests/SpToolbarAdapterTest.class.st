Class {
	#name : 'SpToolbarAdapterTest',
	#superclass : 'SpAbstractWidgetAdapterTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpToolbarAdapterTest >> classToTest [
	^ SpToolbarPresenter 
]

{ #category : 'initialization' }
SpToolbarAdapterTest >> initializeTestedInstance [
	presenter 

]

{ #category : 'tests' }
SpToolbarAdapterTest >> testAddLabelledButtonAddTheButton [
	presenter addItem: (SpToolbarButtonPresenter new
				label: 'a label';
				iconNamed: #abstract;
				action: [];
				yourself).
				
	self assert: (self adapter hasButtonWithLabel: 'a label').
	self assert: (self adapter numberOfItems) equals: 1
]
