Extension { #name : #String }

{ #category : #'*Spec2-Core' }
String >> accentuateCharacter: aCharacter [

	| text index | 
	text := self asText.
	aCharacter ifNil: [ ^ text ].
	index := self asLowercase indexOf: aCharacter asLowercase.
	index isZero
		ifTrue: [ ^ text ].

	^ text
		addAttribute: TextEmphasis underlined from: index to: index;
		yourself
]

{ #category : #'*Spec2-Core' }
String >> asPresenter [ 

	^ SpLabelPresenter new 
		label: self;
		yourself
]

{ #category : #'*Spec2-Core' }
String >> valueForPresenter: aPresenter [

	^ self
]
