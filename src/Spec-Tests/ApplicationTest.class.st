Class {
	#name : #ApplicationTest,
	#superclass : #TestCase,
	#instVars : [
		'application'
	],
	#category : #'Spec-Tests-Core-Base'
}

{ #category : #running }
ApplicationTest >> setUp [
	
	super setUp.
	application := MockApplication new
]

{ #category : #tests }
ApplicationTest >> testAdapterBindings [

	self assert: application adapterBindings equals: SpecStubAdapterBindings.
	application useBackend: #Morphic.
	self assert: application adapterBindings equals: MorphicAdapterBindings
	
]

{ #category : #tests }
ApplicationTest >> testIsPresenter [

	self deny: application isPresenter 
]

{ #category : #tests }
ApplicationTest >> testUseBackend [

	self assert: application backend name equals: #Mock.
	application useBackend: #Morphic.
	self assert: application backend name equals: #Morphic
]
