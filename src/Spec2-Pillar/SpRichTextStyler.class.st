Class {
	#name : #SpRichTextStyler,
	#superclass : #SpTextStyler,
	#category : #'Spec2-Pillar'
}

{ #category : #parsing }
SpRichTextStyler >> parse: aString [
	self subclassResponsibility 
]

{ #category : #tests }
SpRichTextStyler >> plaintextFor: aFormatString [
	^  self toPlaintext: (self parse: aFormatString)
]

{ #category : #'as yet unclassified' }
SpRichTextStyler >> toPlaintext: aDocument [
	self subclassResponsibility 
]
