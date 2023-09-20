Extension { #name : 'String' }

{ #category : '*Spec2-Adapters-Morphic' }
String >> withAccentuatedCharacter: aKey [

	| text index | 
	text := self asText.
	aKey ifNil: [ ^ text ].
	index := self asLowercase indexOf: aKey name asLowercase.
	index isZero
		ifTrue: [ ^ text ].

	^ text
		addAttribute: TextEmphasis underlined from: index to: index;
		yourself
]
