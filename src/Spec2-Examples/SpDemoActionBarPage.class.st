"
Demo page for SpecDemoActionBarPresenter
"
Class {
	#name : #SpDemoActionBarPage,
	#superclass : #SpDemoPage,
	#category : #'Spec2-Examples-Demo-Buttons'
}

{ #category : #specs }
SpDemoActionBarPage class >> pageName [

	^ 'ActionBar'
]

{ #category : #initialization }
SpDemoActionBarPage class >> priority [

	^ 800
]

{ #category : #initialization }
SpDemoActionBarPage >> pageClass [

	^ SpDemoActionBarPresenter
]
