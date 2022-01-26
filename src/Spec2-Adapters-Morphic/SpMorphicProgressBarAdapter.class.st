"
Description
--------------------

I am a Morphic adapter to bridge the ProgressBarPresenter and the ProgressBarMorph.
"
Class {
	#name : #SpMorphicProgressBarAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#instVars : [
		'progressBar',
		'progressLabel'
	],
	#category : #'Spec2-Adapters-Morphic-Base'
}

{ #category : #styling }
SpMorphicProgressBarAdapter >> applyStyle: morph [
	"this will apply general properties to the built morph"

	super applyStyle: morph.
	self labelStyle applyTo: progressLabel.
	self barStyle applyTo: progressBar
]

{ #category : #styling }
SpMorphicProgressBarAdapter >> barStyle [

	^ SpMorphStyle 
		fromStylesheet: self styleSheet 
		baseStyleName: self styleName, ':bar'
		otherStyles: self presenterStyles
]

{ #category : #factory }
SpMorphicProgressBarAdapter >> buildWidget [
	| panel |
	
	panel := Morph new
		changeTableLayout;
		color: Color transparent;
		listDirection: #topToBottom;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself.

	progressLabel := LabelMorph new.

	progressBar := (self progressBarState progressBarMorph from: 0 to: 1) 
		"changeProportionalLayout;"
		hResizing: #spaceFill;
		vResizing: #rigid;
		height: 5;
		yourself.

	self progressBarState customizeMorphicBar: progressBar.

	panel 
		addMorphBack: progressLabel;
		addMorphBack: progressBar.
	
	^ panel
]

{ #category : #styling }
SpMorphicProgressBarAdapter >> labelStyle [

	^ SpMorphStyle
		fromStylesheet: self styleSheet 
		baseStyleName: self styleName, ':label'
		otherStyles: self presenterStyles
]

{ #category : #accessing }
SpMorphicProgressBarAdapter >> progressBarState [

	^ self model state
]

{ #category : #updating }
SpMorphicProgressBarAdapter >> updateState [

	self progressBarState 
		customizeMorphicLabel: progressLabel;
		customizeMorphicBar: progressBar.
	(Processor activeProcess = UIManager default uiProcess) 
		ifTrue: [  
			self widgetDo: [ :w |
				w currentWorld doOneCycle ] ]
]
