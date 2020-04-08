Class {
	#name : #PRRenderTreeBuilderVisitor,
	#superclass : #PRVisitor,
	#instVars : [
		'styleProvider'
	],
	#category : #'Spec2-Pillar'
}

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> processGroup: anObject [
	| children |
	children := super visitDocumentGroup: anObject.
	(children allSatisfy: [ :each | each isKindOf: PRRenderObject ]) ifFalse: [ 
		self halt ].
	^ PRCompositeRenderObject new
		item: anObject;
		styles: (styleProvider computedStylesFor: anObject);
		children: children
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> render: aPRDocument [ 
	^ self visitDocument: aPRDocument 
]

{ #category : #accessing }
PRRenderTreeBuilderVisitor >> styleProvider: aPRStyleProvider [ 
	styleProvider := aPRStyleProvider
]

{ #category : #visiting }
PRRenderTreeBuilderVisitor >> visitAll: aCollection [
	^aCollection collect: [ :each | | i |
		i := self visit: each.
		(i isKindOf: PRRenderObject) ifFalse: [ 
			self halt. ].
		i ]
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitAnchor: anObject [

	self flag: #todo.
	^ self visitDocumentItem: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitAnnotatedParagraph: aDocument [

	^ self visitParagraph: aDocument
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitAnnotation: anAnnotation [
	"Visiting an annotation means that we visit the textual representation of an annotation. Such annotations will be transformed into annotation object. The corresponding visit method will be invoked on such object : visitCitationAnnotation vs visitCitation."
		self halt.

	^ self visitDocumentGroup: anAnnotation
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitBeginEnvironmentAnnotation: aBeginEnvironmentAnnotation [
	"Visiting an annotation means that we visit the textual representation of an annotation. Such annotations will be transformed into annotation object. The corresponding visit method will be invoked on such object : visitBeginEnvironmentAnnotation vs visitBeginEnvironment."
		self halt.

	^ self visitAnnotation: aBeginEnvironmentAnnotation
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitBoldFormat: anObject [

	^ self processGroup: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitCitation: aCitation [
	
	self halt.
	^ self visitDocumentItem: aCitation
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitCitationAnnotation: aCitation [
	"Visiting an annotation means that we visit the textual representation of an annotation. Such annotations will be transformed into annotation object. The corresponding visit method will be invoked on such object : visitCitationAnnotation vs visitCitation."
		self halt.

	^ self visitAnnotation: aCitation
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitCodeblock: aCodeBlock [ 

	^ self visitText: aCodeBlock
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitColumn: aColumn [
	self halt.

	^ self visitDocumentGroup: aColumn
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitColumnAnnotation: aColumnAnnotation [
	"Visiting an annotation means that we visit the textual representation of an annotation. Such annotations will be transformed into annotation object. The corresponding visit method will be invoked on such object : visitColumnAnnotation vs visitColumn."
		self halt.

	^ self visitAnnotation: aColumnAnnotation
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitColumns: aColumns [
	self halt.

	^ self visitDocumentGroup: aColumns
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitColumnsAnnotation: aColumnsAnnotation [
	"Visiting an annotation means that we visit the textual representation of an annotation. Such annotations will be transformed into annotation object. The corresponding visit method will be invoked on such object : visitColumnsAnnotation vs visitColumns."
		self halt.

	^ self visitAnnotation: aColumnsAnnotation
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitCommentedLine: aCommentedLine [
		self halt.


]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitDataItem: anObject [

	^ self visitListItem: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitDefinitionList: anObject [

	^ self visitList: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitDocListAnnotation: aPRDocListAnnotation [ 
	self halt.

	^ self visitAnnotation: aPRDocListAnnotation
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitDocument: anObject [
	
	^ self processGroup: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitDocumentGroup: anObject [
	^ PRCompositeRenderObject new
		item: anObject;
		styles: (styleProvider computedStylesFor: anObject);
		children: (super visitDocumentGroup: anObject)
]

{ #category : #'visiting-document' }
PRRenderTreeBuilderVisitor >> visitDocumentItem: anObject [
	^ PRTextRenderObject new
		item: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitEmptyParagraph: anObject [
	^ self processGroup: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitEndColumnsAnnotation: aEndColumnsAnnotation [
	self halt.

	^ self visitAnnotation: aEndColumnsAnnotation
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitEndEnvironmentAnnotation:  anObject [
		self halt
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitEnvironment: anObject [
	"An environment object has been created based on the begin and end annotations.
	My subclasses may want to introduce a preAction and postAction triggering. By default just visit all children."
		self halt.

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitExternalLink: anObject [

	^ self visitLink: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitFigure: anObject [

	^ self visitReference: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitFootnote: aFootnote [
	self halt.

	^ self visitDocumentItem: aFootnote
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitFootnoteAnnotation: aFootnoteAnnotation [
	"Visiting an annotation means that we visit the textual representation of an annotation. Such annotations will be transformed into annotation object. The corresponding visit method will be invoked on such object : visitFootnoteAnnotation vs visitFootnote."
		self halt.

	^ self visitAnnotation: aFootnoteAnnotation
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitFormat: anObject [

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitHeader: anObject [

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitHorizontalRule: anObject [
	self halt.

	^ self visitDocumentItem: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitInputFileAnnotation: aNobject [
		self halt
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitInternalLink: anObject [

	self flag: #todo.
	^ self visitLink: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitItalicFormat: anObject [

	^ self visitFormat: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitLineBreak: anObject [

	self flag: #todo.
	^ PRTextRenderObject new
		item: anObject.
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitLink: anObject [

	self flag: #todo.
	^ self visitReference: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitList: anObject [

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitListItem: anObject [

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitMailLink: anObject [

	^ self visitExternalLink: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitMonospaceFormat: anObject [

	^ self visitFormat: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitOrderedList: anObject [

	^ self visitList: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitParagraph: anObject [

	^ self processGroup: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitParameter: anObject [
	self halt.

	^ self visitDocumentGroup: anObject 
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitParameterKey: anObject [
		self halt
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitParameterValue: anObject [
	self halt.

	^ self visitDocumentItem: anObject 
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitParameters: anObject [
	self halt.

	^ self visitDocumentGroup: anObject 
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitPreformatted: anObject [

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitRaw: aRaw [
	self halt.

	^ self visitText: aRaw
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitReference: anObject [

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitSection: aSection [
	self halt.

	^ self visitDocumentGroup: aSection
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitSlide: aSlide [
	self halt.

	^ self visitDocumentGroup: aSlide
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitSlideTitleAnnotation: aSlideTitleAnnotation [
	"Visiting an annotation means that we visit the textual representation of an annotation. Such annotations will be transformed into annotation object. The corresponding visit method will be invoked on such object : visitSlideTitleAnnotation vs visitSlide."
		self halt.

	^ self visitAnnotation: aSlideTitleAnnotation
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitStrikethroughFormat: anObject [

	^ self visitFormat: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitSubscriptFormat: anObject [

	^ self visitFormat: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitSuperscriptFormat: anObject [

	^ self visitFormat: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitTOCAnnotation: aTOCAnnotation [
	self halt.

	^ self visitAnnotation: aTOCAnnotation
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitTable: anObject [

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitTableCell: anObject [
	self halt.

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitTableRow: aRow [

	self flag: #todo.
	^ PRTextRenderObject new
		item: aRow;
		yourself 
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitTermItem: anObject [

	^ self visitListItem: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitText: anObject [
	^ PRTextRenderObject new
		item: anObject.

]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitUndefinedAnnotation: aUndefinedAnnotation [
	"Visiting an annotation means that we visit the textual representation of an annotation. Such annotations will be transformed into annotation object. The corresponding visit method will be invoked on such object : visitFootnoteAnnotation vs visitFootnote."
		self halt.

	^ self visitAnnotation: aUndefinedAnnotation
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitUnderlineFormat: anObject [

	^ self visitFormat: anObject
]

{ #category : #'as yet unclassified' }
PRRenderTreeBuilderVisitor >> visitUnorderedList: anObject [
	^ self visitList: anObject
]
