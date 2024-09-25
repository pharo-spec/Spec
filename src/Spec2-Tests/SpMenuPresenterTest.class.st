Class {
	#name : 'SpMenuPresenterTest',
	#superclass : 'SpSmokeTest',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'accessing' }
SpMenuPresenterTest >> classToTest [
	^ SpMenuPresenter
]

{ #category : 'tests' }
SpMenuPresenterTest >> testFillWith [

	| menuCommandGroup  command menuItem menuGroup |
	command := CmCommand new
		name: 'Test';
		context: presenter;
		asSpecCommand.
	menuCommandGroup := (CmCommandGroup named: 'Menu') asSpecGroup
		beRoot;
		register: command;
		yourself.
	presenter fillWith: menuCommandGroup.
	self assert: presenter menuGroups size equals: 1.
	menuGroup := presenter menuGroups first.
	self assert: menuGroup menuItems size equals: 1.
	menuItem := menuGroup menuItems first.
	self assert: menuItem name equals: 'Test'
]

{ #category : 'tests' }
SpMenuPresenterTest >> testValue [ 

	self assert: presenter value equals: presenter
]
