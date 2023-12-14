"
A presenter to display a toggle button.
A toggle button is a button that can be activated (toggled) or deactivated (untoggled).

"
Class {
	#name : 'SpToggleButtonPresenter',
	#superclass : 'SpAbstractFormButtonPresenter',
	#instVars : [
		'#associatedToggleButtons',
		'#action => ObservableSlot',
		'#icon => ObservableSlot'
	],
	#category : 'Spec2-Core-Widgets',
	#package : 'Spec2-Core',
	#tag : 'Widgets'
}

{ #category : 'specs' }
SpToggleButtonPresenter class >> adapterName [
	
	^ #ToggleButtonAdapter
]

{ #category : 'documentation' }
SpToggleButtonPresenter class >> documentFactoryMethodSelector [

	^ #newToggleButton
]

{ #category : 'specs' }
SpToggleButtonPresenter class >> title [

	^ 'Toggle Button'
]

{ #category : 'api' }
SpToggleButtonPresenter >> action [ 
	"Answer the action to execute when button is pressed.
	 See `SpToggleButtonPresenter>>#action:`"
	
	^ action
]

{ #category : 'api' }
SpToggleButtonPresenter >> action: aBlock [
	"Set the action to execute when button is pressed. 
	 `aBlock` receives zero arguments."
	
	action := aBlock
]

{ #category : 'api' }
SpToggleButtonPresenter >> associatedToggleButtons [

	^ associatedToggleButtons ifNil: [ #() ]
]

{ #category : 'api' }
SpToggleButtonPresenter >> associatedToggleButtons: aCollection [ 
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

{ #category : 'private' }
SpToggleButtonPresenter >> basicAssociatedToggleButtons: aCollection [ 
	
	associatedToggleButtons := aCollection copyWithout: self
]

{ #category : 'api' }
SpToggleButtonPresenter >> icon [
	"Answer the icon (an instance of `Form`) to be shown with the button."

	^ icon
]

{ #category : 'api' }
SpToggleButtonPresenter >> icon: anIcon [
	"Set the icon (an instance of `Form`) to be shown with the button."

	icon := anIcon
]

{ #category : 'initialization' }
SpToggleButtonPresenter >> initialize [

	super initialize.
	action := [ ]
]

{ #category : 'api - events' }
SpToggleButtonPresenter >> whenIconChangedDo: aBlock [
	"Inform when icon property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #icon whenChangedDo: aBlock
]
