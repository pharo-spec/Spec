"
A label presenter displays smalls (or medium) amounts of text.

_NOTE: In the future, it should be possible to attach another widget to a label, but for now it is not implemented._
"
Class {
	#name : #SpLabelPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'#label => SpObservableSlot'
	],
	#category : #'Spec2-Core-Widgets'
}

{ #category : #specs }
SpLabelPresenter class >> adapterName [

	^ #LabelAdapter
]

{ #category : #example }
SpLabelPresenter class >> example [
	"This example opens a spec window with a label."

	^ SpLabelPresenter new
		label: 'Label example';
		openWithSpec.
]

{ #category : #specs }
SpLabelPresenter class >> title [

	^ 'Label presenter'
]

{ #category : #testing }
SpLabelPresenter >> canTakeKeyboardFocus [

	^ false
]

{ #category : #initialization }
SpLabelPresenter >> defaultColor [

	self flag: #TOREMOVE. "This needs to be removed"
	^ self theme textColor
]

{ #category : #initialization }
SpLabelPresenter >> initialize [
	super initialize.

	label := ''.
	self whenLabelChangedDo: [ self changed: #getText ]
]

{ #category : #api }
SpLabelPresenter >> label [
	"Answer the label to be displayed."

	^ label
]

{ #category : #api }
SpLabelPresenter >> label: aString [
	"Set the label to be displayed"

	label := aString
]

{ #category : #localization }
SpLabelPresenter >> localeChanged [

	super localeChanged.
	self forceUpdateSlot: #label
		
]

{ #category : #'api-events' }
SpLabelPresenter >> whenLabelChangedDo: aValuable [
	"Inform when label state has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #label whenChangedDo: aValuable
]
