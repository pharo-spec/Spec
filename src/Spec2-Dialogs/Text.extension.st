Extension { #name : 'Text' }

{ #category : '*Spec2-Dialogs' }
Text >> lineHeightsWrappingAtWidth: aMaxWidth [ 
	
	| lineWidth maxLineHeight font |
	
	lineWidth := 0.
	maxLineHeight := 0.
		
	^ Array streamContents: [ :stream | 
		self withIndexDo: [ :aCharacter :anIndex |
				font := self fontAt: anIndex.
				lineWidth := lineWidth + (font widthOf: aCharacter).
				
				(lineWidth > aMaxWidth or: [ aCharacter = Character cr ])
					ifTrue: [ 
						stream nextPut: maxLineHeight.
						lineWidth := font widthOf: aCharacter.
					].
				
				maxLineHeight := maxLineHeight max: font height.
			 ].
		
		stream nextPut: maxLineHeight
		]
]
