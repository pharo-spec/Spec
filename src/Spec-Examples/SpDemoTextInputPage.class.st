"
Demo page for SpecDemoTextInputPresenter
"
Class {
	#name : #SpDemoTextInputPage,
	#superclass : #SpDemoPage,
	#category : #'Spec-Examples-Demo-TextInput'
}

{ #category : #specs }
SpDemoTextInputPage class >> pageName [

	^ 'Text input'
]

{ #category : #specs }
SpDemoTextInputPage class >> priority [

	^ 20
]

{ #category : #initialization }
SpDemoTextInputPage >> pageClass [

	^ SpDemoTextInputPresenter

]
