"
! A (simple) sample configuration

A configuration is needed to define different elements for each different backend.
You do this by extending *class:SpApplicationConfiguration* or one of its more specific children (*class:SpMorphicConfiguration* and *class:SpGtkConfiguration*).

See *method:SpSimpleExampleConfiguration#styleSheet*
"
Class {
	#name : 'SpSimpleExampleConfiguration',
	#superclass : 'SpMorphicConfiguration',
	#category : 'Spec2-Examples-SimpleApplication',
	#package : 'Spec2-Examples-SimpleApplication'
}

{ #category : 'styling' }
SpSimpleExampleConfiguration >> styleSheet [
	"This method will answer the default stylesheed (provided by calling ==super styleSheed==) and 
	 it will add a class called ==title== to be used by labels.
	
	[[[language=Smalltalk
	^ super styleSheet, (SpStyleSTONReader fromString: '
		.application [
			.label [
				.title [
					Font { #name: ""Source Code Pro"", #size: 24 },
					Draw { #color: #red }
				]
			]	
		]')
	]]]"

	^ super styleSheet, (SpStyleSTONReader fromString: '
.application [
	.label [
		.title [
			Font { #name: "Source Code Pro", #size: 24 },
			Draw { #color: #red }
		]
	]	
]')
]
