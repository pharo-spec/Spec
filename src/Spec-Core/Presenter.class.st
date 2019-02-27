Class {
	#name : #Presenter,
	#superclass : #Model,
	#traits : 'TSpecObservable',
	#classTraits : 'TSpecObservable classTrait',
	#instVars : [
		'adapter',
		'owner'
	],
	#category : #'Spec-Core-Base'
}

{ #category : #accessing }
Presenter >> adapter [

	^ adapter
]

{ #category : #accessing }
Presenter >> adapter: anAdapter [

	adapter := anAdapter
]

{ #category : #accessing }
Presenter >> owner [

	^ owner
]

{ #category : #accessing }
Presenter >> owner: aPresenterOrApplication [

	owner := aPresenterOrApplication
]

{ #category : #accessing }
Presenter >> spec [
	self flag: #TODO. "This needs to be removed, but there is a problem with the interpreter.
	(it will be solved as soon as the interpreter is removed :P)"
	
	^ self adapter
]

{ #category : #accessing }
Presenter >> spec: anAdapter [
	"This is a remaining of other times... spec accesor in fact contains an adapter"
	
	self flag: #TODO. "Same as #spec, it needs to go"
	self adapter: anAdapter
]
