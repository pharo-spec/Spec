"
I'm a LabelPresenter, made to add labels to spec components.

! SpLabelPresenter 
A label presenter displays smalls (or medium) amounts of text.

Examples:
> self example

NOTE: In the future, it should be possible to attach another widget to a label, but for now it is not implementes.
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

{ #category : #'Spec2-Deprecated' }
SpLabelPresenter >> emphasis [

	self deprecated: 'You need to use a style to affect enfasis (see #addStyle:).'.

	^ nil
]

{ #category : #'Spec2-Deprecated' }
SpLabelPresenter >> emphasis: anEmphasis [
	"accepts a symbol or an array of symbols: #bold, #italic, #underline, #narrow, #struck"

	self deprecated: 'You need to use a style to affect enfasis (see #addStyle:).'
]

{ #category : #initialization }
SpLabelPresenter >> initialize [
	super initialize.

	label := ''.
	self whenLabelChangedDo: [ self changed: #getText ]
]

{ #category : #api }
SpLabelPresenter >> label [
	^ label
]

{ #category : #api }
SpLabelPresenter >> label: aText [
	"Set the text of the label"

	label := aText
]

{ #category : #'Spec2-Deprecated' }
SpLabelPresenter >> labelHolder [
	self deprecated: 'Nobody should access directly to internals of Spec. Now this variable is not a value holder anymore.'
]

{ #category : #'api-events' }
SpLabelPresenter >> whenLabelChangedDo: aValuable [
	self property: #label whenChangedDo: aValuable
]
