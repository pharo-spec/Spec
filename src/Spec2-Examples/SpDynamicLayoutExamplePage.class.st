"
I am an example page for the dynamic layouts
"
Class {
	#name : #SpDynamicLayoutExamplePage,
	#superclass : #SpDemoPage,
	#category : #'Spec2-Examples-Demo-Layouts'
}

{ #category : #initialization }
SpDynamicLayoutExamplePage class >> pageName [

	^ 'Dynamic Layouts'
]

{ #category : #initialization }
SpDynamicLayoutExamplePage class >> priority [

	^ 2200
]

{ #category : #initialization }
SpDynamicLayoutExamplePage >> pageClass [

	^ SpDynamicLayoutExamplePresenter
]
