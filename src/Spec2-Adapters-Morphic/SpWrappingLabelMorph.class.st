"
I show the text of a `SpLabelPresenter` that wraps (see `SpLabelPresenter>>#beWrap`).
A `LabelMorph` draws one line. A `TextMorph` wraps, but lets the user type into it, and a locked one loses its tooltip and mouse events. So I am a `TextMorph` that cannot be edited: I take no keyboard focus and handle keys and clicks only through my event handler.
"
Class {
	#name : 'SpWrappingLabelMorph',
	#superclass : 'TextMorph',
	#category : 'Spec2-Adapters-Morphic-Support',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Support'
}

{ #category : 'accessing' }
SpWrappingLabelMorph >> contents: aStringOrText [
	"TextMorph>>#contents: stops wrapping (see #contentsAsIs:). I always wrap."

	^ self contentsWrapped: aStringOrText
]

{ #category : 'geometry' }
SpWrappingLabelMorph >> extent: aPoint [
	"A new width changes my height (more or fewer lines): lay out my owner again, once its current layout is done."

	| previousHeight |
	previousHeight := self height.
	super extent: aPoint.
	self height = previousHeight ifTrue: [ ^ self ].

	self defer: [ self layoutChanged ]
]

{ #category : 'layout' }
SpWrappingLabelMorph >> fitContents [

	self fit
]

{ #category : 'event handling' }
SpWrappingLabelMorph >> handlesKeyboard: evt [
	"As Morph>>#handlesKeyboard:, which TextMorph overrides to edit its text"

	self eventHandler ifNotNil: [ :anEventHandler | ^ anEventHandler handlesKeyboard: evt ].
	^ false
]

{ #category : 'event handling' }
SpWrappingLabelMorph >> handlesMouseDown: evt [
	"As Morph>>#handlesMouseDown:, which TextMorph overrides to edit its text"

	self eventHandler ifNotNil: [ :anEventHandler | ^ anEventHandler handlesMouseDown: evt ].
	^ false
]

{ #category : 'initialization' }
SpWrappingLabelMorph >> initialize [

	super initialize.
	self wrapFlag: true
]

{ #category : 'event handling' }
SpWrappingLabelMorph >> mouseDown: evt [
	"Unlike a TextMorph, do not take the keyboard focus nor open the text editing menu."

	
]
