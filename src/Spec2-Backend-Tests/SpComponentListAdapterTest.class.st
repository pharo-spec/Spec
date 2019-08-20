Class {
	#name : #SpComponentListAdapterTest,
	#superclass : #SpAbstractWidgetAdapterTest,
	#category : #'Spec2-Backend-Tests'
}

{ #category : #accessing }
SpComponentListAdapterTest >> classToTest [

	^ SpComponentListPresenter 
]

{ #category : #tests }
SpComponentListAdapterTest >> testAddPresenterAddsWidget [

	| button |
	button := SpButtonPresenter new.
	presenter addPresenter: button.
	
	self assert: self adapter children first equals: button adapter widget 
]

{ #category : #tests }
SpComponentListAdapterTest >> testEmptyPresenterHasEmptyAdapter [
	
	self assertEmpty: self adapter children
]
