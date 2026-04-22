"
This presenter wraps a `SpCodePresenter` with editor-specific functionality.

It keep track of two visual statuses, dirty and conflict, and show them as overlay adornments on top of the code widget when required.  
Typing marks the editor dirty. Setting the text directly resets both statuses, and submit/reset actions also clear them.  

Prefer it over the low-level code presenter in general, as it provides better user feedback over the general status of the code in edition. 

WIP: This presenter does now yet delegates all functionality it should, and it does not offer yet all high-level functions it should.  
Known TODO:  
- Search & Replace
"
Class {
	#name : 'SpCodeEditorPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'#codePresenter',
		'#dirtyPresenter',
		'#conflictPresenter',
		'#isDirty => ObservableSlot',
		'#isConflict => ObservableSlot',
		'#updating'
	],
	#classVars : [
		'#Adornments'
	],
	#category : 'Spec2-Code-Base',
	#package : 'Spec2-Code',
	#tag : 'Base'
}

{ #category : 'private' }
SpCodeEditorPresenter class >> adornments [

	^ Adornments ifNil: [ Adornments := SmallDictionary new ]
]

{ #category : 'private' }
SpCodeEditorPresenter class >> conflictAdornment [

	^ self adornments
		at: #conflict
		ifAbsentPut: [ self createAdornmentColor: Color red ]
]

{ #category : 'private' }
SpCodeEditorPresenter class >> createAdornmentColor: adornColor [
	| size bounds canvas fillStyle |

	size := 20.
	bounds := 0@0 extent: size@size.
	canvas := FormCanvas extent: bounds extent depth:32.

	fillStyle := (GradientFillStyle ramp: {
			0.0->(Color white alpha: 0.3).
			0.8->adornColor.
			1.0->adornColor})
		origin: bounds topRight - (size@0);
		direction: (size @ size negated) // 4;
		radial: false.
	canvas
		drawPolygon: {
			bounds topRight. 
			bounds topRight + (0@size). 
			bounds topRight - (size@0)}
		fillStyle: fillStyle.
		
	^ canvas form
]

{ #category : 'private' }
SpCodeEditorPresenter class >> dirtyAdornment [

	^ self adornments
		at: #dirty
		ifAbsentPut: [ self createAdornmentColor: Color orange ]
]

{ #category : 'api' }
SpCodeEditorPresenter >> addTextSegmentDecoration: aDecoration [

	codePresenter addTextSegmentDecoration: aDecoration
]

{ #category : 'api - model' }
SpCodeEditorPresenter >> beForBehavior: aBehavior [
	"used when browsing classes or alike"

	codePresenter beForBehavior: aBehavior
]

{ #category : 'api - model' }
SpCodeEditorPresenter >> beForMethod: aMethod [

	codePresenter beForMethod: aMethod
]

{ #category : 'api - model' }
SpCodeEditorPresenter >> beForObject: anObject [
	"Used when inspecting objects"

	codePresenter beForObject: anObject
]

{ #category : 'api - model' }
SpCodeEditorPresenter >> beForScripting [
	"Use in playgrounds"

	codePresenter beForScripting
]

{ #category : 'accessing' }
SpCodeEditorPresenter >> codePresenter [

	^ codePresenter
]

{ #category : 'accessing' }
SpCodeEditorPresenter >> codePresenter: aCodePresenter [

	codePresenter := aCodePresenter
]

{ #category : 'private' }
SpCodeEditorPresenter >> conflict: aBoolean [

	self isUpdating ifTrue: [ ^ self ].
	aBoolean = isConflict ifTrue: [ ^ self ].

	isConflict := aBoolean
]

{ #category : 'accessing' }
SpCodeEditorPresenter >> conflictPresenter [

	^ conflictPresenter
]

{ #category : 'initialization' }
SpCodeEditorPresenter >> connectPresenters [

	self whenDirtyChangedDo: [ self updateDirtyPresenter ].
	self whenConflictChangedDo: [ self updateConflictPresenter ].
	
	codePresenter whenTextChangedDo: [ :aString | self markDirty ]
]

{ #category : 'layout' }
SpCodeEditorPresenter >> defaultLayout [

	^ SpOverlayLayout new
		child: codePresenter;
		addOverlay: dirtyPresenter withConstraints: [ :c | c vAlignStart; hAlignEnd ];
		addOverlay: conflictPresenter withConstraints: [ :c | c vAlignStart; hAlignEnd ];
		yourself
]

{ #category : 'private' }
SpCodeEditorPresenter >> dirty: aBoolean [

	self isUpdating ifTrue: [ ^ self ].
	aBoolean = isDirty ifTrue: [ ^ self ].

	isDirty := aBoolean
]

{ #category : 'accessing' }
SpCodeEditorPresenter >> dirtyPresenter [

	^ dirtyPresenter
]

{ #category : 'initialization' }
SpCodeEditorPresenter >> initialize [

	updating := false.
	super initialize
]

{ #category : 'initialization' }
SpCodeEditorPresenter >> initializePresenters [

	codePresenter := self newCode.
	
	dirtyPresenter := self newImage.
	dirtyPresenter image: self class dirtyAdornment.
	dirtyPresenter hide.
	
	conflictPresenter := self newImage.
	conflictPresenter image: self class dirtyAdornment.
	conflictPresenter hide
]

{ #category : 'testing' }
SpCodeEditorPresenter >> isConflict [

	^ isConflict ifNil: [ isConflict := false ]
]

{ #category : 'testing' }
SpCodeEditorPresenter >> isDirty [

	^ isDirty ifNil: [ isDirty := false ]
]

{ #category : 'private - updating' }
SpCodeEditorPresenter >> isUpdating [

	^ updating
]

{ #category : 'api' }
SpCodeEditorPresenter >> markConflict [

	self conflict: true
]

{ #category : 'api' }
SpCodeEditorPresenter >> markDirty [

	self dirty: true
]

{ #category : 'api' }
SpCodeEditorPresenter >> syntaxHighlight: aBoolean [

	codePresenter syntaxHighlight: aBoolean
]

{ #category : 'api' }
SpCodeEditorPresenter >> text [

	^ codePresenter text
]

{ #category : 'api' }
SpCodeEditorPresenter >> text: aString [

	self updatingWhile: [ codePresenter text: aString ].
	"we assume that this is not dirty if we are setting it directly, users wanting
	 to make its setted code dirty have to do it themselves by calling #markDirty"
	self unmarkDirty.
	self unmarkConflict
]

{ #category : 'api' }
SpCodeEditorPresenter >> unmarkConflict [

	self conflict: false
]

{ #category : 'api' }
SpCodeEditorPresenter >> unmarkDirty [

	self dirty: false
]

{ #category : 'initialization' }
SpCodeEditorPresenter >> updateConflictPresenter [

	conflictPresenter visible: self isConflict
]

{ #category : 'initialization' }
SpCodeEditorPresenter >> updateDirtyPresenter [

	dirtyPresenter visible: self isDirty
]

{ #category : 'private - updating' }
SpCodeEditorPresenter >> updatingWhile: aBlock [

	updating ifTrue: [ ^ self ].
	updating := true.
	aBlock ensure: [
		updating := false ]
]

{ #category : 'api - events' }
SpCodeEditorPresenter >> whenConflictChangedDo: aBlock [

	self property: #isConflict whenChangedDo: aBlock
]

{ #category : 'api - events' }
SpCodeEditorPresenter >> whenDirtyChangedDo: aBlock [

	self property: #isDirty whenChangedDo: aBlock
]

{ #category : 'api - events' }
SpCodeEditorPresenter >> whenResetDo: aBlock [

	codePresenter whenResetDo: [
		self unmarkDirty.
		self unmarkConflict.
		aBlock cull: codePresenter text ]
]

{ #category : 'api - events' }
SpCodeEditorPresenter >> whenSubmitDo: aBlock [

	codePresenter whenSubmitDo: [ :text |
		self unmarkDirty.
		self unmarkConflict.
		aBlock cull: text ]
]
