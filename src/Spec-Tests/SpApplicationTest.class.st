Class {
	#name : #SpApplicationTest,
	#superclass : #TestCase,
	#instVars : [
		'application'
	],
	#category : #'Spec-Tests-Core-Base'
}

{ #category : #running }
SpApplicationTest >> setUp [
	
	super setUp.
	application := MockApplication new
]

{ #category : #running }
SpApplicationTest >> tearDown [
	
	application close.
	super tearDown
]

{ #category : #tests }
SpApplicationTest >> testAdapterBindings [

	self assert: application adapterBindings class equals: SpStubAdapterBindings.
	application useBackend: #Morphic.
	self assert: application adapterBindings class equals: MorphicAdapterBindings
	
]

{ #category : #tests }
SpApplicationTest >> testCloseDialogWindowRemovesItFromWindowCollection [
	| window |
	window := (application newPresenter: ButtonPresenter) openDialogWithSpec.
	window close.
	self deny: (application windows includes: window)
]

{ #category : #tests }
SpApplicationTest >> testCloseWindowRemovesItFromWindowCollection [
	| window |
	window := (application newPresenter: ButtonPresenter) openWithSpec.
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

	presenter := application newPresenter: ButtonPresenter.
	self assert: presenter application equals: application
]

{ #category : #tests }
SpApplicationTest >> testOpenDialogWindowAddsItToWindowCollection [
	| window |
	window := (application newPresenter: ButtonPresenter) openDialogWithSpec.
	
	self assert: (application windows includes: window)
]

{ #category : #tests }
SpApplicationTest >> testOpenDialogWindowWithDifferentApplicationDoesNotAddItToWindowCollection [
	| secondApplication presenterInSecondApplication windowsBefore |

	secondApplication := SpApplication new.
	presenterInSecondApplication := secondApplication newPresenter: ButtonPresenter.

	windowsBefore := application windows copy.

	self
		should: [ application openDialog: presenterInSecondApplication ]
		raise: SpInvalidApplicationError.
		
	self assert: application windows equals: windowsBefore
]

{ #category : #tests }
SpApplicationTest >> testOpenDialogWindowWithDifferentApplicationShouldFail [
	| secondApplication presenterInSecondApplication |

	secondApplication := SpApplication new.
	presenterInSecondApplication := secondApplication newPresenter: ButtonPresenter.

	self
		should: [ application openDialog: presenterInSecondApplication ]
		raise: SpInvalidApplicationError
]

{ #category : #tests }
SpApplicationTest >> testOpenWindowAddsItToWindowCollection [
	| window |
	window := (application newPresenter: ButtonPresenter) openWithSpec.
	
	self assert: (application windows includes: window)
]

{ #category : #tests }
SpApplicationTest >> testOpenWindowWithDifferentApplicationDoesNotAddItToWindowCollection [
	| secondApplication presenterInSecondApplication windowsBefore |

	secondApplication := SpApplication new.
	presenterInSecondApplication := secondApplication newPresenter: ButtonPresenter.

	windowsBefore := application windows copy.

	self should: [
		application 
			open: presenterInSecondApplication
			withSpecLayout: ButtonPresenter defaultSpec ] raise: SpInvalidApplicationError.
		
	self assert: application windows equals: windowsBefore
]

{ #category : #tests }
SpApplicationTest >> testOpenWindowWithDifferentApplicationShouldFail [
	| secondApplication presenterInSecondApplication |

	secondApplication := SpApplication new.
	presenterInSecondApplication := secondApplication newPresenter: ButtonPresenter.

	self
		should: [ application open: presenterInSecondApplication ]
		raise: SpInvalidApplicationError
]

{ #category : #tests }
SpApplicationTest >> testUseBackend [

	self assert: application backend name equals: #Mock.
	application useBackend: #Morphic.
	self assert: application backend name equals: #Morphic
]
