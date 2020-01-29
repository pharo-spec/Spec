Class {
	#name : #SpBrowsePointersToCommand,
	#superclass : #SpSystemDiscoveryCommand,
	#category : #'Spec2-Commands-Navigation'
}

{ #category : #default }
SpBrowsePointersToCommand class >> defaultDescription [
	^ 'Browse all objects referencing the selected object'
]

{ #category : #accessing }
SpBrowsePointersToCommand class >> shortName [

	^ 'pointers to'
]

{ #category : #executing }
SpBrowsePointersToCommand >> execute [
	self context pointersTo
]
