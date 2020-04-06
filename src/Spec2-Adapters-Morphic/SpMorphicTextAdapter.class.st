"
I am the adapter used to bridge a TextPresenter and a PluggableTextMorph
"
Class {
	#name : #SpMorphicTextAdapter,
	#superclass : #SpMorphicBaseTextAdapter,
	#category : #'Spec2-Adapters-Morphic-Base'
}

{ #category : #initialization }
SpMorphicTextAdapter >> addFocusRotationKeyBindings [
	"Text areas needs to be able to process tab. Cancel the binding."
]

{ #category : #initialization }
SpMorphicTextAdapter >> addKeyBindingsTo: aMorph [

	super addKeyBindingsTo: aMorph.
	self presenter hasEditionContextMenu ifFalse: [ ^ self ].
	self presenter editionContextKeyBindings allEntries keymaps do: [ :each |
		self
			bindKeyCombination: each shortcut 
			toAction: each action ]
]

{ #category : #'protocol-shortcuts' }
SpMorphicTextAdapter >> bindKeyCombination: aShortcut toAction: aBlock [ 

	self widgetDo: [ :w | 
		w textArea
			bindKeyCombination: aShortcut 
			toAction: aBlock ]
]

{ #category : #factory }
SpMorphicTextAdapter >> buildWidget [
	| newWidget |
	
	newWidget := (RubScrolledTextMorph on: self)
		getTextSelector: #getText;
		setTextSelector: #accept:notifying:;
		getSelectionSelector: #readSelection;
		menuProvider: self selector: #codePaneMenu:shifted:;
		setSelectionSelector: #setSelection:;
		ghostText: self placeholder;
		beWrapped;
		enabled: self enabled;
		askBeforeDiscardingEdits: self askBeforeDiscardingEdits;
		autoAccept: true;
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		setBalloonText: self help;
		dragEnabled: self dragEnabled;
		dropEnabled: self dropEnabled;
		registerScrollChanges: #scrollValueChanged:;
		yourself.
	
	self setEditable: self presenter isEditable to: newWidget.
	self setEditingModeFor: newWidget.
	self setText: self presenter text to: newWidget.
	
	self presenter whenTextChangedDo: [ :text | self setText: text to: newWidget ].
	self presenter whenPlaceholderChangedDo: [ :text | self setGhostText: text to: newWidget ].
	self presenter whenEditableChangedDo: [ :value | self setEditable: value to: newWidget ].
	
	^ newWidget
]

{ #category : #'widget API' }
SpMorphicTextAdapter >> codePaneMenu: aMenu shifted: shifted [
	| menuPresenter |

	menuPresenter := self model contextMenu value
		ifNotNil: [ :contextMenu | contextMenu ]
		ifNil: [ SpMenuPresenter new ].
	self presenter hasEditionContextMenu ifTrue: [ 
		self presenter editionContextMenu menuGroups do: [ :each |
			menuPresenter addMenuGroup: each ] ].
	^ SpBindings
		value: self model application adapterBindings
		during: [ menuPresenter buildWithSpec ]
]

{ #category : #private }
SpMorphicTextAdapter >> setEditable: aBoolean to: aWidget [

	aWidget textArea readOnly: aBoolean not
]

{ #category : #private }
SpMorphicTextAdapter >> setGhostText: text to: aWidget [

	aWidget ghostText: text
]

{ #category : #private }
SpMorphicTextAdapter >> setText: text to: aWidget [

	aWidget setText: text.
	self updateExtentPropagationOf: text on: aWidget

]

{ #category : #private }
SpMorphicTextAdapter >> updateExtentPropagationOf: string on: aWidget [
	| stringMorph width height |

	(self presenter isPropagateNaturalWidth 
		or: [ self presenter isPropagateNaturalHeight ])
		ifFalse: [ ^ self ].

	stringMorph := RubEditingArea new 
		font: self theme textFont;
		updateTextWith: string.

	width := stringMorph width + 12 min: self currentWorld width / 3.
	self presenter isPropagateNaturalWidth 
		ifTrue: [ aWidget width: width ].

	self presenter isPropagateNaturalHeight 
		ifTrue: [ 
			height := (stringMorph
				beWrapped;
				width: width;
				yourself) height + 2 min: self currentWorld height / 3. 
			aWidget height: height ]
]

{ #category : #emulating }
SpMorphicTextAdapter >> widgetEventReceiver [
	
	^ widget textArea
]
