Class {
	#name : 'SpEasyColumnBindBuilder',
	#superclass : 'SpEasyColumnVisitor',
	#instVars : [
		'item'
	],
	#category : 'Spec2-ListView',
	#package : 'Spec2-ListView'
}

{ #category : 'accessing' }
SpEasyColumnBindBuilder >> item [

	^ item
]

{ #category : 'accessing' }
SpEasyColumnBindBuilder >> item: anObject [

	item := anObject
]

{ #category : 'visiting' }
SpEasyColumnBindBuilder >> visitCheckboxColumn: aColumn [

	self presenter
		state: (aColumn readObject: self item);
		whenActivatedDo: [ aColumn onActivation value: self item ];
		whenDeactivatedDo: [ aColumn onDeactivation value: self item ]
]

{ #category : 'visiting' }
SpEasyColumnBindBuilder >> visitCompositeColumn: aColumn [
	| presenters visitor |
	
	visitor := self class new
		item: self item;
		yourself.
	presenters := self presenter layout presenters.
	aColumn columns withIndexDo: [ :each :index | 
		visitor 
			presenter: (presenters at: index);
		 	visit: each ]
]

{ #category : 'visiting' }
SpEasyColumnBindBuilder >> visitImageColumn: aColumn [

	^ self presenter image: (aColumn readObject: self item) 
]

{ #category : 'visiting' }
SpEasyColumnBindBuilder >> visitLinkColumn: aColumn [

	self item ifNil: [ 
		self presenter label: ''.
		^ self ].
	
	self presenter
		label: (aColumn readObject: self item) asString;
		action: [ aColumn action value: self item ]
]

{ #category : 'visiting' }
SpEasyColumnBindBuilder >> visitStringColumn: aColumn [

	^ self presenter label: (self item 
		ifNotNil: [ :anObject | (aColumn readObject: anObject) asString ]
		ifNil: [ '' ])
]
