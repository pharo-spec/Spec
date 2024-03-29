Class {
	#name : 'SpLayoutAdapterTest',
	#superclass : 'SpAbstractAdapterTest',
	#instVars : [
		'layout'
	],
	#category : 'Spec2-Backend-Tests-Layout',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Layout'
}

{ #category : 'testing' }
SpLayoutAdapterTest class >> isAbstract [

	^ self == SpLayoutAdapterTest
]

{ #category : 'accessing' }
SpLayoutAdapterTest >> classToTest [

	^ SpEmptyPresenter
]

{ #category : 'initialization' }
SpLayoutAdapterTest >> initializeTestedInstance [

	layout := self newLayout.
	presenter layout: layout
]

{ #category : 'accessing' }
SpLayoutAdapterTest >> newLayout [
	
	self subclassResponsibility
]

{ #category : 'tests' }
SpLayoutAdapterTest >> testEmptyLayoutHasEmptyAdapter [

	self assert: self adapter isEmpty
]
