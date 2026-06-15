"
I convert IconStylerDecoration instances into SpTextPresenterDecorator decorations using the Spec2 text segment API.
"
Class {
	#name : 'SpIconStylerRenderer',
	#superclass : 'IconStylerRenderer',
	#category : 'Spec2-Code-Styler',
	#package : 'Spec2-Code',
	#tag : 'Styler'
}

{ #category : 'rendering' }
SpIconStylerRenderer >> addDecoration: aDecoration [

	textModel addTextSegmentDecoration: (SpTextPresenterDecorator new
			 name: aDecoration name;
			 interval: aDecoration interval;
			 highlightColor: aDecoration highlightColor;
			 underline: aDecoration isUnderline;
			 underlineColor: aDecoration underlineColor;
			 icon: aDecoration icon;
			 iconBlock: aDecoration iconBlock;
			 title: aDecoration title;
			 yourself)
]

{ #category : 'rendering' }
SpIconStylerRenderer >> clearDecorations [

	"do nothing, we do not clean decorations for now"
	"textModel removeAllTextSegmentDecorations"
]
