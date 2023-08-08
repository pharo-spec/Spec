Class {
	#name : #SpAbstractBackendForTest,
	#superclass : #Object,
	#category : #'Spec2-Backend-Tests-Base'
}

{ #category : #testing }
SpAbstractBackendForTest >> emulateClick: mouseButtonCode onTest: anAdapterTest [ 

	anAdapterTest openInstance.

	MouseButtonEvent yellowButton = mouseButtonCode 
		ifTrue: [ anAdapterTest adapter sendRightClickEvent ].

	MouseButtonEvent redButton = mouseButtonCode 
		ifTrue: [ anAdapterTest adapter clicked ].

	self waitUntilUIRedrawed
]

{ #category : #testing }
SpAbstractBackendForTest >> waitUntilUIRedrawed [
	"Hook. I wait until the UI has been redrawn and events have been handled."
]
