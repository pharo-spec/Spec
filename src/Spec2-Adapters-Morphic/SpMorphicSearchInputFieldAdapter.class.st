"
I'm a morphic adapter to provide a search input field
"
Class {
	#name : 'SpMorphicSearchInputFieldAdapter',
	#superclass : 'SpMorphicTextInputFieldAdapter',
	#category : 'Spec2-Adapters-Morphic-Base',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Base'
}

{ #category : 'factory' }
SpMorphicSearchInputFieldAdapter >> buildWidget [
	| textMorph iconsContainer |

	textMorph := super buildWidget.
	textMorph submorphsDo: [ :aMorph | 
		aMorph setProperty: #constraints toValue: SpOverlayConstraints new ].

	iconsContainer := Morph new
		extent: (20@14) scaledByDisplayScaleFactor;
		color: Color transparent;
		changeTableLayout;
		listDirection: #topToBottom;
		borderWidth: 0;
		addMorph: (IconicButtonMorph new
			target: self;
			actionSelector: #clearText;
			labelGraphic: (self iconNamed: #clearField);
			color: Color transparent;
			extent: (14@14) scaledByDisplayScaleFactor;
			borderWidth: 0;
			yourself);
		setProperty: #constraints toValue: (SpOverlayConstraints new
			beOverlay;
			hAlignEnd;
			vAlignCenter;
			yourself);
		yourself.

	textMorph
		layoutPolicy: SpMorphicOverlayLayout new;
		addMorph: iconsContainer.
 "This brings placeholder morph to the front. This is because it is behind the background morph, so if you change the background color from transparent it hides the placeholder"
	textMorph addMorphInFrontOfLayer: textMorph submorphs last.
	^ textMorph
]

{ #category : 'actions' }
SpMorphicSearchInputFieldAdapter >> clearText [

	self text: ''
]
