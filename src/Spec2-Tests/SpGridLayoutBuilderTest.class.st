Class {
	#name : 'SpGridLayoutBuilderTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Tests-Layout',
	#package : 'Spec2-Tests',
	#tag : 'Layout'
}

{ #category : 'instance creation' }
SpGridLayoutBuilderTest >> newPresenters: nbPresesenters [

	^ (1 to: nbPresesenters)
		 collect: [ :index | SpPresenter new ] as: Array

]

{ #category : 'tests' }
SpGridLayoutBuilderTest >> testBuilderAddsElementsOnRaw [
	| layout presenters |
	
	presenters := self newPresenters: 3.
	layout := SpGridLayout build: [ :builder | 
		builder 
			add: presenters first;
			add: presenters second;
			add: presenters third ].
	
	self
		assert: (layout at: 1@1)
		equals: presenters first.
	self
		assert: (layout at: 2@1)
		equals: presenters second.
	self
		assert: (layout at: 3@1)
		equals: presenters third.
]

{ #category : 'tests' }
SpGridLayoutBuilderTest >> testBuilderCanAddElementsOnMultipleRaws [
	| layout presenters |
	
	presenters := self newPresenters: 5.
	layout := SpGridLayout build: [ :builder | 
		builder 
			add: presenters first;
			add: presenters second;
			nextRow;
			add: presenters third;
			nextRow;
			add: presenters fourth;
			add: presenters fifth ].
	
	self
		assert: (layout at: 1@1)
		equals: presenters first.
	self
		assert: (layout at: 2@1)
		equals: presenters second.
	self
		assert: (layout at: 1@2)
		equals: presenters third.
	self
		assert: (layout at: 1@3)
		equals: presenters fourth.
	self
		assert: (layout at: 2@3)
		equals: presenters fifth.
]

{ #category : 'tests' }
SpGridLayoutBuilderTest >> testNewBuilderReturnsGridLayout [
	| layout |
	layout := SpGridLayout build: [ :builder | ].
	
	self
		assert: layout class
		equals: SpGridLayout
		
]
