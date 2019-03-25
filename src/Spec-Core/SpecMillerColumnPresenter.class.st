"
I am a miller columns widget, aka cascading lists.
I am composed of presenters flowing to the right.
Every time that one of my inner presenters is activated, I ""dive in"" that element, showing a new presenter for the activated element to the right of the current selection.

You have to set me:
 - presenterBlock: aBlock that receives a model as argument and returns a SpecMillerPresenter or compatible (read below)
 - a first presenter using either
    - setModel: with a model  that calculates the initial presenter using the presenter block if already available
    - setPresenter: with a SpecMillerPresenter or compatible (read below)


SpecMillerColumnPresenter works on SpecMillerPresenter or compatible objects.
All presenters inside this one should be polymorphic, defining:
 - whenActivatedDo:, an event that will invoke a valuable with a selection object (understanding #selectedObject)
"
Class {
	#name : #SpecMillerColumnPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'presenters',
		'newPresenterBlock'
	],
	#category : #'Spec-Core-Miller'
}

{ #category : #initialization }
SpecMillerColumnPresenter >> addPresenterFor: aModel [

	| newSubPresenter |
	newSubPresenter := self newPresenterFor: aModel.
	newSubPresenter whenActivatedDo: [ :selection | 
			self changeSelection: selection selectedItem from: newSubPresenter ].
	presenters add: newSubPresenter.

	newSubPresenter owner: self.
	
	self adapter ifNotNil: [ 
		self adapter add: newSubPresenter ].
]

{ #category : #initialization }
SpecMillerColumnPresenter >> changeSelection: selection from: aPresenter [

	| selectedPresenterIndex |
	selectedPresenterIndex := presenters indexOf: aPresenter.
	presenters copy withIndexDo: [ :presenter :index |
		index <= selectedPresenterIndex ifFalse: [ 
			presenters remove: presenter.
			self adapter remove: presenter ] ].
	self addPresenterFor: selection.
]

{ #category : #specs }
SpecMillerColumnPresenter >> defaultSpec [

	| layout |
	layout := SpecBoxLayout newHorizontal.
	presenters do: [ :each | layout add: each ].
	^ layout
]

{ #category : #initialization }
SpecMillerColumnPresenter >> initialize [

	super initialize.
	newPresenterBlock := [ :model | Error signal: 'should provide a new presenter block' ]
]

{ #category : #initialization }
SpecMillerColumnPresenter >> initializeWidgets [
	
	presenters := OrderedCollection new
]

{ #category : #initialization }
SpecMillerColumnPresenter >> newPresenterFor: aModel [

	^ newPresenterBlock value: aModel
]

{ #category : #accessing }
SpecMillerColumnPresenter >> presenterBlock: aBlockClosure [ 
	
	newPresenterBlock := aBlockClosure
]

{ #category : #initialization }
SpecMillerColumnPresenter >> retrieveSpec: aSelector [
	| layout |

	layout := self perform: aSelector.
	layout isSpecLayout ifTrue: [ 
		layout selector: aSelector ].
	^ layout
]
