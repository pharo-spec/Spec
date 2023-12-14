"
I am base for Spec Standard Dialogs.
Standard dialogs are available to provide simple I/O to users.
"
Class {
	#name : 'SpDialogPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'#parentWindow => WeakSlot',
		'#acceptAction',
		'#cancelAction',
		'#image'
	],
	#category : 'Spec2-Dialogs',
	#package : 'Spec2-Dialogs'
}

{ #category : 'documentation' }
SpDialogPresenter class >> addDocumentSection: aBuilder label: label methods: methods [
	
	methods ifEmpty: [ ^ self ].
	
	aBuilder newLine.
	aBuilder header: [ :builder | builder text: label ] withLevel: 2.
	aBuilder unorderedListDuring: [  
		(methods sorted: #selector ascending) do: [ :each |
			aBuilder item: [
				aBuilder monospace: (each methodClass name, '>>#', each selector) ] ] ]
]

{ #category : 'documentation' }
SpDialogPresenter class >> addDocumentSectionExampleCode: aBuilder [
	| exampleCode |

	exampleCode := self documentExampleCode. 
	exampleCode ifNil: [ ^ self ].
	
	aBuilder newLine.
	aBuilder header: [ :builder | builder text: 'Example code' ] withLevel: 2.
	aBuilder newLine.
	aBuilder codeblock: exampleCode
]

{ #category : 'documentation' }
SpDialogPresenter class >> addDocumentSectionFactoryMethod: aBuilder [
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
SpDialogPresenter class >> defaultAcceptLabel [

	^ 'Accept'
]

{ #category : 'accessing' }
SpDialogPresenter class >> defaultCancelLabel [

	^ 'Cancel'
]

{ #category : 'documentation' }
SpDialogPresenter class >> documentExampleCode [

	| exampleMethod |
	exampleMethod := self class methods
		                 detect: [ :method | method protocolName = #example and: [ method selector = #exampleModal ] ]
		                 ifNone: [ ^ nil ].

	^ (exampleMethod sourceCode lines allButFirst reject: [ :each | each trimLeft beginsWith: '<' ]) asStringWithCr trimmed "Remove method name" "Remove pragmas"
]

{ #category : 'documentation' }
SpDialogPresenter class >> documentFactoryMethodSelector [
	
	^ nil
]

{ #category : 'documentation' }
SpDialogPresenter class >> documentSections [

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
SpDialogPresenter class >> open [
	<script>
	
	^ self new open
]

{ #category : 'instance creation' }
SpDialogPresenter class >> openDialog [
	<script>
	
	^ self new openDialog
]

{ #category : 'instance creation' }
SpDialogPresenter class >> openModal [
	<script>

	^ self new openModal
]

{ #category : 'private' }
SpDialogPresenter >> accept [

	self window 
		beOk; 
		triggerOkAction;
		close
]

{ #category : 'private' }
SpDialogPresenter >> cancel [

	self window 
		beCancel; 
		triggerCancelAction;
		close
]

{ #category : 'private' }
SpDialogPresenter >> defaultIcon [

	^ self application iconNamed: #question
]

{ #category : 'accessing' }
SpDialogPresenter >> icon: aForm [

	image ifNotNil: [ image image: aForm ]
]

{ #category : 'initialization' }
SpDialogPresenter >> initializeDialogWindow: aDialogWindowPresenter [

	aDialogWindowPresenter 
		okAction: acceptAction;
		cancelAction: cancelAction.
	
	self parentWindow 
		ifNotNil: [ :w | aDialogWindowPresenter centeredRelativeTo: w ] 
		ifNil: [ aDialogWindowPresenter centered ].
]

{ #category : 'api - events' }
SpDialogPresenter >> onAccept: aBlock [
	"When the dialog is accepted, it executes this action before close.
	 `aBlock` receives one argument (this dialog)"

	acceptAction := aBlock
]

{ #category : 'api - events' }
SpDialogPresenter >> onCancel: aBlock [
	"When the dialog is cancelled, it executes this action before close.
	 `aBlock` receives one argument (this dialog)"

	cancelAction := aBlock
]

{ #category : 'api - showing' }
SpDialogPresenter >> openDialogWithParent: aWindow [
	"Open dialog in a non-modal way, centering on parent window. "
	
	parentWindow := aWindow.
	^ self openDialog
]

{ #category : 'api - showing' }
SpDialogPresenter >> openModalWithParent: aWindow [
	"Open dialog in a modal way, centering on parent window. "

	parentWindow := aWindow.
	^ self openModal
]

{ #category : 'accessing' }
SpDialogPresenter >> parentWindow [

	^ parentWindow
]

{ #category : 'accessing' }
SpDialogPresenter >> parentWindow: aWindowPresenter [

	parentWindow := aWindowPresenter
]
