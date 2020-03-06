"
I am a generic adapter used to embed directly a Morph in spec.

Be aware that when you use this, you broke Spec plateform independency and force you application to run only on top of Morphic
"
Class {
	#name : #SpMorphicGenericAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#category : #'Spec2-Deprecated-Adapters'
}

{ #category : #'*Spec2-Deprecated' }
SpMorphicGenericAdapter class >> isDeprecated [
	"You should use #SpMorphPresenter instead of #asSpAdapter."

	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicGenericAdapter class >> morph: morph [

	^ self new
		morph: morph;
		yourself
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicGenericAdapter >> adapter [

	^ self
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicGenericAdapter >> buildWithSpec [

	^ self widget
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicGenericAdapter >> buildWithSpec: aString [ 
	
	^ self buildWithSpec
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicGenericAdapter >> morph [

	^ self widget
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicGenericAdapter >> morph: anObject [

	widget := anObject
]
