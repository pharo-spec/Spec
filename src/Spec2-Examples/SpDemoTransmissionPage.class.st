"
I am a page for displaying the transmission example in the Spec demo presenter
"
Class {
	#name : #SpDemoTransmissionPage,
	#superclass : #SpDemoPage,
	#category : #'Spec2-Examples-Demo-Transmission'
}

{ #category : #initialization }
SpDemoTransmissionPage class >> pageName [

	^ 'Transmissions'
]

{ #category : #initialization }
SpDemoTransmissionPage class >> priority [

	^ 1110
]

{ #category : #initialization }
SpDemoTransmissionPage >> pageClass [

	^ SpTransmissionExample
]
