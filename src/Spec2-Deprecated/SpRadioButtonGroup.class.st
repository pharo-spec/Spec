"
I am deprecated. 
Now the radio buttons are created knowing their friends.

I am a group for radio buttons which ensures that only one button is activated at the same time.

I collaborate with
- RadioButtonPresenter are usually the buttons I manage.
- ValueHolder to link buttons.

I provide the following methods
- addRadioButton: to add the button in my collection and link it at the other.
- buttons getter of my collection.
- default: activate a button when it is built.

todo
- canDeselectByClick
"
Class {
	#name : #SpRadioButtonGroup,
	#superclass : #Object,
	#instVars : [
		'buttons',
		'currentlyActivated',
		'canDeselectByClick'
	],
	#category : #'Spec2-Deprecated-Support'
}

{ #category : #'Spec2-Deprecated' }
SpRadioButtonGroup class >> isDeprecated [ 

	^ true
]

{ #category : #'Spec2-Deprecated' }
SpRadioButtonGroup >> addRadioButton: aButton [

	buttons do: [:b | 
		aButton whenActivatedDo: [ b privateSetState: false ].
		b whenActivatedDo: [ aButton privateSetState: false ]].
		
	aButton whenActivatedDo: [ self currentlyActivated: aButton ].
		
	buttons add: aButton.
	aButton privateSetState: false
]

{ #category : #'Spec2-Deprecated' }
SpRadioButtonGroup >> buttons [
	^ buttons
]

{ #category : #'Spec2-Deprecated' }
SpRadioButtonGroup >> canDeselectByClick [
	"Return true clicking on a selected radio button deselects it"

	^ canDeselectByClick value
]

{ #category : #'Spec2-Deprecated' }
SpRadioButtonGroup >> canDeselectByClick: aBoolean [
	"Set if clicking on a selected radio button can deselect it"
	
	canDeselectByClick value: aBoolean
]

{ #category : #'Spec2-Deprecated' }
SpRadioButtonGroup >> currentlyActivated [
	^ currentlyActivated
]

{ #category : #'Spec2-Deprecated' }
SpRadioButtonGroup >> currentlyActivated: anObject [
	currentlyActivated := anObject
]

{ #category : #'Spec2-Deprecated' }
SpRadioButtonGroup >> default: aButton [

	aButton privateSetState: true.
	aButton takeKeyboardFocus.
	aButton whenBuiltDo: [ aButton privateSetState: true ]
]

{ #category : #'Spec2-Deprecated' }
SpRadioButtonGroup >> initialize [

	super initialize.

	buttons := OrderedCollection new.
	canDeselectByClick := false asValueHolder.
	currentlyActivated := nil asValueHolder
]

{ #category : #'Spec2-Deprecated' }
SpRadioButtonGroup >> whenCanDeselectByClickChanged: aBlock [
	self deprecated: 'Use #whenCanDeselectByClickChangedDo: instead.' transformWith: '`@receiver whenCanDeselectByClickChanged: `@statements' -> '`@receiver whenCanDeselectByClickChangedDo: `@statements'.
	self whenCanDeselectByClickChangedDo: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpRadioButtonGroup >> whenCanDeselectByClickChangedDo: aBlock [
	"This method is triggered when `canDeselectByClick` changes"
	
	canDeselectByClick whenChangedDo: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpRadioButtonGroup >> whenCurrentlyActivatedChanged: aBlock [
	self deprecated: 'Use #whenCurrentlyActivatedChangedDo: instead.' transformWith: '`@receiver whenCurrentlyActivatedChanged: `@statements' -> '`@receiver whenCurrentlyActivatedChangedDo: `@statements'.
	self whenCurrentlyActivatedChangedDo: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpRadioButtonGroup >> whenCurrentlyActivatedChangedDo: aBlock [
	"This method is triggered when `canDeselectByClick` changes"
	
	currentlyActivated whenChangedDo: aBlock
]
