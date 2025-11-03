"
I'm the adapter used to bridge a Popover and its morphic representation.
"
Class {
	#name : 'SpMorphicPopoverAdapter',
	#superclass : 'SpAbstractMorphicAdapter',
	#category : 'Spec2-Adapters-Morphic-Base',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpMorphicPopoverAdapter class >> defaultHeight [

	^ 30
]

{ #category : 'accessing' }
SpMorphicPopoverAdapter class >> defaultItemSeparation [
	
	^ 3@0
]

{ #category : 'factory' }
SpMorphicPopoverAdapter >> addModelTo: aMorph [

	aMorph contentMorph: self presenterWidget.	
	aMorph beRelativeTo: self presenter relativeTo adapter widget. 	
	aMorph announcer 
		when: MorphDeleted
		send: #announceClosed
		to: self. 
	self setPopoverPositionTo: aMorph.
	
	self presenter whenPresenterChangedDo: [
		aMorph contentMorph: self presenterWidget ]
]

{ #category : 'private - announcing' }
SpMorphicPopoverAdapter >> announceClosed [
	
	self presenter popoverClosed
]

{ #category : 'private - announcing' }
SpMorphicPopoverAdapter >> announceOpened [

	self presenter popoverOpened
]

{ #category : 'factory' }
SpMorphicPopoverAdapter >> buildWidget [
	| panelMorph |
	
	panelMorph := SpPopoverMorph new.
	self addModelTo: panelMorph.
	
	^ panelMorph
]

{ #category : 'factory' }
SpMorphicPopoverAdapter >> contentPresenter [
	
	^ self presenter presenter
]

{ #category : 'api' }
SpMorphicPopoverAdapter >> dismiss [ 

	self widgetDo: [ :w | w popdown ]
]

{ #category : 'api' }
SpMorphicPopoverAdapter >> popupModal: aBoolean pointingTo: aRectangle [

	self widgetDo: [ :w |
		self applyStyle: w.
		aRectangle
			ifNotNil: [ w popupPointingTo: aRectangle ]
			ifNil: [ w popup ].
		self presenter popoverOpened ]
]

{ #category : 'factory' }
SpMorphicPopoverAdapter >> presenterWidget [

	self contentPresenter build.
	self contentPresenter adapter applyStyle.
	^ self contentPresenter adapter widget
]

{ #category : 'factory' }
SpMorphicPopoverAdapter >> setPopoverPositionTo: gtkPopover [
		
	^ self presenter position applyTo: gtkPopover
]
