Class {
	#name : #SpMorphicCodeAdapter,
	#superclass : #SpMorphicTextAdapter,
	#category : #'Spec2-Adapters-Morphic-Base'
}

{ #category : #initialization }
SpMorphicCodeAdapter >> addKeyBindingsTo: aMorph [

	super addKeyBindingsTo: aMorph.
	self presenter contextKeyBindings ifNotNil: [ :kmCategory |
	 	kmCategory allEntries keymaps do: [ :each |
			self
				bindKeyCombination: each shortcut 
				toAction: each action ] ]
]

{ #category : #private }
SpMorphicCodeAdapter >> setEditingModeFor: textArea withBehavior: aBehavior [

	aBehavior
		ifNotNil: [ textArea beForSmalltalkCodeInClass: aBehavior ]		
		ifNil: [ 
			textArea 
				model: self;
				beForSmalltalkScripting ]
]
