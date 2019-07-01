"
A simple inspector view that displays a morph
"
Class {
	#name : #EyeMorphViewer,
	#superclass : #EyeAbstractInspector,
	#instVars : [
		'morphPresenter'
	],
	#category : #'Spec2-Inspector-Base'
}

{ #category : #spec }
EyeMorphViewer class >> inspectorSpec [
	<spec>
	
	^ SpLayout composed
		newRow: #container bottom: 0.3;
		addHSplitter;
		newRow: #text top: 0.7;
		yourself
]

{ #category : #accessing }
EyeMorphViewer class >> label [
	^ 'Morph Viewer'
]

{ #category : #accessing }
EyeMorphViewer >> container [
	^ morphPresenter
]

{ #category : #initialization }
EyeMorphViewer >> initializePresenter [

	self whenWindowChanged: [ self objectChanged ]
]

{ #category : #initialization }
EyeMorphViewer >> initializeWidgets [
	super initializeWidgets.
	morphPresenter := self newMorph.

	morphPresenter
		morph:
			(PanelMorph new
				changeProportionalLayout;
				vResizing: #spaceFill;
				hResizing: #spaceFill;
				yourself)
]

{ #category : #'event-handling' }
EyeMorphViewer >> objectChanged [
	text doItReceiver: self object.
	morphPresenter morph removeAllMorphs.
	morphPresenter morph addMorph: self thumbnailMorph fullFrame: LayoutFrame identity
]

{ #category : #initialization }
EyeMorphViewer >> step [
	self objectChanged
]

{ #category : #'event-handling' }
EyeMorphViewer >> thumbnailMorph [
	^self object taskThumbnailOfSize: self thumbnailSize
]

{ #category : #accessing }
EyeMorphViewer >> thumbnailSize [
	^ morphPresenter morph extent
]
