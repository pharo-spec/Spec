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
		'progressLabel',
		'lastRefresh',
		'refreshRateInMs',
		'refreshBlock'
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

{ #category : #initialization }
SpMorphicProgressBarAdapter >> initialize [ 
	
	super initialize.
	lastRefresh := 0.
	"If we refresh the UI too often, it will slow down heavily the job being executed.
	A good default is to refresh 4 times per second. It can be configured by #refreshRateInMs: if needed"
	refreshRateInMs := 250.
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

{ #category : #accessing }
SpMorphicProgressBarAdapter >> refreshRateInMs: nbMilliSeconds [
	"The progress  bar will only be updated if the time between 2 refresh is > nbMilliSeconds"
	refreshRateInMs := nbMilliSeconds.
]

{ #category : #updating }
SpMorphicProgressBarAdapter >> updateState [

	| isTimeForRefresh |
	self progressBarState 
		customizeMorphicLabel: progressLabel;
		customizeMorphicBar: progressBar.
	
	isTimeForRefresh := Time millisecondClockValue - lastRefresh >= refreshRateInMs.
	isTimeForRefresh 
		ifFalse: [ ^ self ].
	
	lastRefresh := Time millisecondClockValue.		
	(Processor activeProcess = UIManager default uiProcess) 
		ifTrue: [  
			self widgetDo: [ :w |
				w currentWorld doOneCycle ] ].
	refreshBlock ifNotNil: [ refreshBlock value ].
]

{ #category : #enumerating }
SpMorphicProgressBarAdapter >> whenRefreshedDo: aBlock [
	"When the widget will be refreshed, aBlock will be executed.
	By example, it can be used to test the redraw rate of the presenter."
	
	refreshBlock := aBlock
]
