"
I'm a base adapter for layouts.
"
Class {
	#name : #MorphicLayoutAdapter,
	#superclass : #AbstractMorphicAdapter,
	#category : #'Spec-MorphicAdapters-Layout'
}

{ #category : #initialization }
MorphicLayoutAdapter >> applyStyle: aMorph [
	
]

{ #category : #factory }
MorphicLayoutAdapter >> buildWidget [

	^ nil
]

{ #category : #factory }
MorphicLayoutAdapter >> buildWithSpec [
	
	^ self widget
]

{ #category : #factory }
MorphicLayoutAdapter >> buildWithSpec: aString [ 

	^ self buildWithSpec
]
