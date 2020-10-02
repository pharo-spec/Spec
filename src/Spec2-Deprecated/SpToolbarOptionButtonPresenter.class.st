"
An option button
"
Class {
	#name : #SpToolbarOptionButtonPresenter,
	#superclass : #SpToolbarToggleButtonPresenter,
	#instVars : [
		'buttonGroup'
	],
	#category : #'Spec2-Deprecated-Replaced'
}

{ #category : #specs }
SpToolbarOptionButtonPresenter class >> adapterName [

	^ #ToolbarOptionAdapter
]

{ #category : #accessing }
SpToolbarOptionButtonPresenter >> buttonGroup: anITOptionButtonGroup [ 
	
	buttonGroup := anITOptionButtonGroup
]

{ #category : #execution }
SpToolbarOptionButtonPresenter >> execute: state [

	buttonGroup unselectAll.
	self beSelected.
	self action cull: state cull: self
]
