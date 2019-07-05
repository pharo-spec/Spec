Trait {
	#name : #TSpObservable,
	#category : #'Spec2-Core-Observable'
}

{ #category : #events }
TSpObservable >> announcerOfProperty: aName [
	"Return the announcer of the property"

	self flag: #todo. "I am not sure we should have that here but it is used for now..."
	(self observablePropertyNamed: aName) announcer
]

{ #category : #events }
TSpObservable >> notifyPropertyChanged: aName [

	(self observablePropertyNamed: aName) valueChanged
]

{ #category : #events }
TSpObservable >> observablePropertyNamed: aName [
	| slot |
	
	slot := self class slotNamed: aName.
	slot isObservableSlot
		ifFalse: [ SpNonObservableSlotError signal: aName ].

	"Obtain the raw value.
	We need to access the underlying value holder to subscribe to it"
	^ slot rawRead: self
]

{ #category : #events }
TSpObservable >> property: aName rawValue: anObject [
	"Write in the slot without announcing it."

	(self observablePropertyNamed: aName) rawValue: anObject
]

{ #category : #events }
TSpObservable >> property: aName whenChangedDo: aBlockClosure [ 
	
	"Obtain the raw value.
	We need to access the underlying value holder to subscribe to it"
	(self observablePropertyNamed: aName) whenChangedDo: aBlockClosure
]
