"
I'm the adapter used to bridge a ToolBarToggleButton and its morphic representation.
"
Class {
	#name : #SpMorphicToolbarToggleButtonAdapter,
	#superclass : #SpMorphicToolbarButtonAdapter,
	#category : #'Spec2-Adapters-Morphic-Base'
}

{ #category : #factory }
SpMorphicToolbarToggleButtonAdapter >> buildWidget [
	| newWidget |

	newWidget := super buildWidget.
	self presenter whenToggledDo: [ 
		self buttonChanged ].
	
	^ newWidget
]

{ #category : #private }
SpMorphicToolbarToggleButtonAdapter >> buttonChanged [
	| state associated |
	
	state := self state.
	associated := self presenter associatedToggleButtons.
	state ifTrue: [ 
		associated do: [ :each | each state: false ] ].
	
	widget pressed: state
]

{ #category : #factory }
SpMorphicToolbarToggleButtonAdapter >> morphClass [ 

	^ SpToolbarToggleButtonMorph
]

{ #category : #factory }
SpMorphicToolbarToggleButtonAdapter >> newButton [

	^ super newButton
		action: #execute:
		yourself
]

{ #category : #'accessing - structure variables' }
SpMorphicToolbarToggleButtonAdapter >> state [

	^ self presenter isSelected
]
