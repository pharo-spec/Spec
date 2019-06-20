Class {
	#name : #SpToolBarPresenterTest,
	#superclass : #SpTestCase,
	#category : #'Spec-Tests-Core-Widgets'
}

{ #category : #running }
SpToolBarPresenterTest >> classToTest [

	^ SpToolBarPresenter
]

{ #category : #private }
SpToolBarPresenterTest >> newToolbarItem [
	
	^ ToolBarButton new
]

{ #category : #tests }
SpToolBarPresenterTest >> testAddItem [

	presenter addItem: ToolBarButton new.
	self assert: presenter items size equals: 1
]

{ #category : #tests }
SpToolBarPresenterTest >> testDisplayMode [

	presenter beBoth.
	self assert: presenter isDisplayModeBoth.
	presenter beIcons.
	self assert: presenter isDisplayModeIcons.	
	presenter beText.
	self assert: presenter isDisplayModeText
	
]

{ #category : #tests }
SpToolBarPresenterTest >> testIsEmpty [ 

	self assert: presenter isEmpty.
	presenter addItem: ToolBarButton new.
	self deny: presenter isEmpty
]
