"
I am an elementary Spec widget that adds a LabelPresenter at another widget.

self example

I provide the method content: that take a class in parameter, it instantiates it in the variable subwidget and add it at the focusOrder. Note it does not reset the focusOrder.

I provide accessors for the label and the subwidget, but I specialize doesNotUnderstand: to send the message at the subwidget.

I provide four layouts on my class side, to chose the position of the label.
"
Class {
	#name : 'SpLabelledContainer',
	#superclass : 'SpPresenter',
	#instVars : [
		'label',
		'subwidget'
	],
	#category : 'Spec2-Deprecated-Labelled',
	#package : 'Spec2-Deprecated-Labelled'
}

{ #category : 'examples' }
SpLabelledContainer class >> abstractExample [
	| example |
	example := self new.
	example label: 'I am a label'.
	^ example
]

{ #category : 'specs' }
SpLabelledContainer class >> defaultSpec [
	^ self labelTop
]

{ #category : 'examples' }
SpLabelledContainer class >> example [
	<sampleInstance>
	| example |
	example := self abstractExample.
	self setUpExample: example.
	example openWithSpec.
	example withWindowDo: [ :window | window title: self name asString , ' example' ].
	^ example
]

{ #category : 'specs' }
SpLabelledContainer class >> labelBottom [
	<spec>
	^ SpBoxLayout newTopToBottom
		add: #subwidget;
		add: #label
			expand: false
			fill: false
			padding: 0;
		yourself
]

{ #category : 'specs' }
SpLabelledContainer class >> labelLeft [
	<spec>
	^ SpBoxLayout newLeftToRight
		add: #label
			expand: false
			fill: false
			padding: 0;
		add: #subwidget;
		yourself
]

{ #category : 'specs' }
SpLabelledContainer class >> labelRight [
	<spec>
	^ SpBoxLayout newLeftToRight
		add: #subwidget;
		add: #label
			expand: false
			fill: false
			padding: 0;
		yourself
]

{ #category : 'specs' }
SpLabelledContainer class >> labelTop [
	<spec>
	^ SpBoxLayout newTopToBottom
		add: #label
			expand: false
			fill: false
			padding: 0;
		add: #subwidget;
		yourself
]

{ #category : 'examples' }
SpLabelledContainer class >> setUpExample: example [
	example content: SpButtonPresenter.
	example subwidget label: 'I am a button'
]

{ #category : 'initialization' }
SpLabelledContainer >> content: aWidgetClass [
	subwidget := self instantiate: aWidgetClass.
	self focusOrder add: subwidget
]

{ #category : 'error handling' }
SpLabelledContainer >> doesNotUnderstand: aMessage [
	^ aMessage sendTo: subwidget
]

{ #category : 'initialization' }
SpLabelledContainer >> initializePresenters [
	label := self instantiate: SpLabelPresenter.
]

{ #category : 'accessing' }
SpLabelledContainer >> label [
	^ label
]

{ #category : 'accessing' }
SpLabelledContainer >> label: aString [
	label label: aString
]

{ #category : 'accessing' }
SpLabelledContainer >> subwidget [
	^ subwidget
]

{ #category : 'accessing' }
SpLabelledContainer >> subwidget: anObject [
	subwidget := anObject
]
