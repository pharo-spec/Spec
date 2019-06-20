"
I'm a trait that add ""dynamic"" behavior to presenters. 
I can be used to create components that may have variable number of children.
"
Trait {
	#name : #SpTSpecDynamicPresenter,
	#instVars : [
		'presenters'
	],
	#category : #'Spec-Core-Base'
}

{ #category : #'private accessing' }
SpTSpecDynamicPresenter >> basicPresenters [

	^ presenters ifNil: [ presenters := OrderedDictionary new ]
]

{ #category : #accessing }
SpTSpecDynamicPresenter >> presenterAt: aName [

	^ self basicPresenters at: aName 
]

{ #category : #accessing }
SpTSpecDynamicPresenter >> presenterAt: aName ifAbsent: aBlock [

	^ self basicPresenters 
		at: aName 
		ifAbsent: aBlock
]

{ #category : #accessing }
SpTSpecDynamicPresenter >> presenterAt: aName put: aPresenter [

	^ self basicPresenters 
		at: aName 
		put: aPresenter
]

{ #category : #accessing }
SpTSpecDynamicPresenter >> presenters [

	^ self basicPresenters values
]

{ #category : #enumerating }
SpTSpecDynamicPresenter >> presentersDo: aBlock [

	self basicPresenters valuesDo: aBlock
]
