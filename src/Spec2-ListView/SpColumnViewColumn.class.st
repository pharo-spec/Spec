"
A column definition to be used with `SpColumnViewPresenter` and `SpTreeColumnViewPresenter`
"
Class {
	#name : 'SpColumnViewColumn',
	#superclass : 'Object',
	#instVars : [
		'title',
		'bind',
		'setup',
		'expand',
		'width',
		'sortFunction'
	],
	#category : 'Spec2-ListView-Widget',
	#package : 'Spec2-ListView',
	#tag : 'Widget'
}

{ #category : 'instance creation' }
SpColumnViewColumn class >> newTitle: aTitle setup: setupBlock bind: bindBlock [

	^ self new 
		title: aTitle;
		setup: setupBlock;
		bind: bindBlock;
		yourself
]

{ #category : 'accessing' }
SpColumnViewColumn >> beExpandable [ 
	
	self expand: true
]

{ #category : 'accessing' }
SpColumnViewColumn >> beNotExpandable [

	self expand: false
]

{ #category : 'api' }
SpColumnViewColumn >> bind: aBlock [

	bind := aBlock
]

{ #category : 'accessing' }
SpColumnViewColumn >> bindAction [

	^ bind
]

{ #category : 'accessing' }
SpColumnViewColumn >> expand: aBoolean [

	expand := aBoolean
]

{ #category : 'testing' }
SpColumnViewColumn >> hasFixedWidth [

	^ width notNil
]

{ #category : 'testing' }
SpColumnViewColumn >> hasTitle [

	^ self title isNotNil
]

{ #category : 'initialization' }
SpColumnViewColumn >> initialize [

	super initialize.
	self beExpandable.
	self setup: [ :aPresenter | aPresenter newLabel ]. 
	self bind: [ :aPresenter :anObject | aPresenter label: anObject asString ]
]

{ #category : 'testing' }
SpColumnViewColumn >> isExpand [

	^ expand
]

{ #category : 'testing' }
SpColumnViewColumn >> isExpandable [
	^ self isExpand
]

{ #category : 'testing' }
SpColumnViewColumn >> isSortable [

	^ self sortFunction isNotNil
]

{ #category : 'api' }
SpColumnViewColumn >> setup: aBlock [

	setup := aBlock
]

{ #category : 'accessing' }
SpColumnViewColumn >> setupAction [

	^ setup
]

{ #category : 'accessing' }
SpColumnViewColumn >> sortFunction [

	^ sortFunction
]

{ #category : 'accessing' }
SpColumnViewColumn >> sortFunction: aSortFunction [

	sortFunction := aSortFunction
]

{ #category : 'api' }
SpColumnViewColumn >> title [

	^ title
]

{ #category : 'api' }
SpColumnViewColumn >> title: aString [

	title := aString
]

{ #category : 'accessing' }
SpColumnViewColumn >> width [

	^ width
]

{ #category : 'accessing' }
SpColumnViewColumn >> width: aNumber [

	width := aNumber
]
