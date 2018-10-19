"
Description
--------------------

I am a UI manager that will always answer true to confirm requests.

I am used by the baseline of Spec because during the loading of Spec Metacello will raise 
"
Class {
	#name : #InImageProjectLoadingUIManager,
	#superclass : #CommandLineUIManager,
	#category : #BaselineOfSpec
}

{ #category : #'ui requests' }
InImageProjectLoadingUIManager >> confirm: queryString trueChoice: trueChoice falseChoice: falseChoice cancelChoice: cancelChoice default: aSymbol [
	^ true
]
