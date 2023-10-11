Extension { #name : 'SpStyleEnvironmentVariable' }

{ #category : '*Spec2-Microdown' }
SpStyleEnvironmentVariable class >> buildMicroDownUsing: aBuilder withComment: aString [
	
	super buildMicroDownUsing: aBuilder withComment: aString.
	self addDocumentExample: aBuilder.
	self addDocumentValidValues: aBuilder	

]
