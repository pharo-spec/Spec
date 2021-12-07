Extension { #name : #SpNotebookPage }

{ #category : #'*Spec2-Microdown' }
SpNotebookPage class >> buildMicroDownUsing: aBuilder withComment: aString [
	
	super buildMicroDownUsing: aBuilder withComment: aString.
	"Factory method"
	self addDocumentSectionFactoryMethod: aBuilder.
	"Sections"
	self documentSections keysAndValuesDo: [ :label :methods |
		SpAbstractWidgetPresenter 
			addDocumentSection: aBuilder 
			label: label 
			methods: methods ]
]
