"
A SpecDialogWindow is a window made for embedding Spec models into dialog windows

"
Class {
	#name : 'SpDialogWindowMorph',
	#superclass : 'DialogWindowMorph',
	#instVars : [
		'toolbar',
		'toolbarMorph'
	],
	#category : 'Spec2-Adapters-Morphic-Support',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Support'
}

{ #category : 'actions' }
SpDialogWindowMorph >> addInitialPanel [
	"Do nothing here because Spec will take care of adding the content"
]

{ #category : 'private' }
SpDialogWindowMorph >> announceWillClose [
	| announcement |

	announcement := SpWindowWillClose new
		window: self;
		yourself.
	self announce: announcement.
	self currentWorld announcer announce: announcement.
	^ announcement canClose
]

{ #category : 'protocol' }
SpDialogWindowMorph >> cancelAction: aBlock [

	self toolbar cancelAction: aBlock 
]

{ #category : 'protocol' }
SpDialogWindowMorph >> cancelled [

	^ self toolbar cancelled
]

{ #category : 'actions' }
SpDialogWindowMorph >> closeBoxHit [
	"Closing the dialog from its close box is a cancel, as when pressing escape"

	self allowedToClose ifFalse: [ ^ self ].
	self model triggerCancelAction
]

{ #category : 'private' }
SpDialogWindowMorph >> deleteDiscardingChanges [

	self announceWillClose ifFalse: [ ^ self ].
	^ super deleteDiscardingChanges
]

{ #category : 'actions' }
SpDialogWindowMorph >> escapePressed [

	self model triggerCancelAction
]

{ #category : 'resize/collapse' }
SpDialogWindowMorph >> extent: aPoint [ 
	| announcement oldExtent |
	
	oldExtent := self extent. 
	super extent: aPoint.
	
	oldExtent = aPoint ifFalse: [  	
		announcement := SpWindowResizing new
			window: self;
			oldSize: oldExtent;
			newSize: aPoint;
			yourself.
		self announce: announcement.
		self currentWorld announcer announce: announcement ]
]

{ #category : 'focus' }
SpDialogWindowMorph >> giveFocusToNextFrom: aModel [ 

	^ self model giveFocusToNextFrom: aModel 
]

{ #category : 'focus' }
SpDialogWindowMorph >> giveFocusToPreviousFrom: aModel [ 

	^ self model giveFocusToPreviousFrom: aModel
]

{ #category : 'open/close' }
SpDialogWindowMorph >> initialExtent [ 

	^ self model
		ifNil: [ super initialExtent ]
		ifNotNil: [:m | m initialExtent
						ifNil: [ super initialExtent ]]
]

{ #category : 'initialization' }
SpDialogWindowMorph >> initialize [
	super initialize.
	self beResizeable
]

{ #category : 'initialization' }
SpDialogWindowMorph >> initializeLabelArea [
	"DialogWindowMorph removes all the boxes of the label area.
	 Keep a close box, as dialogs have in other backends (e.g. Gtk)"

	super initializeLabelArea.
	closeBox := self createCloseBox.
	self replaceBoxes
]

{ #category : 'accessing' }
SpDialogWindowMorph >> newButtonRow [

	^ self toolbar ifNotNil: [ :t | t build ]
]

{ #category : 'protocol' }
SpDialogWindowMorph >> okAction: aBlock [

	self toolbar okAction: aBlock 
]

{ #category : 'accessing' }
SpDialogWindowMorph >> removeToolbar [

	toolbarMorph ifNil: [ ^ self ].
	self submorphs last removeMorph: toolbarMorph
]

{ #category : 'protocol' }
SpDialogWindowMorph >> setToolbarFrom: aBlock [
	| newToolbar |
	
	newToolbar := aBlock value.
	self toolbar: newToolbar
]

{ #category : 'accessing' }
SpDialogWindowMorph >> toolbar [
	"Lazy initialization because this method is called efore the initialize method"
	
	^ toolbar
]

{ #category : 'accessing' }
SpDialogWindowMorph >> toolbar: anObject [
	| content |
	
	toolbar := anObject.
	toolbarMorph 
		ifNotNil: [
			self removeToolbar.
			toolbarMorph := self newButtonRow.
			self submorphs last addMorphBack: toolbarMorph ]
		ifNil: [
			toolbarMorph := self newButtonRow.   
			self removeMorph: (content := self submorphs last).
			self 
				addMorph: (self newDialogPanel 
					addMorphBack: content; 
					addMorphBack: toolbarMorph; 
					yourself) 
				frame: (0 @ 0 corner: 1 @ 1) ]
]
