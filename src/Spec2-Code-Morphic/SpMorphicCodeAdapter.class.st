Class {
	#name : #SpMorphicCodeAdapter,
	#superclass : #SpMorphicTextAdapter,
	#category : #'Spec2-Code-Morphic'
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

{ #category : #'widget API' }
SpMorphicCodeAdapter >> behavior [

	^ self model behavior
]

{ #category : #factory }
SpMorphicCodeAdapter >> buildWidget [
	| newWidget |
	
	newWidget := super buildWidget.
	
	self presenter whenSyntaxHighlightChangedDo: [ :hasSyntaxHighlight | 
		self setEditingModeFor: newWidget ].
	
	self presenter completionEngine ifNotNil: [ :engine | newWidget completionEngine: engine ].
	self presenter whenCompletionEngineChangedDo: [ :engine | newWidget completionEngine: engine ].
	
	^ newWidget
]

{ #category : #'private-shout' }
SpMorphicCodeAdapter >> classOrMetaClass: aClass [

	self 
		setEditingModeFor: self widget 
		withBehavior: aClass
]

{ #category : #private }
SpMorphicCodeAdapter >> computeOriginFor: aMorph [
	| desiredTop desiredLeft |

	aMorph textArea scrollSelectionIntoView: nil.
	desiredTop := (self originMorphFor: aMorph) positionInWorld y - 6.
						"unclear why 6 is the magic number"
	desiredLeft := (self originMorphFor: aMorph) right + aMorph positionInWorld x + 6.
	
	^ desiredLeft @ desiredTop
]

{ #category : #'widget API' }
SpMorphicCodeAdapter >> doItContext [

	^ self model doItContext
]

{ #category : #'widget API' }
SpMorphicCodeAdapter >> doItReceiver [

	^ self model doItReceiver
]

{ #category : #NOCompletion }
SpMorphicCodeAdapter >> guessTypeForName: aString [

	^nil
]

{ #category : #private }
SpMorphicCodeAdapter >> hasSyntaxHighlight [

	^ self presenter hasSyntaxHighlight
]

{ #category : #private }
SpMorphicCodeAdapter >> hasSyntaxHighlightEnabled [
	"this is used just for testing"
	
	^ self presenter hasSyntaxHighlight
]

{ #category : #'widget API' }
SpMorphicCodeAdapter >> insertPopoverAfterCurrentSelection: aPresenter [
	| popover pos |

	self widgetDo: [ :w |

		popover := self presenter newPopover
			bePositionRight;
			presenter: aPresenter;
			buildWithSpec;
			yourself.
	
		pos := self computeOriginFor: w.
		popover popupPointingTo: (pos corner: (pos + (1@15))).
		popover takeKeyboardFocus ]
]

{ #category : #private }
SpMorphicCodeAdapter >> originMorphFor: aMorph [

	(aMorph textArea hasSelection not and: [ 
		aMorph textArea hasHighlightSegment ]) ifTrue: [ 
			^ aMorph textArea getHighlightSegment ].
	^ aMorph textArea cursor
]

{ #category : #NOCompletion }
SpMorphicCodeAdapter >> receiverClass [

	^ self behavior
]

{ #category : #'widget API' }
SpMorphicCodeAdapter >> selectedBehavior [

	^ self model selectedBehavior
]

{ #category : #NOCompletion }
SpMorphicCodeAdapter >> selectedClassOrMetaClass [

	^ self behavior
]

{ #category : #private }
SpMorphicCodeAdapter >> setEditingModeFor: textArea [

	self hasSyntaxHighlight
		ifTrue: [ self setEditingModeFor: textArea withBehavior: self behavior ]
		ifFalse: [ super setEditingModeFor: textArea ]
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

{ #category : #private }
SpMorphicCodeAdapter >> textWithStyle [
	"This method is to be used for testing. 
	 DO NOT USE IT!"
	
	^ self widget getText
]
