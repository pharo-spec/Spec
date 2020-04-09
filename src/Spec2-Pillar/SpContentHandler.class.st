Class {
	#name : #SpContentHandler,
	#superclass : #Object,
	#category : #'Spec2-Pillar'
}

{ #category : #parsing }
SpContentHandler >> parse: aString [
	self subclassResponsibility 
]

{ #category : #tests }
SpContentHandler >> plaintextFor: aFormatString [
	^  self toPlaintext: (self parse: aFormatString)
]

{ #category : #'as yet unclassified' }
SpContentHandler >> toPlaintext: aDocument [
	self subclassResponsibility 
]
