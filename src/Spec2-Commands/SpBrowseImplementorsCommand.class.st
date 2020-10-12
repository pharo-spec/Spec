"
Browse all implementors of the selector found in context.
"
Class {
	#name : #SpBrowseImplementorsCommand,
	#superclass : #SpSystemNavigationCommand,
	#category : #'Spec2-Commands-Navigation'
}

{ #category : #default }
SpBrowseImplementorsCommand class >> defaultDescription [
	^ 'Browse all implementors of the selected method or message'
]

{ #category : #default }
SpBrowseImplementorsCommand class >> defaultShortcutKey [

	^ $m command mac 
		| $m control win
		| $m control unix
]

{ #category : #documentation }
SpBrowseImplementorsCommand class >> documentContextRequiredSelectors [

	^ super documentContextRequiredSelectors, #(selectedTextOrLine)
]

{ #category : #default }
SpBrowseImplementorsCommand class >> shortName [

	^ 'implementors'
]

{ #category : #executing }
SpBrowseImplementorsCommand >> execute [

	self flag: #TODO. "This thingy waits for Guille's refactor"
	self systemNavigation 
		environment: self context environment;
		browseAllImplementorsOf: self selectedSelector
]

{ #category : #api }
SpBrowseImplementorsCommand >> selectedSelector [
	| node selection |
	
	selection := self selectedTextOrLine.
	node := RBParser parseFaultyExpression: selection.
	node
		nodesDo: [ :n | 
			n isMessage
				ifTrue: [ ^ n selector ].
			n isVariable
				ifTrue: [ ^ n name ].
			n isLiteralNode
				ifTrue: [ ^ n value ] ].
	"fall back"
	^ selection trimmed asSymbol
]
