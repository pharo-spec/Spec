Class {
	#name : #SpFontStyleTest,
	#superclass : #TestCase,
	#category : #'Spec2-Adapters-Morphic-Tests'
}

{ #category : #tests }
SpFontStyleTest >> testResetFont [
	| styleSheet app presenter font |

	font := LogicalFont familyName: 'Source Code Pro' pointSize: 52.
	
	styleSheet := SpStyleVariableSTONReader fromString: ' 
.application [
	Font { #name : EnvironmentFont(#default) },	
	.morph [ Font { #name : Reset } ] ] '.


	app := SpApplication new.
	app styleSheet: styleSheet.
	
	presenter := SpMorphPresenter new 
		application: app;
		yourself.
		
	presenter morph: (RubScrolledTextMorph new 
			setText: ('foo' asText
				addAttribute: ((TextFontReference toFont: font))) ;
			in: [ :this | this textArea readOnly: true ];
			yourself).
			
	presenter buildWithSpec.
	
	self assert: (presenter morph text fontAt: 1) familyName equals: font familyName.
	self assert: (presenter morph text fontAt: 1) pointSize equals: font pointSize
]
