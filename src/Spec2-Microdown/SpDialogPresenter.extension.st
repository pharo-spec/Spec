Extension { #name : #SpDialogPresenter }

{ #category : #'*Spec2-Microdown' }
SpDialogPresenter class >> buildMicroDownUsing: aBuilder withComment: aString [
	
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
