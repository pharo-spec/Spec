Class {
	#name : #SpRichTextPresenter,
	#superclass : #SpAbstractTextPresenter,
	#instVars : [
		'#textStyler => SpObservableSlot'
	],
	#category : #'Spec2-Core-Widgets-Text'
}

{ #category : #specs }
SpRichTextPresenter class >> adapterName [

	^ #RichTextAdapter
]

{ #category : #examples }
SpRichTextPresenter class >> example [
	<sampleInstance>

	^ self new
	 openWithSpec;
		text:
			'some method: 42'

]

{ #category : #specs }
SpRichTextPresenter class >> title [

	^ 'Rich Text'
]

{ #category : #accessing }
SpRichTextPresenter >> defaultTextStyler [
	self subclassResponsibility 
]

{ #category : #initialization }
SpRichTextPresenter >> initialize [ 

	super initialize
]

{ #category : #rendering }
SpRichTextPresenter >> parseRaw: aFormatString [
	self subclassResponsibility 
]

{ #category : #rendering }
SpRichTextPresenter >> renderTree [
	^  SpRenderTreeBuilderVisitor new 
			styleProvider: self styleAttributes;
			render: (self parseRaw: self text)
]

{ #category : #initialization }
SpRichTextPresenter >> styleAttributes [
	^ self textStyler styles
]

{ #category : #accessing }
SpRichTextPresenter >> textStyler [

	^ textStyler
]

{ #category : #accessing }
SpRichTextPresenter >> textStyler: aTextStyler [

	textStyler := aTextStyler
]

{ #category : #'api-events' }
SpRichTextPresenter >> whenTextStylerChangedDo: aBlock [

	self property: #textStyler whenChangedDo: aBlock
]
