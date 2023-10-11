Extension { #name : 'SpExecutableLayout' }

{ #category : '*Spec2-Microdown' }
SpExecutableLayout class >> buildMicroDownUsing: aBuilder withComment: aString [
	
	super buildMicroDownUsing: aBuilder withComment: aString.
	"Sections"
	self documentSections keysAndValuesDo: [ :label :methods |
		self addDocumentSection: aBuilder label: label methods: methods ].
	"Hierarchy"
	self addDocumentSectionHierarchy: aBuilder.
	
]
