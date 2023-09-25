"
I am an announcement emitted when a window will be closed.
"
Class {
	#name : 'SpWindowWillClose',
	#superclass : 'SpWindowAnnouncement',
	#instVars : [
		'canClose'
	],
	#category : 'Spec2-Core-Windows',
	#package : 'Spec2-Core',
	#tag : 'Windows'
}

{ #category : 'accessing' }
SpWindowWillClose >> allowClose [

	canClose := true
]

{ #category : 'testing' }
SpWindowWillClose >> canClose [

	^ canClose
]

{ #category : 'accessing' }
SpWindowWillClose >> denyClose [

	canClose := false
]

{ #category : 'initialization' }
SpWindowWillClose >> initialize [

	super initialize. 
	canClose := true
]
