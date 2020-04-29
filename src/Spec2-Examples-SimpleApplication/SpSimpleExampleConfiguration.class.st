Class {
	#name : #SpSimpleExampleConfiguration,
	#superclass : #SpMorphicConfiguration,
	#category : #'Spec2-Examples-SimpleApplication'
}

{ #category : #styling }
SpSimpleExampleConfiguration >> styleSheet [

	^ super styleSheet, (SpStyleSTONReader fromString: '
.application [
	.label [
		.title [
			Font { #name: "Source Code Pro", #size: 24 }
		]
	]	
]')
]
