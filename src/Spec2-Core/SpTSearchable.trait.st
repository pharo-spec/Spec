"
I add search capability to lists/tables and trees. 
I implement basic common API but real implementation (as always) needs to be done in the backend adapters. 
"
Trait {
	#name : #SpTSearchable,
	#instVars : [
		'#searchEnabled => SpObservableSlot'
	],
	#category : #'Spec2-Core-Widgets-Table'
}

{ #category : #accessing }
SpTSearchable >> disableSearch [

	searchEnabled := false
]

{ #category : #accessing }
SpTSearchable >> enableSearch [

	searchEnabled := true
]

{ #category : #initialization }
SpTSearchable >> initialize [
	
	self class initializeSlots: self.
	super initialize.
]

{ #category : #testing }
SpTSearchable >> isSearchEnabled [

	^ searchEnabled
]

{ #category : #'api-events' }
SpTSearchable >> whenSearchChangedDo: aBlock [

	self property: #searchEnabled whenChangedDo: aBlock
]
