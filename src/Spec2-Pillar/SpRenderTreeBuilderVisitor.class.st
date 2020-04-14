"
I'm a render visitor that combines a pillar document items and computed styles. The render tree consists of all visible document items based on the type in pillar and the associated styles. 
"
Class {
	#name : #SpRenderTreeBuilderVisitor,
	#superclass : #PRVisitor,
	#instVars : [
		'styleProvider'
	],
	#category : #'Spec2-Pillar'
}

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> render: aPRDocument [ 
	^ self visitDocument: aPRDocument 
]

{ #category : #accessing }
SpRenderTreeBuilderVisitor >> styleProvider: aPRStyleProvider [ 
	styleProvider := aPRStyleProvider
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
SpRenderTreeBuilderVisitor >> visitPreformatted: anObject [

	^ self visitDocumentGroup: anObject
]

{ #category : #'as yet unclassified' }
SpRenderTreeBuilderVisitor >> visitText: anObject [
	^ SpTextRenderObject new
		item: anObject.

]
