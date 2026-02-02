Class {
	#name : 'SpScrollableLayout',
	#superclass : 'SpExecutableLayout',
	#traits : 'SpTAlignable',
	#classTraits : 'SpTAlignable classTrait',
	#instVars : [
		'singleChild',
		'propagateNaturalHeight',
		'propagateNaturalWidth',
		'hScrollbar',
		'vScrollbar'
	],
	#category : 'Spec2-Layout-Scroll',
	#package : 'Spec2-Layout',
	#tag : 'Scroll'
}

{ #category : 'instance creation' }
SpScrollableLayout class >> with: aSymbolOrPresenter [

	^ self new 
		child: aSymbolOrPresenter;
		yourself
]

{ #category : 'private' }
SpScrollableLayout >> adapterName [

	^ #ScrollableAdapter
]

{ #category : 'accessing' }
SpScrollableLayout >> child [

	^ singleChild
]

{ #category : 'accessing' }
SpScrollableLayout >> child: aPresenter [

	singleChild ifNotNil: [ self remove: singleChild ].
	self
		add: aPresenter
		withConstraints: [ :constraints | ].
	singleChild := aPresenter.
	self announceChildAdded: aPresenter
]

{ #category : 'private' }
SpScrollableLayout >> constraintsClass [

	^ SpBoxConstraints
]

{ #category : 'testing' }
SpScrollableLayout >> hasHScrollbar [

	^ hScrollbar
]

{ #category : 'testing' }
SpScrollableLayout >> hasVScrollbar [

	^ vScrollbar
]

{ #category : 'initialization' }
SpScrollableLayout >> initialize [

	super initialize.
	self withVScrollbar.
	self withHScrollbar.
	self propagateNaturalHeight: false.
	self propagateNaturalWidth: false.
]

{ #category : 'testing' }
SpScrollableLayout >> isPropagateNaturalHeight [
	
	^ propagateNaturalHeight
]

{ #category : 'testing' }
SpScrollableLayout >> isPropagateNaturalWidth [
	
	^ propagateNaturalWidth
]

{ #category : 'accessing' }
SpScrollableLayout >> propagateNaturalHeight: aBoolean [

	propagateNaturalHeight := aBoolean
]

{ #category : 'accessing' }
SpScrollableLayout >> propagateNaturalWidth: aBoolean [

	propagateNaturalWidth := aBoolean
]

{ #category : 'accessing' }
SpScrollableLayout >> remove: aPresenter [

	singleChild := nil.
	super remove: aPresenter
	
]

{ #category : 'accessing' }
SpScrollableLayout >> scrollTo: aPoint [

	self withAdapterDo: [ :anAdapter |
		anAdapter scrollTo: aPoint ]
]

{ #category : 'accessing' }
SpScrollableLayout >> withHScrollbar [

	hScrollbar := true
]

{ #category : 'accessing' }
SpScrollableLayout >> withVScrollbar [

	vScrollbar := true
]

{ #category : 'accessing' }
SpScrollableLayout >> withoutHScrollbar [

	hScrollbar := false
]

{ #category : 'accessing' }
SpScrollableLayout >> withoutVScrollbar [

	vScrollbar := false
]
