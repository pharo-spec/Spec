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

{ #category : 'protocol' }
SpDialogWindowMorph >> cancelAction: aBlock [

	self toolbar cancelAction: aBlock 
]

{ #category : 'protocol' }
SpDialogWindowMorph >> cancelled [

	^ self toolbar cancelled
]

{ #category : 'actions' }
SpDialogWindowMorph >> escapePressed [

	self model triggerCancelAction
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
