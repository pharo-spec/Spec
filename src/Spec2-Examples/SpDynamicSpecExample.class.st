"
I am an example of how dynamically create the UI corresponding at an object.

self exampleInt
self exampleNil
self exampleString
"
Class {
	#name : #SpDynamicSpecExample,
	#superclass : #Object,
	#traits : 'TSpObservable',
	#classTraits : 'TSpObservable classTrait',
	#instVars : [
		'#ui',
		'#object => SpObservableSlot'
	],
	#category : #'Spec2-Examples-Wrapper'
}

{ #category : #example }
SpDynamicSpecExample class >> exampleInt [
	<sampleInstance>
	^ self new open: 42
]

{ #category : #example }
SpDynamicSpecExample class >> exampleNil [
	<sampleInstance>
	^ self new
		open: nil
]

{ #category : #example }
SpDynamicSpecExample class >> exampleString [
	<sampleInstance>
	^ self new
		open: 'Hello World'
]

{ #category : #'instance creation' }
SpDynamicSpecExample class >> object: object [

	^ self new
		object: object;
		yourself
]

{ #category : #initialization }
SpDynamicSpecExample >> initialize [
	self class initializeSlots: self.
	super initialize
]

{ #category : #accessing }
SpDynamicSpecExample >> object [
	^ object
]

{ #category : #accessing }
SpDynamicSpecExample >> object: anObject [
	object := anObject
]

{ #category : #protocol }
SpDynamicSpecExample >> open [
	self object ifNil: [ ^ self openOnNil ].
	self object isInteger ifTrue: [ ^ self openOnInteger ].
	self object isString ifTrue: [ ^ self openOnString ]
]

{ #category : #protocol }
SpDynamicSpecExample >> open: anObject [
	anObject ifNil: [ ^ self openOnNil ].
	anObject isInteger
		ifTrue: [ ^ self openOnInteger: anObject ].
	anObject isString
		ifTrue: [ ^ self openOnString: anObject ]
]

{ #category : #protocol }
SpDynamicSpecExample >> openOnInteger [
	<script: '(DynamicSpecExample object: 42) open'>
	
	| anUI layout |
	
	anUI := SpDynamicPresenter new.
	anUI title: self title.
	anUI instantiatePresenters: #( 
		text #SpLabelPresenter
		plus #SpButtonPresenter
		minus #SpButtonPresenter ).
		
	anUI text label: self object asString.
	anUI minus 
		label: '-';
		state: false;
		action: 	[ 
			self object: self object -1.
			anUI text label: self object asString ].

	anUI plus 
		label: '+';
		state: false;
		action: 	[ 
			self object: self object +1.
			anUI text label: self object asString ].
	
	layout := SpLayout composed
		newColumn: [ :c |
			c
				add: #text height: 25;
				newRow: [ :r | r add: #minus ; addSplitter; add: #plus ] height: 25 ];
		yourself.
				
	anUI openWithSpecLayout: layout.
]

{ #category : #protocol }
SpDynamicSpecExample >> openOnInteger: anInteger [
	ui := SpOpenOnIntExample new: anInteger.
	ui
		extent: 100 @ 100;
		openWithSpec
]

{ #category : #protocol }
SpDynamicSpecExample >> openOnNil [
	ui := SpOpenOnNilExample new.
	ui 
		extent: 200 @ 100; openWithSpec
]

{ #category : #protocol }
SpDynamicSpecExample >> openOnString [
	<script: '(DynamicSpecExample object: ''Pharo'') open'>
	
	| anUI layout bottomLayout temp |	
	anUI := SpDynamicPresenter new.
	anUI title: self title.
	anUI instantiatePresenters: #( 
		label #SpLabelPresenter
		check #SpCheckBoxPresenter
		text #SpTextInputFieldPresenter
		button #SpButtonPresenter ).
		
	anUI label label: self object.

			
	self property: #object whenChangedDo: [ :o | anUI label label: o asString ].
		
	anUI text 
		text: self object;
		enabled: true;
		acceptBlock: [ :string | self object: string ].
	
	temp := self object.
	
	anUI button
		label: 'reset';
		state: false;
		action: [ 
			anUI text text: temp.
			self object: temp ].
		
	layout := SpLayout composed
				newColumn: [ :c |
					c 
						newRow: [ :r | r add: #label; add: #check width: 100 ] height: 25;
						newRow: [ :r | r add: #text; add: #button ] height: 25 ];
				yourself.
				
	bottomLayout := SpLayout composed
				newColumn: [ :c |
					c 
						newRow: [ :r | r add: #text; add: #button ] height: 25;
						newRow: [ :r | r add: #label; add: #check width: 100 ] height: 25 ];
				yourself.
	
	anUI check
		label: 'Label on top';
		state: true;
		whenActivatedDo: [
			anUI needFullRebuild: false.
			anUI buildWithSpecLayout: layout ];
		whenDeactivatedDo: [ 
			anUI needFullRebuild: false.
			anUI buildWithSpecLayout: bottomLayout ].
				
	anUI openWithSpecLayout: layout.
]

{ #category : #protocol }
SpDynamicSpecExample >> openOnString: aString [
	ui := SpOpenOnStringExample new:aString.
	ui 
		extent: 300 @ 200;openWithSpec
]

{ #category : #accessing }
SpDynamicSpecExample >> title [

	^ 'Dynamic Examples'
]
