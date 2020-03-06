"
A SpecSplitterVertical is the description of the addition of a vertical splitter
"
Class {
	#name : #SpSplitterVertical,
	#superclass : #SpLayoutAdd,
	#instVars : [
		'commands'
	],
	#category : #'Spec2-Layout-Deprecated'
}

{ #category : #'instance creation' }
SpSplitterVertical class >> commands: commands [

	^ self new
		commands: commands;
		yourself
]

{ #category : #'Spec2-Deprecated' }
SpSplitterVertical >> arguments [
	^ {(self commands identityIndexOf: self)}
]

{ #category : #'Spec2-Deprecated' }
SpSplitterVertical >> commands [
	
	^ commands
]

{ #category : #'Spec2-Deprecated' }
SpSplitterVertical >> commands: anObject [
	
	commands := anObject
]

{ #category : #'Spec2-Deprecated' }
SpSplitterVertical >> initialize [
	super initialize.

	selector := #newVSplitterAt:.
	layoutFrame := (0 @ 0 corner: 0 @ 0) asSpLayoutFrame rightOffset: 1
]

{ #category : #'Spec2-Deprecated' }
SpSplitterVertical >> isSplitter [

	^ true
]
