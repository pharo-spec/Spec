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

{ #category : #'ui requests' }
InImageProjectLoadingUIManager >> warningDefaultAction: aWarning [
	| logBlock |
	"Pass all warnings, but log them"
	
	logBlock := [:logger |
		logger 
			cr;
			nextPutAll: '*** Warning: ';
			nextPutAll: aWarning description;
			cr ].
	
	Smalltalk logDuring: logBlock.
	self logYellowDuring: logBlock.
	
	aWarning pass
]
