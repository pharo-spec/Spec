Class {
	#name : 'SpToolbarPresenterTest',
	#superclass : 'SpSpecTest',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'accessing' }
SpToolbarPresenterTest >> classToTest [

	^ SpToolbarPresenter
]

{ #category : 'private' }
SpToolbarPresenterTest >> newToolbarItem [
	
	^ SpToolbarButtonPresenter new
]

{ #category : 'tests' }
SpToolbarPresenterTest >> testAddItem [

	presenter addItem: SpToolbarButtonPresenter new.
	self assert: presenter items size equals: 1
]

{ #category : 'tests' }
SpToolbarPresenterTest >> testAddItemPosition [
	| itemLeft itemRight |

	self assert: presenter items isEmpty.
	presenter addItem: (itemLeft := self newToolbarItem) position: SpToolbarItemPosition left.
	presenter addItem: (itemRight := self newToolbarItem) position: SpToolbarItemPosition right.

	self assertCollection: presenter leftItems hasSameElements: { itemLeft }.
	self assertCollection: presenter rightItems hasSameElements: { itemRight }
]

{ #category : 'tests' }
SpToolbarPresenterTest >> testDisplayMode [

	presenter beBoth.
	self assert: presenter isDisplayModeBoth.
	presenter beIcons.
	self assert: presenter isDisplayModeIcons.	
	presenter beText.
	self assert: presenter isDisplayModeText
	
]

{ #category : 'tests' }
SpToolbarPresenterTest >> testFillWith [

	| commandGroup command toolbarButton |
	command := CmCommand new
		name: 'Test';
		context: presenter;
		asSpecCommand.
	commandGroup := (CmCommandGroup named: 'ToolBar') asSpecGroup
		beRoot;
		register: command;
		yourself.
	presenter fillWith: commandGroup.
	self assert: presenter items size equals: 1.
	toolbarButton := presenter items first.
	self assert: toolbarButton label equals: 'Test'
]

{ #category : 'tests' }
SpToolbarPresenterTest >> testIsEmpty [ 

	self assert: presenter isEmpty.
	presenter addItem: SpToolbarButtonPresenter new.
	self deny: presenter isEmpty
]

{ #category : 'tests' }
SpToolbarPresenterTest >> testItems [ 
	| item |

	self assert: presenter items isEmpty.
	presenter addItem: (item := self newToolbarItem).

	self assertCollection: presenter leftItems hasSameElements: { item }
]
