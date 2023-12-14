"
I browse all instances of the class (and all its subclasses) returned by the evaluation of my context 
"
Class {
	#name : 'SpBrowseSubInstancesCommand',
	#superclass : 'SpSystemDiscoveryCommand',
	#category : 'Spec2-Commands-Navigation',
	#package : 'Spec2-Commands',
	#tag : 'Navigation'
}

{ #category : 'default' }
SpBrowseSubInstancesCommand class >> defaultDescription [
	^ 'Browse all instances of the selected class and all its subclasses'
]

{ #category : 'default' }
SpBrowseSubInstancesCommand class >> shortName [

	^ 'all subinstances'
]

{ #category : 'executing' }
SpBrowseSubInstancesCommand >> execute [

	self target instanceSide inspectSubInstances
]
