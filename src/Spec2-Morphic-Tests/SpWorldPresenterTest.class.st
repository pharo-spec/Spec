Class {
	#name : 'SpWorldPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'application',
		'worldMorph'
	],
	#category : 'Spec2-Morphic-Tests-Core-Support',
	#package : 'Spec2-Morphic-Tests',
	#tag : 'Core-Support'
}

{ #category : 'running' }
SpWorldPresenterTest >> setUp [

	super setUp.
	worldMorph := SpTestWorldPresenter
		reset;
		currentWorld.
	worldMorph
		extent: 300 @ 400;
		borderWidth: 0;
		color: Color veryLightGray.
	application := SpNullApplication new
]

{ #category : 'running' }
SpWorldPresenterTest >> tearDown [

	worldMorph delete.
	super tearDown
]

{ #category : 'tests' }
SpWorldPresenterTest >> testOpenPresenterInWorldDisplayInFullWorld [
	| buttonPresenter |
	
	buttonPresenter := (application newPresenter: SpButtonPresenter)
		label: 'test'.
	
	(SpTestWorldPresenter presenter: buttonPresenter) open.
	
	self currentWorld addMorph: worldMorph.
	
	self
		assert: worldMorph submorphs first submorphs first extent
		equals: worldMorph extent - 8 "border"
]

{ #category : 'tests' }
SpWorldPresenterTest >> testOpenPresenterInWorldDisplayToolbarDoesNotHidePresenter [
	| windowPresenter worldPanel |
	windowPresenter := application
		newPresenter: SpTestPresenterWithToolbar.
		
	(SpTestWorldPresenter presenter: windowPresenter) open.
		
	worldPanel := worldMorph submorphs first.
	self
		assert:
			(worldPanel submorphs first bounds
				intersect: worldPanel submorphs second bounds)
				= (0 @ 0 extent: 0 @ 0)
		description: 'toolbar should not intersect with presenter when opening in world'
]

{ #category : 'tests' }
SpWorldPresenterTest >> testOpenPresenterInWorldRemoveExisitingMorphsInWorld [
	| buttonPresenter |
	worldMorph addMorph: CircleMorph new.
	buttonPresenter := (application newPresenter: SpButtonPresenter)
		label: 'testOpenPresenterInWorldRemoveExisitingMorphsInWorld'. 
	
	(SpTestWorldPresenter presenter: buttonPresenter) open.

	self deny: (worldMorph submorphs anySatisfy: [ :morph | morph class = CircleMorph ]).
	self assert: worldMorph submorphs size equals: 1.
	self assert: worldMorph submorphs first class equals: Morph
]
