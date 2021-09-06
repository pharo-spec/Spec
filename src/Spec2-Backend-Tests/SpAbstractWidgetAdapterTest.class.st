Class {
	#name : #SpAbstractWidgetAdapterTest,
	#superclass : #SpAbstractAdapterTest,
	#category : #'Spec2-Backend-Tests-Base'
}

{ #category : #testing }
SpAbstractWidgetAdapterTest class >> isAbstract [ 

	^ self name = #SpAbstractWidgetAdapterTest 
]

{ #category : #tests }
SpAbstractWidgetAdapterTest >> testChangingHelpAffectTheWidget [
	
	presenter help: 'ALabel'.
	self assert: self adapter helpText equals: 'ALabel'
]

{ #category : #tests }
SpAbstractWidgetAdapterTest >> testEnabledAffectWidget [
	
	presenter enabled: false.
	self deny: self adapter enabled
]
