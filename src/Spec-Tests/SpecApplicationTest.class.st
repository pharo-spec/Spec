Class {
	#name : #SpecApplicationTest,
	#superclass : #TestCase,
	#instVars : [
		'application'
	],
	#category : #'Spec-Tests-Core-Base'
}

{ #category : #running }
SpecApplicationTest >> setUp [
	
	super setUp.
	application := MockApplication new
]

{ #category : #tests }
SpecApplicationTest >> testAdapterBindings [

	self assert: application adapterBindings class equals: SpecStubAdapterBindings.
	application useBackend: #Morphic.
	self assert: application adapterBindings class equals: MorphicAdapterBindings
	
]

{ #category : #tests }
SpecApplicationTest >> testIsPresenter [

	self deny: application isPresenter 
]

{ #category : #tests }
SpecApplicationTest >> testNewPresenter [
	| presenter |

	presenter := application newPresenter: ButtonPresenter.
	self assert: presenter application equals: application
]

{ #category : #tests }
SpecApplicationTest >> testOpenWithSpecLayout [
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
SpecApplicationTest >> testUseBackend [

	self assert: application backend name equals: #Mock.
	application useBackend: #Morphic.
	self assert: application backend name equals: #Morphic
]
