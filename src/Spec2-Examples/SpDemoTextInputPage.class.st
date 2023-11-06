"
Demo page for SpecDemoTextInputPresenter
"
Class {
	#name : 'SpDemoTextInputPage',
	#superclass : 'SpDemoPage',
	#category : 'Spec2-Examples-Demo-TextInput',
	#package : 'Spec2-Examples',
	#tag : 'Demo-TextInput'
}

{ #category : 'specs' }
SpDemoTextInputPage class >> pageName [

	^ 'Text input'
]

{ #category : 'initialization' }
SpDemoTextInputPage class >> priority [

	^ 1200
]

{ #category : 'initialization' }
SpDemoTextInputPage >> pageClass [

	^ SpDemoTextInputPresenter

]
