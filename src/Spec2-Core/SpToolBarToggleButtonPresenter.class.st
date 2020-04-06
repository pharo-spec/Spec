"
A toggle button which is either selected or unselected
"
Class {
	#name : #SpToolBarToggleButtonPresenter,
	#superclass : #SpToolBarButtonPresenter,
	#instVars : [
		'#selected => SpObservableSlot'
	],
	#category : #'Spec2-Core-Widgets-Toolbar'
}

{ #category : #specs }
SpToolBarToggleButtonPresenter class >> adapterName [

	^ #ToolBarToggleButtonAdapter
]

{ #category : #selection }
SpToolBarToggleButtonPresenter >> beSelected [
	
	self setSelection: true
]

{ #category : #selection }
SpToolBarToggleButtonPresenter >> beUnselected [
	
	self setSelection: false
]

{ #category : #execution }
SpToolBarToggleButtonPresenter >> execute: state [

	self setSelection: state.
	self action 
		cull: state 
		cull: self
]

{ #category : #initialization }
SpToolBarToggleButtonPresenter >> initialize [

	super initialize.
	selected := false
]

{ #category : #testing }
SpToolBarToggleButtonPresenter >> isSelected [

	^ selected
]

{ #category : #selection }
SpToolBarToggleButtonPresenter >> setSelection: aBoolean [

	selected := aBoolean.
	self changed: #isSelected
]
