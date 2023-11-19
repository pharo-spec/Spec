Class {
	#name : 'SpScrollableLayoutAdapterTest',
	#superclass : 'SpLayoutAdapterTest',
	#instVars : [
		'classFactory'
	],
	#category : 'Spec2-Backend-Tests-Layout',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Layout'
}

{ #category : 'accessing' }
SpScrollableLayoutAdapterTest >> newClassFactory [

	^ ClassFactoryForTestCase new
]

{ #category : 'accessing' }
SpScrollableLayoutAdapterTest >> newLayout [

	^ SpScrollableLayout new
]

{ #category : 'running' }
SpScrollableLayoutAdapterTest >> tearDown [

	classFactory ifNotNil: [ 
		classFactory cleanUp.
		classFactory := nil ].
	super tearDown
]

{ #category : 'tests' }
SpScrollableLayoutAdapterTest >> testAddTwiceReplacesChild [

	| first second |
	layout child: (first := SpButtonPresenter new).
	layout child: (second := SpButtonPresenter new).
	self assert: self adapter children first equals: second adapter widget
]

{ #category : 'tests' }
SpScrollableLayoutAdapterTest >> testAddTwiceSetsChildrenSingleTime [

	| first second |
	layout child: (first := SpButtonPresenter new).
	layout child: (second := SpButtonPresenter new).
	self assert: self adapter children size equals: 1
]

{ #category : 'tests' }
SpScrollableLayoutAdapterTest >> testAddWithSymbolWorks [

	| presenterClass |
	classFactory := self newClassFactory.
	presenterClass := classFactory make: [ :aBuilder |
		                  aBuilder
			                  superclass: SpPresenter;
			                  slotsFromString: 'textInput';
			                  package: self class package name ].

	presenter := presenterClass new.
	presenter layout: (SpScrollableLayout with: #textInput).
	presenter writeSlotNamed: #textInput value: presenter newTextInput.

	self openInstance.

	self assert: presenter adapter childWidget equals: (presenter readSlotNamed: #textInput) adapter widget
]

{ #category : 'tests' }
SpScrollableLayoutAdapterTest >> testLayoutWithChildIsNotEmpty [

	layout child: SpButtonPresenter new.
	self deny: self adapter isEmpty
]

{ #category : 'tests' }
SpScrollableLayoutAdapterTest >> testRemoveChildAddedAfterOpenRemovesFromAdapter [

	| element |
	layout child: (element := SpButtonPresenter new).
	self openInstance.
	
	layout remove: element.
	self assert: self adapter isEmpty
]

{ #category : 'tests' }
SpScrollableLayoutAdapterTest >> testRemoveChildElementRemovesFromAdapter [

	| element |
	layout child: (element := SpButtonPresenter new).
	layout remove: element.
	self assert: self adapter isEmpty
]
