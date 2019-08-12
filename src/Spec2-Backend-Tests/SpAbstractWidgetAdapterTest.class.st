Class {
	#name : #SpAbstractWidgetAdapterTest,
	#superclass : #SpAbstractAdapterTest,
	#category : #'Spec2-Backend-Tests'
}

{ #category : #testing }
SpAbstractWidgetAdapterTest class >> isAbstract [ 

	^ self name = #SpAbstractWidgetAdapterTest 
]

{ #category : #tests }
SpAbstractWidgetAdapterTest >> testChangePlaceholderTextUpdatesPresenter [

	presenter placeholder: 'some text'.
	
	self assert: self adapter placeHolderText equals: 'some text'
]

{ #category : #running }
SpAbstractWidgetAdapterTest >> testChangingHelpAffectTheWidget [
	
	presenter help: 'ALabel'.
	self assert: self adapter helpText equals: 'ALabel'
]

{ #category : #running }
SpAbstractWidgetAdapterTest >> testEnabledAffectWidget [
	
	presenter enabled: false.
	self deny: self adapter enabled
]

{ #category : #tests }
SpAbstractWidgetAdapterTest >> testPresenterPlaceholderIsSetInWidget [

	presenter placeholder: 'something'.
	self assert: self adapter placeHolderText equals: 'something'
]
