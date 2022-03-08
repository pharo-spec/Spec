"
Description
--------------------

I am a demo showing a demo of tables.
"
Class {
	#name : #SpDemoTablePage,
	#superclass : #SpDemoPage,
	#category : #'Spec2-Examples-Demo-Tables'
}

{ #category : #initialization }
SpDemoTablePage class >> pageName [
	^ 'Tables'
]

{ #category : #initialization }
SpDemoTablePage class >> priority [

	^ 200
]

{ #category : #initialization }
SpDemoTablePage >> pageClass [
	^ SpDemoTablePresenter
]
