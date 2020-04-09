Extension { #name : #PRDocumentItem }

{ #category : #'*Spec2-Pillar' }
PRDocumentItem >> plaintextAppendix [
	^  nil
]

{ #category : #'*Spec2-Pillar' }
PRDocumentItem >> plaintextNewline [
	^  String cr
]

{ #category : #'*Spec2-Pillar' }
PRDocumentItem >> plaintextOffset [
	^ self plaintextAppendix 
		ifNotNil: [ :appendix | appendix size ]
		ifNil: [  0 ]
]

{ #category : #'*Spec2-Pillar' }
PRDocumentItem >> styleName [ 
	self subclassResponsibility 
]
