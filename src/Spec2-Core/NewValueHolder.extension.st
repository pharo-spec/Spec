Extension { #name : #NewValueHolder }

{ #category : #'*Spec2-Core' }
NewValueHolder >> getSubscriptionsFromSpValueHolder: aSpValueHolder [
	self flag: #todo.	"This can be removed once NewValueHolder will not be used in multiple list selection anymore."

	aSpValueHolder announcer subscriptions subscriptions do: [ :sub | self announcer basicSubscribe: sub ]
]

{ #category : #'*Spec2-Core' }
NewValueHolder >> getSubscriptionsFromValueHolder: aCollectionValueHolder [
	self flag: #todo.	"This can be removed once NewValueHolder will not be used in multiple list selection anymore."

	aCollectionValueHolder announcer subscriptions subscriptions do: [ :sub | self announcer basicSubscribe: sub ]
]

{ #category : #'*Spec2-Core' }
NewValueHolder >> transferSubscriptionsTo: aValueHolder [
	self flag: #todo. "Double dispatch can be removed once NewValueHolder will not be used in multiple list selection anymore."
	aValueHolder getSubscriptionsFromValueHolder: self
]
