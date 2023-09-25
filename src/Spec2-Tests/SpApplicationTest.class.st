Class {
	#name : 'SpApplicationTest',
	#superclass : 'TestCase',
	#instVars : [
		'application'
	],
	#category : 'Spec2-Tests-Core-Base',
	#package : 'Spec2-Tests',
	#tag : 'Core-Base'
}

{ #category : 'running' }
SpApplicationTest >> setUp [
	
	super setUp.
	application := SpMockApplication new
]

{ #category : 'running' }
SpApplicationTest >> tearDown [

	application closeAllWindows.
	super tearDown
]

{ #category : 'tests' }
SpApplicationTest >> testCloseDialogWindowRemovesItFromWindowCollection [

	| window |
	application := SpApplication new.
	window := (application newPresenter: SpButtonPresenter) openDialog.
	window close.
	self deny: (application windows includes: window)
]

{ #category : 'tests' }
SpApplicationTest >> testCloseWindowRemovesItFromWindowCollection [

	| window |
	application := SpApplication new.
	window := (application newPresenter: SpButtonPresenter) open.
	window close.
	self deny: (application windows includes: window)
]

{ #category : 'tests' }
SpApplicationTest >> testIsPresenter [

	self deny: application isPresenter 
]

{ #category : 'tests' }
SpApplicationTest >> testNewPresenter [
	| presenter |

	presenter := application newPresenter: SpButtonPresenter.
	self assert: presenter application equals: application
]

{ #category : 'tests' }
SpApplicationTest >> testOpenDialogWindowAddsItToWindowCollection [

	| window |
	window := (application newPresenter: SpButtonPresenter) openDialog.

	self assert: (application windows includes: window)
]

{ #category : 'tests' }
SpApplicationTest >> testOpenWindowAddsItToWindowCollection [

	| window |
	window := (application newPresenter: SpButtonPresenter) open.

	self assert: (application windows includes: window)
]

{ #category : 'tests' }
SpApplicationTest >> testUseBackend [

	self assert: application backend name equals: #Mock.
	application useBackend: #Morphic.
	self assert: application backend name equals: #Morphic
]
