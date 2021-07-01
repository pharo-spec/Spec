Class {
	#name : #SpApplicationTest,
	#superclass : #TestCase,
	#instVars : [
		'application'
	],
	#category : #'Spec2-Tests-Core-Base'
}

{ #category : #running }
SpApplicationTest >> setUp [
	
	super setUp.
	application := SpMockApplication new
]

{ #category : #running }
SpApplicationTest >> tearDown [
	
	application close.
	super tearDown
]

{ #category : #tests }
SpApplicationTest >> testCloseDialogWindowRemovesItFromWindowCollection [
	| window |

	application := SpApplication new.
	window := (application newPresenter: SpButtonPresenter) openDialogWithSpec.
	window close.
	self deny: (application windows includes: window)
]

{ #category : #tests }
SpApplicationTest >> testCloseWindowRemovesItFromWindowCollection [
	| window |
	
	application := SpApplication new.
	window := (application newPresenter: SpButtonPresenter) openWithSpec.
	window close.
	self deny: (application windows includes: window)
]

{ #category : #tests }
SpApplicationTest >> testIsPresenter [

	self deny: application isPresenter 
]

{ #category : #tests }
SpApplicationTest >> testNewPresenter [
	| presenter |

	presenter := application newPresenter: SpButtonPresenter.
	self assert: presenter application equals: application
]

{ #category : #tests }
SpApplicationTest >> testOpenDialogWindowAddsItToWindowCollection [
	| window |
	window := (application newPresenter: SpButtonPresenter) openDialogWithSpec.
	
	self assert: (application windows includes: window)
]

{ #category : #tests }
SpApplicationTest >> testOpenWindowAddsItToWindowCollection [
	| window |
	window := (application newPresenter: SpButtonPresenter) openWithSpec.
	
	self assert: (application windows includes: window)
]

{ #category : #tests }
SpApplicationTest >> testUseBackend [

	self assert: application backend name equals: #Mock.
	application useBackend: #Morphic.
	self assert: application backend name equals: #Morphic
]
