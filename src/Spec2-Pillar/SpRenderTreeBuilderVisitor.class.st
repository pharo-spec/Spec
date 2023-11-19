"
I'm a render visitor that combines a pillar document items and computed styles. The render tree consists of all visible document items based on the type in pillar and the associated styles. 
"
Class {
	#name : 'SpRenderTreeBuilderVisitor',
	#superclass : 'PRVisitor',
	#instVars : [
		'styleProvider',
		'current'
	],
	#category : 'Spec2-Pillar',
	#package : 'Spec2-Pillar'
}

{ #category : 'initialization' }
SpRenderTreeBuilderVisitor >> initialize [
	super initialize.
	current := OrderedCollection new
]

{ #category : 'rendering' }
SpRenderTreeBuilderVisitor >> render: aPRDocument [ 
	^ self visitDocument: aPRDocument 
]

{ #category : 'accessing' }
SpRenderTreeBuilderVisitor >> styleProvider: aPRStyleProvider [ 
	styleProvider := aPRStyleProvider
]

{ #category : 'visiting-document' }
SpRenderTreeBuilderVisitor >> visitDocument: aDocument [
	current := SpCompositeRenderObject new item: aDocument.
	super visitDocumentGroup: aDocument.
	^ current
]

{ #category : 'visiting-document' }
SpRenderTreeBuilderVisitor >> visitDocumentGroup: anObject [
	| previous |
	previous := current.
	[ 
		current := SpCompositeRenderObject new
			item: anObject;
			styles: (styleProvider computedStylesFor: anObject).
		previous add: current.
		
		super visitDocumentGroup: anObject ]
		ensure: [ current := previous ]
]

{ #category : 'visiting-document' }
SpRenderTreeBuilderVisitor >> visitDocumentItem: anObject [
	current add: (SpTextRenderObject new item: anObject)
]

{ #category : 'visiting-document' }
SpRenderTreeBuilderVisitor >> visitText: anObject [
	current add: (SpTextRenderObject new
		item: anObject)

]
