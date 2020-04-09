Class {
	#name : #SpRichTextPresenter,
	#superclass : #SpTextPresenter,
	#instVars : [
		'#textStyler => SpObservableSlot',
		'#contentProvider => IndexedSlot'
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
SpRichTextPresenter >> contentProvider [
	^ contentProvider ifNil: [ 
		contentProvider := self defaultContentProvider ]
]

{ #category : #accessing }
SpRichTextPresenter >> defaultContentProvider [
	^ SpContentHandler new
]

{ #category : #initialization }
SpRichTextPresenter >> initialize [ 

	super initialize
]

{ #category : #rendering }
SpRichTextPresenter >> renderTree [
	^  SpRenderTreeBuilderVisitor new 
			styleProvider: self styleAttributes;
			render: (PRPillarParser parse: self text)
]

{ #category : #initialization }
SpRichTextPresenter >> styleAttributes [
	^ self contentProvider styles
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
