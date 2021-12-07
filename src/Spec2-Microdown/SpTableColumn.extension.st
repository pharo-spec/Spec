Extension { #name : #SpTableColumn }

{ #category : #'*Spec2-Microdown' }
SpTableColumn class >> buildMicroDownUsing: aBuilder withComment: aString [
	
	super buildMicroDownUsing: aBuilder withComment: aString.
	"Sections"
	self documentSections keysAndValuesDo: [ :label :methods |
		SpAbstractWidgetPresenter 
			addDocumentSection: aBuilder 
			label: label 
			methods: methods ].
	"Hierarchy"
	self addDocumentSectionHierarchy: aBuilder.

]
