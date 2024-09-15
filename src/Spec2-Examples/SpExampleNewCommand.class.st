"
I am an example command to create a new thing.
"
Class {
	#name : 'SpExampleNewCommand',
	#superclass : 'CmCommand',
	#category : 'Spec2-Examples-Demo-CommandGroup',
	#package : 'Spec2-Examples',
	#tag : 'Demo-CommandGroup'
}

{ #category : 'converting' }
SpExampleNewCommand >> asSpecCommand [

	^ super asSpecCommand
		iconName: #smallNew;
		shortcutKey: $n meta;
		yourself
]

{ #category : 'executing' }
SpExampleNewCommand >> execute [

	self inform: 'This command is not implemented yet.'
]

{ #category : 'initialization' }
SpExampleNewCommand >> initialize [

	super initialize.
	self
		name: 'New';
		description: 'Create a new thing'
]
