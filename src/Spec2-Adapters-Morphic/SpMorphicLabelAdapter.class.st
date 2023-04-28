"
I am the adapter used to bridget a LabelPresenter and a LabelMorph
"
Class {
	#name : #SpMorphicLabelAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#category : #'Spec2-Adapters-Morphic-Base'
}

{ #category : #private }
SpMorphicLabelAdapter >> applyDecorationsTo: aString [
	| text |

	text := aString asText.
	self presenter displayColor ifNotNil: [ :block |
		(block cull: aString) ifNotNil: [ :aColor |
		  	text addAttribute: (TextColor color: aColor) ] ].
	self presenter displayBold ifNotNil: [ :block |
		(block cull: aString) ifTrue: [ 
			text addAttribute: TextEmphasis bold ] ].
	self presenter displayItalic ifNotNil: [ :block |
		(block cull: aString) ifTrue: [ 
			text addAttribute: TextEmphasis italic ] ].
	self presenter displayUnderline ifNotNil: [ :block |
		(block cull: aString) ifTrue: [ 
			text addAttribute: TextEmphasis underlined ] ].
	self presenter displayBackgroundColor ifNotNil: [ :block |
		(block cull: aString) ifNotNil: [ :aColor |
		  	text addAttribute: (TextBackgroundColor color: aColor) ] ].
	
	^ text
]

{ #category : #styling }
SpMorphicLabelAdapter >> applyStyle: aMorph [

	aMorph fitContents.
	super applyStyle: aMorph.
	"when changing a font and affecting his size, it may happen than the result font 
	 height is smaller than current height of morph, we need to take care about this 
	 even if this means we cannot have a label smaller than the font :("
	aMorph height < aMorph font height
		ifTrue: [ aMorph height: aMorph font height ]
]

{ #category : #factory }
SpMorphicLabelAdapter >> buildWidget [

	| label |
	label := LabelMorph new model: self.
	label
		getEnabledSelector: #enabled;
		getTextSelector: #getText;
		vResizing: #shrinkWrap;
		hResizing: #spaceFill;
		dragEnabled: self dragEnabled;
		dropEnabled: self dropEnabled;
		setBalloonText: self getHelpText;
		setProperty: #minWidth toValue: 3. "3 is the default value of StringMorph. We do not want the default value of LabelMorph that is the min width of the content..."

	^ label
]

{ #category : #private }
SpMorphicLabelAdapter >> getHelpText [

	^ self presenter help ifNotNil: [ :aString | aString localizedForPresenter: self presenter ]
]

{ #category : #'model access' }
SpMorphicLabelAdapter >> getText [

	^ self presenter label
		ifNotNil: [ :aString | 
			self applyDecorationsTo: (aString localizedForPresenter: self presenter) ]
]

{ #category : #accessing }
SpMorphicLabelAdapter >> label [
	
	^ widget contents
]
