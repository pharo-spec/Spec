"
I'm a code (Pharo code) presenter. 
I will style and provide completion according to the behaviour being edited.
"
Class {
	#name : #SpCodePresenter,
	#superclass : #SpTextPresenter,
	#instVars : [
		'#doItContext => SpObservableSlot',
		'#doItReceiver => SpObservableSlot',
		'#behavior => SpObservableSlot',
		'#syntaxHighlight => SpObservableSlot',
		'#completionEngine => SpObservableSlot',
		'#lineNumbers => SpObservableSlot',
		'#interactionModel'
	],
	#category : #'Spec2-Code'
}

{ #category : #specs }
SpCodePresenter class >> adapterName [

	^ #CodeAdapter
]

{ #category : #commands }
SpCodePresenter class >> buildCommandsGroupWith: presenter forRoot: aCmCommandsGroup [

	aCmCommandsGroup beDisplayedAsGroup.
	aCmCommandsGroup register: (self codeSelectionActionCommandsGroupWith: presenter).
	aCmCommandsGroup register: (self codeNavigationCommandsGroupWith: presenter)
]

{ #category : #commands }
SpCodePresenter class >> codeNavigationCommandsGroupWith: aPresenter [
	| group |
	
	group := (CmCommandGroup named: 'Selection search commands') asSpecGroup.
	group
		description: 'Search the system from code selection.';
		beDisplayedAsGroup.
	group register: (SpBrowseClassCommand new 
		transform: [ :aContext | aContext findClassFromSelection ];
		asSpecCommand).	

	self flag: #TODO. "This looks like a very bad way to do this :P"	
	{ 
		SpBrowseImplementorsCommand.
		SpBrowseSendersCommand.
		SpBrowseMethodReferencesCommand.	
		SpBrowseMethodsContainingStringCommand.
	 } 
	do:[ :commandClass | 
		group register: (commandClass new 
			transform: [ :aContext | aContext selectedTextOrLine ];
			asSpecCommand) ].
	
	^ group
]

{ #category : #commands }
SpCodePresenter class >> codeSelectionActionCommandsGroupWith: presenter [
	| group |
	
	group := (CmCommandGroup named: 'Selection action commands') asSpecGroup.
	group
		description: 'Actions on code selection.';
		beDisplayedAsGroup.
	
	SpCodeSelectionCommand allSubclassesDo: [ :cmdClass | 
		group register: (cmdClass forSpecContext: presenter) ].
	
	^ group
]

{ #category : #examples }
SpCodePresenter class >> example [
	<sampleInstance>

	^ self new
	 openWithSpec;
		text:
			'some method: 42'

]

{ #category : #specs }
SpCodePresenter class >> title [

	^ 'Code'
]

{ #category : #'api-shout' }
SpCodePresenter >> behavior [
	"Return the class corresponding to the method class of the source code you are editing"
	
	^ behavior
]

{ #category : #'api-shout' }
SpCodePresenter >> behavior: aClass [
	"Set the class corresponding to the method class of the source code you are editing"

	behavior := aClass
]

{ #category : #binding }
SpCodePresenter >> bindingOf: aString [

	interactionModel ifNotNil:  [ :im | ^ im bindingOf: aString  ].
	self behavior ifNotNil: [ :aBehavior | ^ aBehavior bindingOf: aString ].
	^ nil
]

{ #category : #accessing }
SpCodePresenter >> completionEngine [

	^ completionEngine
]

{ #category : #accessing }
SpCodePresenter >> completionEngine: aCompletionEngine [

	completionEngine := aCompletionEngine
]

{ #category : #binding }
SpCodePresenter >> doItContext [

	doItContext ifNotNil: [ ^ doItContext ].
	^ interactionModel ifNotNil: [ :im | im doItContext ]
]

{ #category : #binding }
SpCodePresenter >> doItContext: anObject [

	doItContext := anObject
]

{ #category : #binding }
SpCodePresenter >> doItReceiver [
	
	doItReceiver ifNotNil: [ 
		| receiver |
		receiver := doItReceiver.
		receiver isBehavior ifTrue: [ 
			receiver := receiver instanceSide ].
		^ receiver ].
	
	^ interactionModel ifNotNil: [ :im | im doItReceiver ]
]

{ #category : #binding }
SpCodePresenter >> doItReceiver: anObject [

	doItReceiver := anObject
]

{ #category : #accessing }
SpCodePresenter >> findClassFrom: aString [
	| ast |
	
	self flag: #TODO. "Does this really has to be part of the code api?"

	ast := RBParser parseExpression: aString onError: [ ^ nil ].
	ast nodesDo: [ :node | 
		(node isVariable and: [ node name first isUppercase ])
			ifTrue: [ 
				(self class environment classNamed: node name)
					ifNotNil: [ :aClass | ^ aClass ] ] ].

	^ nil
]

{ #category : #accessing }
SpCodePresenter >> findClassFromSelection [
	self flag: #TODO. "Does this really has to be part of the text api?"

	^ self findClassFrom: self selectedTextOrLine trimmed
]

{ #category : #binding }
SpCodePresenter >> hasBindingOf: aString [

	interactionModel ifNotNil: [ :im | ^ im hasBindingOf: aString ].
	self behavior ifNotNil: [ :aBehavior | (aBehavior bindingOf: aString) notNil ].
	^ false
]

{ #category : #binding }
SpCodePresenter >> hasBindingThatBeginsWith: aString [ 
	
	^ interactionModel
		ifNotNil: [ :im | im hasBindingThatBeginsWith: aString ] 
		ifNil: [ false ]
]

{ #category : #testing }
SpCodePresenter >> hasLineNumbers [

	^ lineNumbers
]

{ #category : #testing }
SpCodePresenter >> hasSyntaxHighlight [

	^ syntaxHighlight
]

{ #category : #initialization }
SpCodePresenter >> initialize [ 

	super initialize.
	
	self withSyntaxHighlight.
	self withLineNumbers.
	
	self registerEventsForStyling.
	
	self contextMenu: [ self rootCommandsGroup asMenuPresenter ].
	self contextKeyBindings: self rootCommandsGroup asKMCategory
]

{ #category : #api }
SpCodePresenter >> insertPopoverAfterCurrentSelection: aPresenter [

	self withAdapterDo: [ :anAdapter |
		anAdapter insertPopoverAfterCurrentSelection: aPresenter ]
]

{ #category : #api }
SpCodePresenter >> interactionModel [

	^ interactionModel
]

{ #category : #api }
SpCodePresenter >> interactionModel: anObject [ 	

	interactionModel := anObject
]

{ #category : #accessing }
SpCodePresenter >> lineNumbers: aBoolean [

	lineNumbers := aBoolean
]

{ #category : #initialization }
SpCodePresenter >> registerEventsForStyling [

	self whenBehaviorChangedDo: [ :class | 
		self changed: #classOrMetaClass: with: { class }.
		self changed: #getText ]
]

{ #category : #api }
SpCodePresenter >> selectedBehavior [

	self flag: #TODO. "What this is need for?"
	^ self behavior
]

{ #category : #binding }
SpCodePresenter >> selectedClassOrMetaClass [

	behavior ifNotNil: [ ^ behavior ].
	^ interactionModel ifNotNil: [ :im | im selectedClassOrMetaClass ]
]

{ #category : #api }
SpCodePresenter >> selectedTextOrLine [

	self selectedText ifNotEmpty: [ :aString | ^ aString ].
	
	^ self
		selectLine;
		selectedText
]

{ #category : #accessing }
SpCodePresenter >> syntaxHighlight: aBoolean [
	syntaxHighlight := aBoolean 
]

{ #category : #'api-events' }
SpCodePresenter >> whenBehaviorChangedDo: aBlock [
	"Set a block to perform when the behavior class changed"
	
	self 
		property: #behavior 
		whenChangedDo: aBlock
]

{ #category : #'api-events' }
SpCodePresenter >> whenCompletionEngineChangedDo: aBlock [
	"Set a block to perform when the syntax highlight is enabled/disabled"
	
	self property: #completionEngine whenChangedDo: aBlock
]

{ #category : #'api-events' }
SpCodePresenter >> whenLineNumbersChangedDo: aBlock [
	"Set a block to perform when the syntax highlight is enabled/disabled"

	self property: #lineNumbers whenChangedDo: aBlock
]

{ #category : #'api-events' }
SpCodePresenter >> whenSyntaxHighlightChangedDo: aBlock [
	"Set a block to perform when the syntax highlight is enabled/disabled"

	self property: #syntaxHighlight whenChangedDo: aBlock
]

{ #category : #api }
SpCodePresenter >> withLineNumbers [

	self lineNumbers: true
]

{ #category : #api }
SpCodePresenter >> withSyntaxHighlight [

	self syntaxHighlight: true
]

{ #category : #api }
SpCodePresenter >> withoutLineNumbers [

	self lineNumbers: false
]

{ #category : #api }
SpCodePresenter >> withoutSyntaxHighlight [

	self syntaxHighlight: false
]
