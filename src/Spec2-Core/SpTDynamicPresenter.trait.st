"
I'm a trait that add ""dynamic"" behavior to presenters. 
I can be used to create components that may have variable number of children.

DEPRECATED: This trait should not be used, since all presenters are dynamic now.
"
Trait {
	#name : 'SpTDynamicPresenter',
	#instVars : [
		'presenters'
	],
	#category : 'Spec2-Core-Base',
	#package : 'Spec2-Core',
	#tag : 'Base'
}

{ #category : 'testing' }
SpTDynamicPresenter classSide >> isDeprecated [

	^ true
]

{ #category : 'private - accessing' }
SpTDynamicPresenter >> basicPresenters [

	^ presenters ifNil: [ presenters := OrderedDictionary new ]
]

{ #category : 'accessing' }
SpTDynamicPresenter >> presenterAt: aName [

	^ self basicPresenters 
		at: aName 
		ifAbsent: [ self readSlotNamed: aName  ]
]

{ #category : 'accessing' }
SpTDynamicPresenter >> presenterAt: aName ifAbsent: aBlock [
	^ self basicPresenters
		at: aName
		ifAbsent: [ [ self readSlotNamed: aName ]
				on: SlotNotFound
				do: aBlock ]
]

{ #category : 'accessing' }
SpTDynamicPresenter >> presenterAt: aName put: aPresenter [

	^ self basicPresenters 
		at: aName 
		put: aPresenter
]

{ #category : 'accessing' }
SpTDynamicPresenter >> presenters [

	^ self basicPresenters values
]

{ #category : 'enumerating' }
SpTDynamicPresenter >> presentersDo: aBlock [

	self basicPresenters valuesDo: aBlock
]
