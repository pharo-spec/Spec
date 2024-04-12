"
I inspect all pointers to the object returned by the evaluation of my context
"
Class {
	#name : 'SpBrowsePointersToCommand',
	#superclass : 'SpSystemDiscoveryCommand',
	#category : 'Spec2-Commands-Navigation',
	#package : 'Spec2-Commands',
	#tag : 'Navigation'
}

{ #category : 'default' }
SpBrowsePointersToCommand class >> defaultDescription [
	^ 'Browse all objects referencing the selected object'
]

{ #category : 'default' }
SpBrowsePointersToCommand class >> shortName [

	^ 'pointers to'
]

{ #category : 'executing' }
SpBrowsePointersToCommand >> execute [
	self target selectedItem value pointersTo inspect
]
