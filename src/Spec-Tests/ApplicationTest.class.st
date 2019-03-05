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
ApplicationTest >> testActiveApplication [
	| presenter otherPresenter |

	application useBackend: #Morphic. "I need the application to be a morphic application 
	here, to test properly"
	presenter := application newPresenter: ButtonPresenter.
	[ presenter openWithSpec. 
	  5 milliSeconds wait.
	  self assert: SpecApplication activeApplication equals: application.
	  "test a new presenter opened in the context of ActiveApplication opens in same 
	   application."
	  otherPresenter := ButtonPresenter new.
	  self assert: otherPresenter application equals: application ]
	ensure: [ 
		presenter delete ].
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
ApplicationTest >> testNewPresenter [
	| presenter |

	presenter := application newPresenter: ButtonPresenter.
	self assert: presenter application equals: application
]

{ #category : #tests }
ApplicationTest >> testOpenWithSpecLayout [
	| window |

	window := application 
		open: ButtonPresenter new 
		withSpecLayout: ButtonPresenter defaultSpec. 

	self assert: window notNil.
	self assert: window isWindowPresenter.
	self flag: #TODO. "No idea what can I ask here yet, but probable something like: 
	application windows last = window ?
	"
]

{ #category : #tests }
ApplicationTest >> testUseBackend [

	self assert: application backend name equals: #Mock.
	application useBackend: #Morphic.
	self assert: application backend name equals: #Morphic
]
