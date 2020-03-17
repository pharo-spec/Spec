"
A SpecSplitterHorizontal is a description of the addition of a horizontal splitter
"
Class {
	#name : #SpSplitterHorizontal,
	#superclass : #SpLayoutAdd,
	#instVars : [
		'commands'
	],
	#category : #'Spec2-Layout-Deprecated'
}

{ #category : #'instance creation' }
SpSplitterHorizontal class >> commands: commands [

	^ self new
		commands: commands;
		yourself
]

{ #category : #'Spec2-Deprecated' }
SpSplitterHorizontal >> arguments [
	^ {(self commands identityIndexOf: self)}
]

{ #category : #'Spec2-Deprecated' }
SpSplitterHorizontal >> commands [
	
	^ commands
]

{ #category : #'Spec2-Deprecated' }
SpSplitterHorizontal >> commands: anObject [
	
	commands := anObject
]

{ #category : #'Spec2-Deprecated' }
SpSplitterHorizontal >> initialize [
	super initialize.

	selector := #newHSplitterAt:.
	layoutFrame := (0 @ 0 corner: 0 @ 0) asSpLayoutFrame bottomOffset: 1
]

{ #category : #'Spec2-Deprecated' }
SpSplitterHorizontal >> isSplitter [

	^ true
]
