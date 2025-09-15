"
I execute a Mate application.

Usage: run [--list] <applicationName>
 
	list    lists all applications contained in image,
	
Example:

	pharo Pharo.image run HelloWorld
	pharo Pharo.image run IDE
"
Class {
	#name : 'SpRunCliCommand',
	#superclass : 'ClapPharoApplication',
	#category : 'Spec2-CommandLine',
	#package : 'Spec2-CommandLine'
}

{ #category : 'command line' }
SpRunCliCommand class >> commandSpecification [

	<commandline>
	
	^ (ClapCommandSpec id: #run)
		  description: 'Run a spec application at image startup';
		  commandClass: self;
		  addHelp;
		  addFlag: #list description: 'lists all applications contained in the image';
		  addPositional: #applicationName description: 'the name of the application to run';
		  yourself
]

{ #category : 'execution' }
SpRunCliCommand >> applicationName [

	^ self positional: #applicationName ifAbsent: [ self exitFailure: 'Please provide an application name to run' ]
]

{ #category : 'execution' }
SpRunCliCommand >> execute [

	self shouldListApplications
		ifTrue: [ self listApplications ]
		ifFalse: [ self runApplication ] 
]

{ #category : 'activation' }
SpRunCliCommand >> listApplications [

	| newLine |
	newLine := self lineEnding.
	self outputStreamDo: [ :out |
			out 
				<< 'List of applications: ' << newLine 
				<< '---- ' << newLine.
			SpApplication findAll do: [ :each | 
				out << each applicationName << newLine ] ]
]

{ #category : 'nil' }
SpRunCliCommand >> runApplication [
	| appClass |
	
	appClass := SpApplication 
		findNamed: self applicationName
		ifNone: [ ^ self exitFailure: ('Application {1} not found.' format: { self applicationName }) ].
	self doNotQuitImage.

	[ 
		appClass basicNew
			prepareAsStandaloneApplication;
			initialize;
			run ] 
	fork
]

{ #category : 'nil' }
SpRunCliCommand >> shouldListApplications [

	^ self hasFlag: #list
]
