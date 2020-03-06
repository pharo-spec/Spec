Class {
	#name : #SpSearchableListTest,
	#superclass : #SpSmokeTest,
	#category : #'Spec2-Deprecated-Tests'
}

{ #category : #'*Spec2-Deprecated' }
SpSearchableListTest class >> isDeprecated [
	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpSearchableListTest >> classToTest [
	^ SpSearchableList
]

{ #category : #'*Spec2-Deprecated' }
SpSearchableListTest >> testFiltering [
	presenter items: {'aa' . 'bb' . 'ab' . 'ba'}.
	presenter searchPresenter text: 'a'.
	self assertCollection: presenter listPresenter items hasSameElements: {'aa' . 'ab'}
]
