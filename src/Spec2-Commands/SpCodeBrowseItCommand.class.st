Class {
	#name : #SpCodeBrowseItCommand,
	#superclass : #SpCodeSelectionCommand,
	#category : #'Spec2-Commands-Code'
}

{ #category : #default }
SpCodeBrowseItCommand class >> defaultName [

	^ 'Browse it'
]

{ #category : #default }
SpCodeBrowseItCommand class >> defaultShortcutKey [

	^ $b meta
]

{ #category : #execution }
SpCodeBrowseItCommand >> execute [
	"Treat the current text selection as an expression; evaluate it."
	| classToBrowse |
	
	classToBrowse := self findClassOn: self selectionOrLine trimmed.
	classToBrowse ifNil: [ ^ self ].
	self flag: #TODO. "this is just browseIt. I'm putting this now to show the flow"
	StSystemBrowser openOnClass: classToBrowse
]

{ #category : #private }
SpCodeBrowseItCommand >> findClassNameOn: aString [
	| ast |
	
	ast := RBParser parseExpression: aString onError: [ ^ nil ].
	ast nodesDo: [ :node |
		(node isVariable and: [ node name first isUppercase ])
			ifTrue: [ ^ node name ] ].
		
	^ nil
]

{ #category : #private }
SpCodeBrowseItCommand >> findClassOn: aString [
	| className |
	
	className := self findClassNameOn: aString.
	className ifNil: [ ^ nil ].
	
	^ Smalltalk classNamed: className
]
