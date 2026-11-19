"
I am the adapter used to bridge a LabelPresenter and a LabelMorph.
A LabelMorph shows one line: when the presenter wraps (see `SpLabelPresenter>>#beWrap`), I use a `SpWrappingLabelMorph` instead, and replace one by the other when wrapping changes.
"
Class {
	#name : 'SpMorphicLabelAdapter',
	#superclass : 'SpAbstractMorphicAdapter',
	#category : 'Spec2-Adapters-Morphic-Base',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Base'
}

{ #category : 'private' }
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
	self presenter displayStrikethrough ifNotNil: [ :block |
		(block cull: aString) ifTrue: [ 
			text addAttribute: TextEmphasis struckOut ] ].
	"this in fact does not work (background in LabelMorph objects). 
	 See applyStyle instead"
	self presenter displayBackgroundColor ifNotNil: [ :block |
		(block cull: aString) ifNotNil: [ :aColor |
		  	text addAttribute: (TextBackgroundColor color: aColor) ] ].
	
	^ text
]

{ #category : 'styling' }
SpMorphicLabelAdapter >> applyStyle: aMorph [

	aMorph fitContents.
	super applyStyle: aMorph.
	"when changing a font and affecting his size, it may happen than the result font 
	 height is smaller than current height of morph, we need to take care about this 
	 even if this means we cannot have a label smaller than the font :("
	aMorph height < aMorph font height ifTrue: [ aMorph height: aMorph font height ].

	"I need to check background here because a LabelMorph is uncapable of apply a 
	 background color (because meh... morphic+polymorph)"
	self presenter displayBackgroundColor ifNotNil: [ :block |
		(block cull: self presenter label) ifNotNil: [ :aColor | aMorph backgroundColor: aColor ] ]
]

{ #category : 'testing' }
SpMorphicLabelAdapter >> backgroundColor [

	^ self widget backgroundColor
]

{ #category : 'accessing' }
SpMorphicLabelAdapter >> beJustifyCenter [
]

{ #category : 'accessing' }
SpMorphicLabelAdapter >> beJustifyLeft [
	
]

{ #category : 'accessing' }
SpMorphicLabelAdapter >> beJustifyRight [
]

{ #category : 'factory' }
SpMorphicLabelAdapter >> buildWidget [

	self presenter whenWrapChangedDo: [ self updateWrap ].
	self presenter whenLabelChangedDo: [ self updateWrappingLabelText ].
	self presenter whenHelpChangedDo: [ :newHelp | self setBalloonText: newHelp ].

	^ self newWidget
]

{ #category : 'accessing' }
SpMorphicLabelAdapter >> enabled: aBoolean [

	self widget ifNil: [ ^ self ].
	"TextMorph>>#enabled: true recolours the whole text, losing the label decorations: 
	 a wrapping label gets its decorated text again instead"
	self widget isTextMorph ifTrue: [ ^ self updateWrappingLabelText ].

	self widget enabled: aBoolean
]

{ #category : 'private' }
SpMorphicLabelAdapter >> getHelpText [

	^ self presenter help ifNotNil: [ :aString | aString localizedForPresenter: self presenter ]
]

{ #category : 'model access' }
SpMorphicLabelAdapter >> getText [

	^ self presenter label
		ifNotNil: [ :aString | 
			self applyDecorationsTo: (aString localizedForPresenter: self presenter) ]
]

{ #category : 'accessing' }
SpMorphicLabelAdapter >> label [
	
	^ widget contents
]

{ #category : 'factory' }
SpMorphicLabelAdapter >> newLabelMorph [

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

{ #category : 'factory' }
SpMorphicLabelAdapter >> newWidget [

	^ self presenter isWrap
		  ifTrue: [ self newWrappingLabelMorph ]
		  ifFalse: [ self newLabelMorph ]
]

{ #category : 'factory' }
SpMorphicLabelAdapter >> newWrappingLabelMorph [
	"A LabelMorph shows one line: wrapping needs a morph that lays out its text over several lines."

	| label |
	label := SpWrappingLabelMorph new.
	label
		contents: (self getText ifNil: [ '' ]);
		vResizing: #shrinkWrap;
		hResizing: #spaceFill;
		dragEnabled: self dragEnabled;
		dropEnabled: self dropEnabled;
		setBalloonText: self getHelpText.
	self enabled ifFalse: [ label enabled: false ].

	^ label
]

{ #category : 'testing' }
SpMorphicLabelAdapter >> numberOfLines [

	^ widget isTextMorph
		  ifTrue: [ widget paragraph numberOfLines ]
		  ifFalse: [ 1 ]
]

{ #category : 'updating' }
SpMorphicLabelAdapter >> updateWrap [
	"The new widget gets what #adapt: gave the old one, and keeps its layout properties in its owner.
	 Its height is its own: it depends on its lines."

	| oldWidget |
	oldWidget := widget.
	widget := self newWidget.
	widget
		position: oldWidget position;
		width: oldWidget width.
	self applyStyle: widget.
	widget
		hResizing: oldWidget hResizing;
		vResizing: oldWidget vResizing;
		minCellSize: oldWidget minCellSize;
		maxCellSize: oldWidget maxCellSize;
		presenter: self presenter.
	self applyVisibility.
	self addKeyBindingsTo: widget.
	self addEventsTo: widget.

	oldWidget owner ifNotNil: [ :ownerMorph | ownerMorph replaceSubmorph: oldWidget by: widget ]
]

{ #category : 'updating' }
SpMorphicLabelAdapter >> updateWrappingLabelText [

	widget isTextMorph ifFalse: [ ^ self ].

	widget contents: (self getText ifNil: [ '' ]).
	self enabled ifFalse: [ widget enabled: false ]
]
