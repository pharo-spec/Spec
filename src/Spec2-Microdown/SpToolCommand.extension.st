Extension { #name : #SpToolCommand }

{ #category : #'*Spec2-Microdown' }
SpToolCommand class >> buildMicroDownUsing: aBuilder withComment: aString [
	
	super buildMicroDownUsing: aBuilder withComment: aString.
	self addDocumentContextRequiredSelectors: aBuilder
]
