Class {
	#name : 'SpFontStyleTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Adapters-Morphic-Tests',
	#package : 'Spec2-Adapters-Morphic-Tests'
}

{ #category : 'tests' }
SpFontStyleTest >> testBoldFontDoesNotChangeSharedRegularFont [

	| style regularFont boldFont |
	style := SpFontStyle new
		name: StandardFonts defaultFont familyName;
		size: 13;
		bold: true;
		yourself.
	"A regular font with the same family and size, shared through LogicalFont registry"
	regularFont := LogicalFont
		familyName: style name
		pointSize: style scaledSize.

	boldFont := style definedFont.

	self assert: boldFont isBold.
	self deny: regularFont isBold
]

{ #category : 'tests' }
SpFontStyleTest >> testItalicFontDoesNotChangeSharedRegularFont [

	| style regularFont italicFont |
	style := SpFontStyle new
		name: StandardFonts defaultFont familyName;
		size: 13;
		italic: true;
		yourself.
	"A regular font with the same family and size, shared through LogicalFont registry"
	regularFont := LogicalFont
		familyName: style name
		pointSize: style scaledSize.

	italicFont := style definedFont.

	self assert: italicFont isItalic.
	self deny: regularFont isItalic
]

{ #category : 'tests' }
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
			 setText:
				 ('foo' asText addAttribute: (TextFontReference toFont: font));
			 in: [ :this | this textArea readOnly: true ];
			 yourself).

	presenter build.

	self
		assert: (presenter morph text fontAt: 1) familyName
		equals: font familyName.
	self
		assert: (presenter morph text fontAt: 1) pointSize
		equals: font pointSize
]
