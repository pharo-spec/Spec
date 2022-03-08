"
I am a demo page to show how to use spec filtering lists.
"
Class {
	#name : #SpFilteringListsDemoPage,
	#superclass : #SpDemoPage,
	#category : #'Spec2-Examples-Demo-Lists'
}

{ #category : #initialization }
SpFilteringListsDemoPage class >> pageName [

	^ 'Filtering Lists'

]

{ #category : #initialization }
SpFilteringListsDemoPage class >> priority [

	^ 500
]

{ #category : #initialization }
SpFilteringListsDemoPage >> pageClass [

	^ SpDemoFilteringListsPresenter
]
