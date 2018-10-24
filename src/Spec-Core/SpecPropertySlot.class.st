Class {
	#name : #SpecPropertySlot,
	#superclass : #IndexedSlot,
	#category : #'Spec-Core-Base'
}

{ #category : #properties }
SpecPropertySlot >> propertyAt: anObject [

	^ super read: anObject
]

{ #category : #'meta-object-protocol' }
SpecPropertySlot >> read: anObject [
	| holder |

	holder := super read: anObject.
	^ holder ifNotNil: [ holder value ]
]

{ #category : #'meta-object-protocol' }
SpecPropertySlot >> write: aValue to: anObject [
	| holder |
	 
	holder := super read: anObject.
	holder ifNil: [ 
		^ super write: (NewValueHolder value: aValue) to: anObject ].
	holder value: aValue
]
