Class {
	#name : #SpecLayoutShowcase,
	#superclass : #ComposablePresenter,
	#instVars : [
		'example'
	],
	#category : #'Spec-Layout-Examples'
}

{ #category : #specs }
SpecLayoutShowcase class >> defaultSpec [
	<spec: #default>
	
	^ SpecBoxLayout newVertical 
		add: #example;
		yourself		
]

{ #category : #initialization }
SpecLayoutShowcase >> initializeWidgets [
	
	example := self newNotebook.
	SpecBaseLayoutShowcase allSubclassesDo: [ :eachClass |
		example addPage: (self 
			newPage: eachClass label 
			spec: eachClass) ]
]

{ #category : #initialization }
SpecLayoutShowcase >> newPage: aString spec: aClass [

	^ NotebookPage 
		title: aString 
		provider: [ self instantiate: aClass ]
]
