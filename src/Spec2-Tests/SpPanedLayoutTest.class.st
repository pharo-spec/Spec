Class {
	#name : 'SpPanedLayoutTest',
	#superclass : 'SpLayoutTest',
	#category : 'Spec2-Tests-Layout',
	#package : 'Spec2-Tests',
	#tag : 'Layout'
}

{ #category : 'testing' }
SpPanedLayoutTest class >> isAbstract [

	^ self == SpPanedLayoutTest
]

{ #category : 'running' }
SpPanedLayoutTest >> testElementsAreAddedInOrder [

	| second |
	layout first: SpButtonPresenter new.
	layout second: (second := SpButtonPresenter new).
	self assert: layout children last equals: second
]

{ #category : 'running' }
SpPanedLayoutTest >> testElementsAreAddedInOrderIndependentlyOfTheConfigurationOrder [
	| second |
	
	layout second: (second := SpButtonPresenter new).
	layout first: SpButtonPresenter new.
	self assert: layout children last equals: second
]

{ #category : 'running' }
SpPanedLayoutTest >> testElementsAreAddedInOrderWhenUsingAdd [

	| second |
	layout add: SpButtonPresenter new.
	layout add: (second := SpButtonPresenter new).
	self assert: layout children last equals: second
]

{ #category : 'running' }
SpPanedLayoutTest >> testElementsAreAddedInOrderWhenUsingAddWithConstraints [

	| second |
	layout add: SpButtonPresenter new withConstraints: [ :c ].
	layout add: (second := SpButtonPresenter new) withConstraints: [ :c ].
	self assert: layout children last equals: second
]

{ #category : 'running' }
SpPanedLayoutTest >> testLayoutWithOneFirstElementIsNotEmpty [

	layout first: SpButtonPresenter new.
	self deny: layout isEmpty
]

{ #category : 'running' }
SpPanedLayoutTest >> testLayoutWithOneSecondElementIsNotEmpty [

	layout second: SpButtonPresenter new.
	self deny: layout isEmpty
]

{ #category : 'running' }
SpPanedLayoutTest >> testRemoveFirstElementFromLayoutTakesItOut [

	| element |
	layout first: (element := SpButtonPresenter new).
	layout remove: element.
	self assert: layout isEmpty
]

{ #category : 'running' }
SpPanedLayoutTest >> testRemoveSecondElementFromLayoutTakesItOut [

	| element |
	layout second: (element := SpButtonPresenter new).
	layout remove: element.
	self assert: layout isEmpty
]

{ #category : 'running' }
SpPanedLayoutTest >> testReplaceFirst [

	| replacement |
	layout first: SpButtonPresenter new.
	layout replaceFirst: (replacement := SpButtonPresenter new).
	self assert: layout children first equals: replacement
]

{ #category : 'running' }
SpPanedLayoutTest >> testReplaceFirstElementKeepsSingleElement [

	| replacement |
	layout first: SpButtonPresenter new.
	layout first: (replacement := SpButtonPresenter new).
	self assert: layout children size equals: 1
]

{ #category : 'running' }
SpPanedLayoutTest >> testReplaceFirstElementReplacesIt [

	| replacement |
	layout first: SpButtonPresenter new.
	layout first: (replacement := SpButtonPresenter new).
	self assert: layout children first equals: replacement
]

{ #category : 'running' }
SpPanedLayoutTest >> testReplaceSecond [

	| replacement |
	layout first: SpButtonPresenter new.
	layout second: SpButtonPresenter new.
	layout replaceSecond: (replacement := SpButtonPresenter new).
	self assert: layout children second equals: replacement
]

{ #category : 'running' }
SpPanedLayoutTest >> testReplaceSecondElementKeepsSingleElement [

	| replacement |
	layout second: SpButtonPresenter new.
	layout second: (replacement := SpButtonPresenter new).
	self assert: layout children size equals: 1
]

{ #category : 'running' }
SpPanedLayoutTest >> testReplaceSecondElementReplacesIt [

	| replacement |
	layout second: SpButtonPresenter new.
	layout second: (replacement := SpButtonPresenter new).
	self assert: layout children first equals: replacement
]
