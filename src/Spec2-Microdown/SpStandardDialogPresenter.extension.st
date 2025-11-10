Extension { #name : 'SpStandardDialogPresenter' }

{ #category : '*Spec2-Microdown' }
SpStandardDialogPresenter class >> buildMicroDownUsing: aBuilder withComment: aString [
	
	super buildMicroDownUsing: aBuilder withComment: aString.
	"Example code"
	self addDocumentSectionExampleCode: aBuilder.
	"Factory method"
	self addDocumentSectionFactoryMethod: aBuilder.
	"Sections"
	self documentSections keysAndValuesDo: [ :label :methods |
		self addDocumentSection: aBuilder label: label methods: methods ].
	"Hierarchy"
	"self addDocumentSectionHierarchy: aBuilder."

]
