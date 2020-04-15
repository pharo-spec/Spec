Class {
	#name : #SpRichTextStyler,
	#superclass : #SpTextStyler,
	#category : #'Spec2-Pillar'
}

{ #category : #parsing }
SpRichTextStyler >> parseFormatString: formatString [
	self subclassResponsibility 
]

{ #category : #writing }
SpRichTextStyler >> writeFormatString: aDocument [
	self subclassResponsibility 
]

{ #category : #writing }
SpRichTextStyler >> writePlaintextString: aDocument [
	self subclassResponsibility 
]
