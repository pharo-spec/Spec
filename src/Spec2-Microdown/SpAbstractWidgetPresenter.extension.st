Extension { #name : #SpAbstractWidgetPresenter }

{ #category : #'*Spec2-Microdown' }
SpAbstractWidgetPresenter class >> buildMicroDownUsing: aBuilder withComment: aString [
	
	super buildMicroDownUsing: aBuilder withComment: aString.

	"Example code"
	self addDocumentSectionExampleCode: aBuilder.
	"Factory method"
	self addDocumentSectionFactoryMethod: aBuilder.
	"Sections"
	self documentSections keysAndValuesDo: [ :label :methods |
		self addDocumentSection: aBuilder label: label methods: methods ].
	"Hook for extra sections"
	self addDocumentExtraSections: aBuilder.
	"Hierarchy"
	self addDocumentSectionHierarchy: aBuilder.
	"Transmissions"
	self addDocumentSectionTransmissions: aBuilder.	
]
