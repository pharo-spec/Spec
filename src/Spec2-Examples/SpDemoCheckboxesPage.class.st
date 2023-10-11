"
Demo page for SpecDemoCheckboxesPresenter
"
Class {
	#name : 'SpDemoCheckboxesPage',
	#superclass : 'SpDemoPage',
	#category : 'Spec2-Examples-Demo-Checkboxes',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Checkboxes'
}

{ #category : 'specs' }
SpDemoCheckboxesPage class >> pageName [

	^ 'Checkboxes'
]

{ #category : 'initialization' }
SpDemoCheckboxesPage class >> priority [

	^ 1000
]

{ #category : 'initialization' }
SpDemoCheckboxesPage >> pageClass [

	^ SpDemoCheckboxesPresenter

]
