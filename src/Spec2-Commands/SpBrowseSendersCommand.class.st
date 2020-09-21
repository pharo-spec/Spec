"
Browse all senders.

"
Class {
	#name : #SpBrowseSendersCommand,
	#superclass : #SpSystemNavigationCommand,
	#category : #'Spec2-Commands-Navigation'
}

{ #category : #default }
SpBrowseSendersCommand class >> defaultDescription [
	^ 'Browse all senders of the selected method or message'
]

{ #category : #default }
SpBrowseSendersCommand class >> defaultShortcutKey [

	^ $n command mac 
		| $n control win
		| $n control unix
]

{ #category : #documentation }
SpBrowseSendersCommand class >> documentContextRequiredSelectors [

	^ #(environment selectedTextOrLine)
]

{ #category : #default }
SpBrowseSendersCommand class >> shortName [

	^ 'senders'
]

{ #category : #executing }
SpBrowseSendersCommand >> execute [
	| env ref aVariableOrClassName |

	aVariableOrClassName := self context selectedTextOrLine trimmed asSymbol.
	aVariableOrClassName ifEmpty: [ ^ self ].
	 
	env := self context environment.
	env isBehavior ifTrue: [
		(env hasSlotNamed: aVariableOrClassName) ifTrue: [
		 ^ self systemNavigation browseAllAccessesTo: aVariableOrClassName from: env ] ].

	ref:= (env bindingOf: aVariableOrClassName) 
		ifNil: [ ^ self ].
	self systemNavigation browseAllSendersOf: ref
]
