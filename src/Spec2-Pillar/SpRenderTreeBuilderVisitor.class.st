Class {
	#name : #SpRenderTreeBuilderVisitor,
	#superclass : #PRVisitor,
	#instVars : [
		'styleProvider'
	],
	#category : #'Spec2-Pillar'
}

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> processGroup: anObject [
	| children |
	children := super visitDocumentGroup: anObject.
	(children allSatisfy: [ :each | each isKindOf: SpRenderObject ]) ifFalse: [ 
		self halt ].
	^ SpCompositeRenderObject new
		item: anObject;
		styles: (styleProvider computedStylesFor: anObject);
		children: children
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> render: aPRDocument [ 
	^ self visitDocument: aPRDocument 
]

{ #category : #accessing }
SpRenderTreeBuilderVisitor >> styleProvider: aPRStyleProvider [ 
	styleProvider := aPRStyleProvider
]

{ #category : #visiting }
SpRenderTreeBuilderVisitor >> visitAll: aCollection [
	^aCollection collect: [ :each | | i |
		i := self visit: each.
		(i isKindOf: SpRenderObject) ifFalse: [ 
			self halt. ].
		i ]
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitAnchor: anObject [

	self flag: #todo.
	^ self visitDocumentItem: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitAnnotatedParagraph: aDocument [

	^ self visitParagraph: aDocument
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitAnnotation: anAnnotation [
	"Visiting an annotation means that we visit the textual representation of an annotation. Such annotations will be transformed into annotation object. The corresponding visit method will be invoked on such object : visitCitationAnnotation vs visitCitation."
		self halt.

	^ self visitDocumentGroup: anAnnotation
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitBeginEnvironmentAnnotation: aBeginEnvironmentAnnotation [
	"Visiting an annotation means that we visit the textual representation of an annotation. Such annotations will be transformed into annotation object. The corresponding visit method will be invoked on such object : visitBeginEnvironmentAnnotation vs visitBeginEnvironment."
		self halt.

	^ self visitAnnotation: aBeginEnvironmentAnnotation
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitBoldFormat: anObject [

	^ self processGroup: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitCitation: aCitation [
	
	self halt.
	^ self visitDocumentItem: aCitation
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitCitationAnnotation: aCitation [
	"Visiting an annotation means that we visit the textual representation of an annotation. Such annotations will be transformed into annotation object. The corresponding visit method will be invoked on such object : visitCitationAnnotation vs visitCitation."
		self halt.

	^ self visitAnnotation: aCitation
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitCodeblock: aCodeBlock [ 

	^ self visitText: aCodeBlock
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitColumn: aColumn [
	self halt.

	^ self visitDocumentGroup: aColumn
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitColumnAnnotation: aColumnAnnotation [
	"Visiting an annotation means that we visit the textual representation of an annotation. Such annotations will be transformed into annotation object. The corresponding visit method will be invoked on such object : visitColumnAnnotation vs visitColumn."
		self halt.

	^ self visitAnnotation: aColumnAnnotation
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitColumns: aColumns [
	self halt.

	^ self visitDocumentGroup: aColumns
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitColumnsAnnotation: aColumnsAnnotation [
	"Visiting an annotation means that we visit the textual representation of an annotation. Such annotations will be transformed into annotation object. The corresponding visit method will be invoked on such object : visitColumnsAnnotation vs visitColumns."
		self halt.

	^ self visitAnnotation: aColumnsAnnotation
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitCommentedLine: aCommentedLine [
		self halt.


]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitDataItem: anObject [

	^ self visitListItem: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitDefinitionList: anObject [

	^ self visitList: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitDocListAnnotation: aPRDocListAnnotation [ 
	self halt.

	^ self visitAnnotation: aPRDocListAnnotation
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitDocument: anObject [
	
	^ self processGroup: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitDocumentGroup: anObject [
	^ SpCompositeRenderObject new
		item: anObject;
		styles: (styleProvider computedStylesFor: anObject);
		children: (super visitDocumentGroup: anObject)
]

{ #category : #'visiting-document' }
SpRenderTreeBuilderVisitor >> visitDocumentItem: anObject [
	^ SpTextRenderObject new
		item: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitEmptyParagraph: anObject [
	^ self processGroup: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitEndColumnsAnnotation: aEndColumnsAnnotation [
	self halt.

	^ self visitAnnotation: aEndColumnsAnnotation
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitEndEnvironmentAnnotation:  anObject [
		self halt
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitEnvironment: anObject [
	"An environment object has been created based on the begin and end annotations.
	My subclasses may want to introduce a preAction and postAction triggering. By default just visit all children."
		self halt.

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitExternalLink: anObject [

	^ self visitLink: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitFigure: anObject [

	^ self visitReference: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitFootnote: aFootnote [
	self halt.

	^ self visitDocumentItem: aFootnote
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitFootnoteAnnotation: aFootnoteAnnotation [
	"Visiting an annotation means that we visit the textual representation of an annotation. Such annotations will be transformed into annotation object. The corresponding visit method will be invoked on such object : visitFootnoteAnnotation vs visitFootnote."
		self halt.

	^ self visitAnnotation: aFootnoteAnnotation
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitFormat: anObject [

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitHeader: anObject [

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitHorizontalRule: anObject [
	self halt.

	^ self visitDocumentItem: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitInputFileAnnotation: aNobject [
		self halt
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitInternalLink: anObject [

	self flag: #todo.
	^ self visitLink: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitItalicFormat: anObject [

	^ self visitFormat: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitLineBreak: anObject [

	self flag: #todo.
	^ SpTextRenderObject new
		item: anObject.
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitLink: anObject [

	self flag: #todo.
	^ self visitReference: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitList: anObject [

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitListItem: anObject [

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitMailLink: anObject [

	^ self visitExternalLink: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitMonospaceFormat: anObject [

	^ self visitFormat: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitOrderedList: anObject [

	^ self visitList: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitParagraph: anObject [

	^ self processGroup: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitParameter: anObject [
	self halt.

	^ self visitDocumentGroup: anObject 
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitParameterKey: anObject [
		self halt
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitParameterValue: anObject [
	self halt.

	^ self visitDocumentItem: anObject 
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitParameters: anObject [
	self halt.

	^ self visitDocumentGroup: anObject 
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitPreformatted: anObject [

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitRaw: aRaw [
	self halt.

	^ self visitText: aRaw
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitReference: anObject [

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitSection: aSection [
	self halt.

	^ self visitDocumentGroup: aSection
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitSlide: aSlide [
	self halt.

	^ self visitDocumentGroup: aSlide
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitSlideTitleAnnotation: aSlideTitleAnnotation [
	"Visiting an annotation means that we visit the textual representation of an annotation. Such annotations will be transformed into annotation object. The corresponding visit method will be invoked on such object : visitSlideTitleAnnotation vs visitSlide."
		self halt.

	^ self visitAnnotation: aSlideTitleAnnotation
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitStrikethroughFormat: anObject [

	^ self visitFormat: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitSubscriptFormat: anObject [

	^ self visitFormat: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitSuperscriptFormat: anObject [

	^ self visitFormat: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitTOCAnnotation: aTOCAnnotation [
	self halt.

	^ self visitAnnotation: aTOCAnnotation
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitTable: anObject [

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitTableCell: anObject [
	self halt.

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitTableRow: aRow [

	self flag: #todo.
	^ SpTextRenderObject new
		item: aRow;
		yourself 
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitTermItem: anObject [

	^ self visitListItem: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitText: anObject [
	^ SpTextRenderObject new
		item: anObject.

]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitUndefinedAnnotation: aUndefinedAnnotation [
	"Visiting an annotation means that we visit the textual representation of an annotation. Such annotations will be transformed into annotation object. The corresponding visit method will be invoked on such object : visitFootnoteAnnotation vs visitFootnote."
		self halt.

	^ self visitAnnotation: aUndefinedAnnotation
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitUnderlineFormat: anObject [

	^ self visitFormat: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitUnorderedList: anObject [
	^ self visitList: anObject
]
