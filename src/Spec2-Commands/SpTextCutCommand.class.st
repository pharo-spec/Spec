Class {
	#name : 'SpTextCutCommand',
	#superclass : 'SpTextEditionCommand',
	#category : 'Spec2-Commands-Code',
	#package : 'Spec2-Commands',
	#tag : 'Code'
}

{ #category : 'defaults' }
SpTextCutCommand class >> defaultIconName [
	^#smallCut 
]

{ #category : 'default' }
SpTextCutCommand class >> defaultName [

	^ 'Cut'
]

{ #category : 'default' }
SpTextCutCommand class >> defaultShortcutKey [

	^ $x command mac 
		| $x control win 
		| $x control unix
]

{ #category : 'execution' }
SpTextCutCommand >> execute [

	context doTextCut
]
