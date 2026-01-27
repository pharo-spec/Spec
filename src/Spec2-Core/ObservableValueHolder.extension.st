Extension { #name : 'ObservableValueHolder' }

{ #category : '*Spec2-Core' }
ObservableValueHolder >> suspendChangedDuring: aBlock [

	aBlock value
]

{ #category : '*Spec2-Core' }
ObservableValueHolder >> unsubscribe: anObject [ 

	subscriptions := subscriptions reject: [ :each | each receiver = anObject ].
]
