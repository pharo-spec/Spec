"
I am the adapter used to bridge a DialogWindowPresenter and a DialogWindow
"
Class {
	#name : #MorphicDialogWindowAdapter,
	#superclass : #MorphicWindowAdapter,
	#category : #'Spec-MorphicAdapters-Base'
}

{ #category : #private }
MorphicDialogWindowAdapter >> add: aMorph toWindow: aWindow [
	
	aWindow specWidget: aMorph
]

{ #category : #private }
MorphicDialogWindowAdapter >> addModelIn: widgetToBuild withSpecLayout: aSpec [
	"Since dialogs work different to regular windows in several aspects. I needed to introduce 
	 some hooks to make things work and I'm not particulary happy with them (but I do not 
	 find a better solution without reimplementing the whole thing). So, here is the explanation 
	 of the changes: 
	 First, a dialog *contains* an area, a content panel and a toolbar panel (this is correct IMO 
	 and I wonder why windows do not behave in same way and they mix all morphs (headers, button,
	 contents). Anyway, important thing is when dialog arrives here, contents ARE ALREADY THERE.
	 I need then to replace it instead just add it. 
	 I replace the mainPanel (which contains contents and button bar) because like that I get the 
	 status bar at the end (where it belongs)"
	
	self 
		addContent: widgetToBuild mainPanel
		toWindow: widgetToBuild.
		
	widgetToBuild setToolbarFrom: [ self buildButtonBar ]
]

{ #category : #factory }
MorphicDialogWindowAdapter >> buildButtonBar [
	| buttonBar |
	
	buttonBar := ButtonBarPresenter new placeAtEnd.
	self model buttons do: [ :buttonPresenter | 
		buttonBar add: buttonPresenter ].
	
	^ buttonBar
]

{ #category : #factory }
MorphicDialogWindowAdapter >> buildWidget [

	^ SpecDialogWindow new
		specWidget: self model contents;
		model: self model;
		initialize;
		yourself
]

{ #category : #protocol }
MorphicDialogWindowAdapter >> open [

	self widget openInWorld
]

{ #category : #private }
MorphicDialogWindowAdapter >> replace: aMorph with: containerMorph onWindow: aSpecWindow [

	containerMorph layoutFrame: aMorph layoutFrame.
	aSpecWindow		
		replaceSubmorph: aMorph 
		by: containerMorph

]
