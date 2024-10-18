"
A simple presenter builder class that uses `SpTPresenterBuilder`. 
It allows users to compose presenters without hardcoding class name.

The following two lines are equivalent and the second one is preferred for common presenters.

```
list := self instantiate: SpListPresenter
list := self newList.
```
"
Class {
	#name : 'SpPresenterBuilder',
	#superclass : 'Object',
	#traits : 'SpTPresenterBuilder',
	#classTraits : 'SpTPresenterBuilder classTrait',
	#instVars : [
		'application'
	],
	#category : 'Spec2-Core-Base',
	#package : 'Spec2-Core',
	#tag : 'Base'
}

{ #category : 'instance creation' }
SpPresenterBuilder class >> newApplication: anApplication [
	
	^ self new 
		application: anApplication;
		yourself
]

{ #category : 'accessing' }
SpPresenterBuilder >> application [

	^ application
]

{ #category : 'accessing' }
SpPresenterBuilder >> application: anApplication [

	application := anApplication
]

{ #category : 'instance creation' }
SpPresenterBuilder >> instantiate: aPresenterClass [
	"Instantiate a SpPresenter subclass and set its instance owner"
	
	^ aPresenterClass new
]

{ #category : 'instance creation' }
SpPresenterBuilder >> instantiate: aPresenterClass on: aModel [
	"Instantiate a SpPresenter subclass and set its instance owner and model"

	^ aPresenterClass on: aModel
]
