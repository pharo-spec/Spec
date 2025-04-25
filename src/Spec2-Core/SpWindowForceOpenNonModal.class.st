"
This is a dynamic variable to be used while testing (because if we open a dialog real modaly we cannot interact with it until is closed, and then we cannot test).
 
Example: 
```smalltalk
SpWindowForceOpenNonModal during: [
	SpLabelPresenter new openModal ].
```
"
Class {
	#name : 'SpWindowForceOpenNonModal',
	#superclass : 'DynamicVariable',
	#category : 'Spec2-Core-Windows',
	#package : 'Spec2-Core',
	#tag : 'Windows'
}

{ #category : 'api' }
SpWindowForceOpenNonModal class >> during: aBlock [

	^ self value: true during: aBlock
]

{ #category : 'accessing' }
SpWindowForceOpenNonModal >> default [

	^ false
]
