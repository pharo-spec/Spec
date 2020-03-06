Extension { #name : #SpMorphicGenericAdapter }

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
SpMorphicGenericAdapter class >> isDeprecated [
	"You should use #SpMorphPresenter instead of #asSpAdapter."

	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicGenericAdapter >> morph [

	^ self widget
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicGenericAdapter >> morph: anObject [

	widget := anObject
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicGenericAdapter class >> morph: morph [

	^ self new
		morph: morph;
		yourself
]
