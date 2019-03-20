"
I execute a Mate application.

Usage: run [--list] <applicationName>
 
	list    lists all applications contained in image,
	
Example:

	pharo Pharo.image run HelloWorld
	pharo Pharo.image run IDE
"
Class {
	#name : #SpecRunCommandLineHandler,
	#superclass : #CommandLineHandler,
	#instVars : [
		'applicationName'
	],
	#category : #'Spec-CommandLine'
}

{ #category : #accessing }
SpecRunCommandLineHandler class >> commandName [
	^ 'run'
]

{ #category : #activation }
SpecRunCommandLineHandler >> activate [
	self activateHelpWithoutArguments ifTrue: [ ^ self ].
	(self hasOption: 'list') ifTrue: [ ^ self listApplications ]. 
	self runApplication
]

{ #category : #activation }
SpecRunCommandLineHandler >> applicationName [
	^ applicationName ifNil: [ applicationName := self argumentAt: 1 ]
]

{ #category : #activation }
SpecRunCommandLineHandler >> listApplications [ 
	| nl |
	
	nl := Smalltalk platform lineEnding.
	self stdout 
		<< 'List of applications: ' << nl
		<< '---- ' << nl.
	SpecApplication findAll do: [ :each | 
		self stdout << each applicationName << nl ].
	
	self exitSuccess
]

{ #category : #activation }
SpecRunCommandLineHandler >> runApplication [
	| appClass |
	
	appClass := SpecApplication 
		findNamed: self applicationName
		ifNone: [ ^ self exitFailure: ('Application {1} not found.' format: { self applicationName }) ].
	
	[ appClass new start ] fork
]
