"
A presenter to display a toggle button in a `SpToolbarPresenter`.
A toggle button is a button that can be activated (toggled) or deactivated (untoggled).

"
Class {
	#name : #SpToolbarToggleButtonPresenter,
	#superclass : #SpToolbarButtonPresenter,
	#instVars : [
		'#selected => ObservableSlot',
		'#associatedToggleButtons'
	],
	#category : #'Spec2-Core-Widgets-Toolbar'
}

{ #category : #specs }
SpToolbarToggleButtonPresenter class >> adapterName [

	^ #ToolbarToggleButtonAdapter
]

{ #category : #documentation }
SpToolbarToggleButtonPresenter class >> documentFactoryMethodSelector [

	^ #newToolbarToggleButton
]

{ #category : #api }
SpToolbarToggleButtonPresenter >> associatedToggleButtons [

	^ associatedToggleButtons ifNil: [ #() ]
]

{ #category : #api }
SpToolbarToggleButtonPresenter >> associatedToggleButtons: aCollection [ 
	"Set the list of toggle buttons associated with this one.
	 By using this, you will be grouping together this toggle button along with the ones contained 
	 in `aCollection`.
	 You should NOT send this message to all associated toggle buttons, the first of them is enough."
	| allElements |
	
	"pass group to all members"	
	allElements := { self }, aCollection.
	allElements do: [ :each | 
		each basicAssociatedToggleButtons: allElements ].
	
	"self state: true."
	aCollection do: [ :each | each state: false ]
]

{ #category : #private }
SpToolbarToggleButtonPresenter >> basicAssociatedToggleButtons: aCollection [ 
	
	associatedToggleButtons := aCollection copyWithout: self
]

{ #category : #api }
SpToolbarToggleButtonPresenter >> beSelected [
	"Set the status of the button to 'selected' (toggled)"
	
	self setSelection: true
]

{ #category : #api }
SpToolbarToggleButtonPresenter >> beUnselected [
	"Set the status of the button to 'unselected' (untoggled)"

	self setSelection: false
]

{ #category : #execution }
SpToolbarToggleButtonPresenter >> execute: state [

	self setSelection: state.
	self action ifNil: [ ^ self ].
	self action 
		cull: state 
		cull: self
]

{ #category : #initialization }
SpToolbarToggleButtonPresenter >> initialize [

	super initialize.
	selected := false
]

{ #category : #testing }
SpToolbarToggleButtonPresenter >> isSelected [

	^ self state
]

{ #category : #api }
SpToolbarToggleButtonPresenter >> selected: aBoolean [

	self 
		deprecated: 'Use #state: instead.' 
		transformWith: '`@receiver selected: `@arg' -> '`@receiver state: `@arg'.  
	self setSelection: aBoolean
]

{ #category : #private }
SpToolbarToggleButtonPresenter >> setSelection: aBoolean [

	selected := aBoolean.
	self changed: #isSelected
]

{ #category : #api }
SpToolbarToggleButtonPresenter >> state [

	^ selected
]

{ #category : #api }
SpToolbarToggleButtonPresenter >> state: aBoolean [

	self setSelection: aBoolean
]

{ #category : #api }
SpToolbarToggleButtonPresenter >> toggle [
	"Toggles the status of the button"
	
	self setSelection: selected not
]

{ #category : #'api - events' }
SpToolbarToggleButtonPresenter >> whenActivatedDo: aBlock [
	"Inform when the button has been selected. 
	 `aBlock` receives zero arguments."

	self whenChangedDo: [ :newSelectedValue | 
		newSelectedValue ifTrue: [ aBlock value ] ]
]

{ #category : #private }
SpToolbarToggleButtonPresenter >> whenChangedDo: aBlock [
	"Only execute aBlock if old value is different from new value"

	self
		property: #selected
		whenChangedDo: [ :newSelectedValue :oldSelectedValue | 
			newSelectedValue = oldSelectedValue
				ifFalse: [ aBlock cull: newSelectedValue cull: oldSelectedValue ] ]
]

{ #category : #'api - events' }
SpToolbarToggleButtonPresenter >> whenDeactivatedDo: aBlock [
	"Inform when the button has been selected. 
	 `aBlock` receives zero arguments."

	self whenChangedDo: [ :newSelectedValue | 
		newSelectedValue ifFalse: [ aBlock value ] ]
]

{ #category : #'api - events' }
SpToolbarToggleButtonPresenter >> whenSelectedDo: aBlock [
	"Inform when the button has been selected. 
	 `aBlock` receives zero arguments."

	self 
		deprecated: 'Use #whenActivatedDo: instead.' 
		transformWith: '`@receiver whenSelectedDo: `@arg' -> '`@receiver whenActivatedDo: `@arg'.  

	self whenChangedDo: [ :newSelectedValue | 
		newSelectedValue ifTrue: [ aBlock value ] ]
]

{ #category : #'api - events' }
SpToolbarToggleButtonPresenter >> whenToggledDo: aBlock [ 
	"Inform when the button has been toggles. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #selected whenChangedDo: aBlock 
]

{ #category : #'api - events' }
SpToolbarToggleButtonPresenter >> whenUnselectedDo: aBlock [
	"Inform when the button has been unselected. 
	 `aBlock` receives zero arguments."

	self 
		deprecated: 'Use #whenDeactivatedDo: instead.' 
		transformWith: '`@receiver whenUnselectedDo: `@arg' -> '`@receiver whenDeactivatedDo: `@arg'.  

	self whenChangedDo: [ :newSelectedValue | 
		newSelectedValue ifFalse: [ aBlock value ] ]
]
