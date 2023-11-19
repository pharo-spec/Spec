"
Spec Adapter to Morphic for a ButtonBarPresenter using a PanelMorph
"
Class {
	#name : 'SpMorphicButtonBarAdapter',
	#superclass : 'SpAbstractMorphicAdapter',
	#category : 'Spec2-Adapters-Morphic-Base',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpMorphicButtonBarAdapter class >> defaultHeight [

	^ 30 scaledByDisplayScaleFactor
]

{ #category : 'accessing' }
SpMorphicButtonBarAdapter class >> defaultItemSeparation [
	
	^ (3@0) scaledByDisplayScaleFactor
]

{ #category : 'factory' }
SpMorphicButtonBarAdapter >> addModelTo: panelMorph [

	self model items do: [ :each |
		self model focusOrder add: each.
		panelMorph addMorph: (each build
			width: 100 scaledByDisplayScaleFactor;
			hResizing: #rigid;
			yourself) ]
]

{ #category : 'factory' }
SpMorphicButtonBarAdapter >> buildWidget [
	| panelMorph |
	
	panelMorph := PanelMorph new 
		changeTableLayout;
		listDirection: self listDirection;
		hResizing: #spaceFill;
		vResizing: #rigid;
		cellInset: self class defaultItemSeparation;
		height: self class defaultHeight;
		yourself.

	self addModelTo: panelMorph.
	
	^ panelMorph
]

{ #category : 'factory' }
SpMorphicButtonBarAdapter >> listDirection [
	
	self model isPlaceAtEnd ifTrue: [ ^ #rightToLeft ].
	self model isPlaceAtStart ifTrue: [ ^ #leftToRight ].
	
	self error: 'Undefined location to place buttons.'
]
