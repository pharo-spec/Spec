"
A SpecLayoutSend is a spec layout action used when a selector is sent to the layout
"
Class {
	#name : #SpLayoutSend,
	#superclass : #SpAbstractSpecLayoutAction,
	#category : #'Spec2-Layout-Deprecated'
}

{ #category : #'instance creation' }
SpLayoutSend class >> selector: selector [

	^ self new
		selector: selector;
		yourself
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> arguments [
	^ {  }
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> bottomFraction [

	^ 0
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> bottomFraction: aNumber [

	^ 0
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> bottomOffset [

	^ 0
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> bottomOffset: aNumber [

	^ 0
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> isSplitter [

	^ false
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> leftFraction [

	^ 0
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> leftFraction: aNumber [

	^ 0
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> leftOffset [

	^ 0
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> leftOffset: aNumber [

	^ 0
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> rightFraction [

	^ 0
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> rightFraction: aNumber [

	^ 0
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> rightOffset [

	^ 0
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> rightOffset: aNumber [

	^ 0
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> topFraction [

	^ 0
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> topFraction: aNumber [

	^ 0
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> topOffset [

	^ 0
]

{ #category : #'Spec2-Deprecated' }
SpLayoutSend >> topOffset: aNumber [

	^ 0
]
