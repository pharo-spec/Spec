Class {
	#name : 'SpMorphicDiffUnifiedAdapter',
	#superclass : 'SpMorphicDiffAdapter',
	#category : 'Spec2-Adapters-Morphic-Base',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Base'
}

{ #category : 'factory' }
SpMorphicDiffUnifiedAdapter >> buildWidget [

	^ SpUnifiedDiffChangesMorph new
		  on: self;
		  from: self leftText
		  to: self rightText
		  contextClass: self contextClass;
		  hResizing: #spaceFill;
		  vResizing: #spaceFill;
		  setBalloonText: self help;
		  showOptions: self showOptions;
		  leftLabel: self leftLabel rightLabel: self rightLabel;
		  showOnlyDestination: self showOnlyDestination;
		  yourself
]
