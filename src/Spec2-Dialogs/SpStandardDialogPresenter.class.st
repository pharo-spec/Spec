"
I am base for Spec Standard Dialogs.
Standard dialogs are available to provide simple I/O to users.
"
Class {
	#name : 'SpStandardDialogPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'#parentWindow => WeakSlot',
		'#acceptAction',
		'#cancelAction',
		'#imagePresenter'
	],
	#category : 'Spec2-Dialogs',
	#package : 'Spec2-Dialogs'
}

{ #category : 'documentation' }
SpStandardDialogPresenter class >> addDocumentSection: aBuilder label: label methods: methods [
	
	methods ifEmpty: [ ^ self ].
	
	aBuilder newLine.
	aBuilder header: [ :builder | builder text: label ] withLevel: 2.
	aBuilder unorderedListDuring: [  
		(methods sorted: #selector ascending) do: [ :each |
			aBuilder item: [
				aBuilder monospace: (each methodClass name, '>>#', each selector) ] ] ]
]

{ #category : 'documentation' }
SpStandardDialogPresenter class >> addDocumentSectionExampleCode: aBuilder [
	| exampleCode |

	exampleCode := self documentExampleCode. 
	exampleCode ifNil: [ ^ self ].
	
	aBuilder newLine.
	aBuilder header: [ :builder | builder text: 'Example code' ] withLevel: 2.
	aBuilder newLine.
	aBuilder codeblock: exampleCode
]

{ #category : 'documentation' }
SpStandardDialogPresenter class >> addDocumentSectionFactoryMethod: aBuilder [
	| selector |

	selector := self documentFactoryMethodSelector. 
	selector ifNil: [ ^ self ].
	 
	aBuilder newLine.
	aBuilder header: [ :builder | builder text: 'Factory method' ] withLevel: 2.
	aBuilder newLine.
	aBuilder text: 'You can open '. 
	aBuilder monospace: self name. 
	aBuilder text: ' dialogs in your presenters by sending '.
	aBuilder monospace: 'SpApplication>>#', selector.
	aBuilder text: '.'
]

{ #category : 'accessing' }
SpStandardDialogPresenter class >> defaultAcceptLabel [

	^ 'Accept'
]

{ #category : 'accessing' }
SpStandardDialogPresenter class >> defaultCancelLabel [

	^ 'Cancel'
]

{ #category : 'documentation' }
SpStandardDialogPresenter class >> documentExampleCode [

	| exampleMethod |
	exampleMethod := self class methods
		                 detect: [ :method | method protocolName = #example and: [ method selector = #exampleModal ] ]
		                 ifNone: [ ^ nil ].

	^ ((exampleMethod sourceCode lines
		"Remove method name"
		allButFirst
		"Remove pragmas"
		reject: [ :each | each trimLeft beginsWith: '<' ])
		joinUsing: Character cr)
			trimmed
]

{ #category : 'documentation' }
SpStandardDialogPresenter class >> documentFactoryMethodSelector [
	
	^ nil
]

{ #category : 'documentation' }
SpStandardDialogPresenter class >> documentSections [

	^ OrderedDictionary newFromPairs: {
			  'API Show Methods'.
			  (self methods select: [ :method | method protocolName = #'api - showing' ]).
			  'API Methods'.
			  (self methods select: [ :method | method protocolName = #api ]).
			  'Testing Methods'.
			  (self methods select: [ :method | method protocolName = #testing ]).
			  'Events'.
			  (self methods select: [ :method | method protocolName = #'api - events' ]) }
]

{ #category : 'instance creation' }
SpStandardDialogPresenter class >> open [
	<script>
	
	^ self new open
]

{ #category : 'instance creation' }
SpStandardDialogPresenter class >> openDialog [
	<script>
	
	^ self new openDialog
]

{ #category : 'instance creation' }
SpStandardDialogPresenter class >> openModal [
	<script>

	^ self new openModal
]

{ #category : 'private' }
SpStandardDialogPresenter >> accept [

	self window 
		beOk; 
		triggerOkAction;
		close
]

{ #category : 'private' }
SpStandardDialogPresenter >> cancel [

	self window 
		beCancel; 
		triggerCancelAction;
		close
]

{ #category : 'private' }
SpStandardDialogPresenter >> defaultIcon [

	^ self application iconNamed: #question
]

{ #category : 'api' }
SpStandardDialogPresenter >> icon: aForm [

	imagePresenter ifNil: [ ^ self ].
	imagePresenter image: aForm.
	imagePresenter show
]

{ #category : 'initialization' }
SpStandardDialogPresenter >> initializeDialogWindow: aDialogWindowPresenter [
	
	acceptAction ifNotNil: [ aDialogWindowPresenter okAction: acceptAction ].
	cancelAction ifNotNil: [ aDialogWindowPresenter cancelAction: cancelAction ].
	
	self parentWindow 
		ifNotNil: [ :w | aDialogWindowPresenter centeredRelativeTo: w ] 
		ifNil: [ aDialogWindowPresenter centered ].
]

{ #category : 'initialization' }
SpStandardDialogPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter beNotResizable
]

{ #category : 'api - events' }
SpStandardDialogPresenter >> onAccept: aBlock [
	"When the dialog is accepted, it executes this action before close.
	 `aBlock` receives one argument (this dialog)"

	acceptAction := aBlock
]

{ #category : 'api - events' }
SpStandardDialogPresenter >> onCancel: aBlock [
	"When the dialog is cancelled, it executes this action before close.
	 `aBlock` receives one argument (this dialog)"

	cancelAction := aBlock
]

{ #category : 'api - showing' }
SpStandardDialogPresenter >> openDialogWithParent: aWindow [
	"Open dialog in a non-modal way, centering on parent window. "
	
	parentWindow := aWindow.
	^ self openDialog
]

{ #category : 'api - showing' }
SpStandardDialogPresenter >> openModalWithParent: aWindow [
	"Open dialog in a modal way, centering on parent window. "

	parentWindow := aWindow.
	^ self openModal
]

{ #category : 'api' }
SpStandardDialogPresenter >> parentWindow [

	^ parentWindow
]

{ #category : 'api' }
SpStandardDialogPresenter >> parentWindow: aWindowPresenter [

	parentWindow := aWindowPresenter
]
