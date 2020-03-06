"
I am the bridge between a TreeColumnPresenter and a MorphTreeColumn.

Ialso add support for on the fly refresh
"
Class {
	#name : #SpMorphicTreeColumnAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#category : #'Spec2-Deprecated-Adapters'
}

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter class >> isDeprecated [ 

	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter >> argumentBlock [

	^ [ Array with: self model ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter >> buildWidget [
	^ SpTreeColumn new
		resizable: self resizable;
		startWidth: self initialWidth;
		setHeaderButtonLabel: self headerLabel
			font: self headerFont
			icon: self headerIcon
			target: self
			actionSelector: self performHeaderActionSelector;
		rowMorphGetSelector: self displayBlock
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter >> displayBlock [

	^ self model displayBlock
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter >> displayBlockChanged [

	self widgetDo: [ :w | 
		w rowMorphGetSelector: self displayBlock.
		w container updateList ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter >> headerAction [

	^ self model headerAction
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter >> headerFont [

	^ self model headerFont
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter >> headerFontChanged [
	
	self widgetDo: [ :w | 
		w header label: self headerLabel font: self headerFont.
		w container resizerChanged ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter >> headerIcon [

	^ self model headerIcon
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter >> headerIconChanged [
	
	self widgetDo: [ :w | 
		self headerIcon
			ifNil: [ w header removeIcon ]
			ifNotNil: [ w header icon: (ImageMorph new form: self headerIcon) ] ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter >> headerLabel [

	^ self model headerLabel
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter >> headerLabelChanged [
	
	self widgetDo: [ :w | 
		w header label: self headerLabel.
		w container resizerChanged ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter >> initialWidth [

	^ self model initialWidth
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter >> performHeaderAction [

	self headerAction cull: self model cull: self
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter >> performHeaderActionSelector [

	^ self headerAction
		ifNil: [ nil ]
		ifNotNil: [ #performHeaderAction ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter >> resizable [

	^ self model resizable
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter >> resizableChanged [
	
	self widgetDo: [ :w | w resizable: self resizable ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeColumnAdapter >> update: aSymbol [

	aSymbol == #displayBlockChanged ifTrue: [ ^ self displayBlockChanged ].
	aSymbol == #resizableChanged ifTrue: [ ^ self resizableChanged ].
	aSymbol == #headerLabelChanged ifTrue: [ ^ self headerLabelChanged ].
	aSymbol == #headerFontChanged ifTrue: [ ^ self headerFontChanged ].
	aSymbol == #headerIconChanged  ifTrue: [ ^ self headerIconChanged ].
	
	^ super update: aSymbol
]
