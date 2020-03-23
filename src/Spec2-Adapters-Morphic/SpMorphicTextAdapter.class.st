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
		autoAccept: self autoAccept;
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		setBalloonText: self help;
		dragEnabled: self dragEnabled;
		dropEnabled: self dropEnabled;
		registerScrollChanges: #scrollValueChanged:;
		yourself.
	
	self setEditingModeFor: newWidget.
	
	self presenter whenTextChangedDo: [ :text | self setText: text to: newWidget ].
	self presenter whenPlaceholderChangedDo: [ :text | self setGhostText: text to: newWidget ].
	
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
SpMorphicTextAdapter >> setGhostText: text to: aWidget [

	aWidget ghostText: text
]

{ #category : #private }
SpMorphicTextAdapter >> setText: text to: aWidget [

	aWidget setText: text
]
