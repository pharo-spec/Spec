Class {
	#name : 'SpMenuBarPresenterTest',
	#superclass : 'SpMenuPresenterTest',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'accessing' }
SpMenuBarPresenterTest >> classToTest [
	^ SpMenuBarPresenter
]

{ #category : 'tests' }
SpMenuBarPresenterTest >> testFillWith [

	| menuCommandGroup menuBarCommandGroup menuBarGroup command menuItem menu topMenu menuGroup |
	command := CmCommand new
		name: 'Test';
		context: presenter;
		asSpecCommand.
	menuCommandGroup := (CmCommandGroup named: 'Menu') asSpecGroup
		register: command;
		yourself.
	menuBarCommandGroup := (CmCommandGroup named: 'MenuBar') asSpecGroup
		beRoot;
		register: menuCommandGroup;
		yourself.
	presenter fillWith: menuBarCommandGroup.
	self assert: presenter menuGroups size equals: 1.
	menuBarGroup := presenter menuGroups first.
	self assert: menuBarGroup menuItems size equals: 1.
	topMenu := menuBarGroup menuItems first.
	self assert: topMenu name equals: 'Menu'.
	menu := topMenu subMenu.
	self assert: menu menuGroups size equals: 1.
	menuGroup := menu menuGroups first.
	self assert: menuGroup menuItems size equals: 1.
	menuItem := menuGroup menuItems first.
	self assert: menuItem name equals: 'Test'
]
