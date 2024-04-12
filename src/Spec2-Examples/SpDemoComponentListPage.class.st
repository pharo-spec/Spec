"
Demo page for component list.

"
Class {
	#name : 'SpDemoComponentListPage',
	#superclass : 'SpDemoPage',
	#category : 'Spec2-Examples-Demo-Labeled',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Labeled'
}

{ #category : 'initialization' }
SpDemoComponentListPage class >> pageName [

	^ 'Component List'
]

{ #category : 'initialization' }
SpDemoComponentListPage class >> priority [

	^ 1310
]

{ #category : 'initialization' }
SpDemoComponentListPage >> pageClass [
	^ SpTransmissionComponentListExample
]
