"
Demo page for SpecDemoFormPresenter
"
Class {
	#name : #SpDemoFormPage,
	#superclass : #SpDemoPage,
	#category : #'Spec2-Examples-Demo-Forms'
}

{ #category : #initialization }
SpDemoFormPage class >> priority [

	^ 100
]

{ #category : #initialization }
SpDemoFormPage >> pageClass [

	^ SpDemoFormPresenter

]
