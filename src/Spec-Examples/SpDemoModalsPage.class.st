"
Description
--------------------

Demo page for SpecDemoModalPresenter
"
Class {
	#name : #SpDemoModalsPage,
	#superclass : #SpDemoPage,
	#category : #'Spec-Examples-Demo-Modals'
}

{ #category : #specs }
SpDemoModalsPage class >> pageName [

	^ 'Modals'
]

{ #category : #specs }
SpDemoModalsPage class >> priority [

	^ 30
]

{ #category : #initialization }
SpDemoModalsPage >> pageClass [

	^ SpDemoModalPresenter

]
