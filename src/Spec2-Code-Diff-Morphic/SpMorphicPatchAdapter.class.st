Class {
	#name : #SpMorphicPatchAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#instVars : [
		'lineMarks'
	],
	#category : #'Spec2-Code-Diff-Morphic'
}

{ #category : #factory }
SpMorphicPatchAdapter >> buildWidget [
	| newWidget |
	
	newWidget := SpRubScrolledTextMorph new
		beWrapped;
		enabled: self enabled;
		autoAccept: true;
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		setBalloonText: self help;
		dragEnabled: self dragEnabled;
		dropEnabled: self dropEnabled;
		hScrollbarShowWhenNeeded;
		yourself.
	
	self setEditable: false to: newWidget.
	self setEditingModeFor: newWidget.
	self setPatchTo: newWidget.
	self presenter whenPatchChangedDo: [ :aPatchModel | 
		self setPatch: aPatchModel ].
	
	newWidget withRuler: (SpMorphicLineMarkDisplayer new
		adapter: self;
		yourself).
	newWidget textArea withDecorator: (SpMorphicPatchLineDecorator new
		adapter: self;
		yourself).
	
	^ newWidget
]

{ #category : #accessing }
SpMorphicPatchAdapter >> lineMarks [

	^ lineMarks ifNil: [ #() ]
]

{ #category : #accessing }
SpMorphicPatchAdapter >> markAt: aSymbol [

	^ self presenter marks at: aSymbol
]

{ #category : #factory }
SpMorphicPatchAdapter >> setEditable: aBoolean to: aWidget [

	aWidget textArea readOnly: aBoolean not
]

{ #category : #factory }
SpMorphicPatchAdapter >> setEditingModeFor: textArea [

	textArea beForPlainText
]

{ #category : #factory }
SpMorphicPatchAdapter >> setPatch: aPatchModel [
	
	self widgetDo: [ :w |
		self setPatch: aPatchModel patch to: w ]
]

{ #category : #'private accessing' }
SpMorphicPatchAdapter >> setPatch: patch to: aWidget [ 
	| visitor |
	
	visitor := SpMorphicPatchLineVisitor new
		visitPatch: patch;
		yourself.	
	
	lineMarks := visitor lineMarks.

	self 
		setText: visitor contents
		to: aWidget
]

{ #category : #'private accessing' }
SpMorphicPatchAdapter >> setPatchTo: aWidget [

	(self presenter model isNil 
		or: [ self presenter model isEmpty ])
		ifTrue: [  
			self setText: '' to: aWidget. 
			^ self ].
		
	self 
		setPatch: self presenter model patch
		to: aWidget
]

{ #category : #'private accessing' }
SpMorphicPatchAdapter >> setText: text to: aWidget [

	aWidget textArea editingState clearUndoManager: nil.
	aWidget setText: text
]
