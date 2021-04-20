"
I am an elementary Spec Widget managing a slider and an input.

Self example

Between the bounds min and max of the slider, I ensure that the value of the input on the accept and the value of the slider are the same.

Note
====
- min and max must be set before use me.
- if autoAccept is true, the character '-' could create problems
"
Class {
	#name : #SpSliderInputPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'slider',
		'input'
	],
	#category : #'Spec2-Core-Widgets'
}

{ #category : #specs }
SpSliderInputPresenter class >> defaultSpec [
	^ self sliderLeft
]

{ #category : #specs }
SpSliderInputPresenter class >> sliderBottom [
	<spec>
	^ SpBoxLayout newTopToBottom
		add: #input withConstraints: [ :constraints | constraints height: self buttonHeight ];
		add: #slider;
		yourself
]

{ #category : #specs }
SpSliderInputPresenter class >> sliderLeft [
	<spec>
	^ SpPanedLayout newLeftToRight
		position: 85 percent;
		add: #slider withConstraints: [ :constraints | constraints beNotResizable ];
		add: #input;
		yourself
]

{ #category : #specs }
SpSliderInputPresenter class >> sliderRight [
	<spec>
	^ SpPanedLayout newLeftToRight
		position: 15 percent;
		add: #input;
		add: #slider;
		yourself
]

{ #category : #specs }
SpSliderInputPresenter class >> sliderTop [
	<spec>
	^ SpBoxLayout newTopToBottom
		add: #slider;
		add: #input withConstraints: [ :constraints | constraints height: self buttonHeight ];
		yourself
]

{ #category : #initialization }
SpSliderInputPresenter >> connectPresenters [

	slider whenValueChangedDo: [ :sliderValue | 
		| inputValue |
		inputValue := input text asNumber.	" ifNotNil: [ :text | text asNumber ]"
		sliderValue == inputValue
			ifFalse: [ input text: sliderValue asString ] ].
	
	input whenTextChangedDo: [ :text | 
		| inputValue |
		inputValue := text asNumber.
		slider value == inputValue
			ifFalse: [ slider value: inputValue ] ]
]

{ #category : #initialization }
SpSliderInputPresenter >> initializePresenters [

	slider := self newSlider.
	input := self newTextInput

]

{ #category : #accessing }
SpSliderInputPresenter >> input [
	^ input
]

{ #category : #accessing }
SpSliderInputPresenter >> label [
	^ slider label
]

{ #category : #accessing }
SpSliderInputPresenter >> label: aString [
	slider label: aString
]

{ #category : #accessing }
SpSliderInputPresenter >> max: aNumber [
	slider max: aNumber
]

{ #category : #accessing }
SpSliderInputPresenter >> min: aNumber [
	slider min: aNumber.
	input text: aNumber asString 
]

{ #category : #accessing }
SpSliderInputPresenter >> slider [
	^ slider
]

{ #category : #accessing }
SpSliderInputPresenter >> value [
	^ slider value
]

{ #category : #accessing }
SpSliderInputPresenter >> value: aNumber [
	slider value: aNumber 
]

{ #category : #'api-events' }
SpSliderInputPresenter >> whenValueChangedDo: aBlock [
	slider whenValueChangedDo: aBlock
]
