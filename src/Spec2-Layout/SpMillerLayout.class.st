Class {
	#name : #SpMillerLayout,
	#superclass : #SpExecutableLayout,
	#instVars : [
		'direction',
		'spacing',
		'borderWidth'
	],
	#category : #'Spec2-Layout-Miller'
}

{ #category : #'instance creation' }
SpMillerLayout class >> new [ 

	self error: 'Use one of my siblings'
]

{ #category : #'instance creation' }
SpMillerLayout class >> newHorizontal [ 

	^ super new beHorizontal
]

{ #category : #'instance creation' }
SpMillerLayout class >> newVertical [ 

	^ super new beVertical
]

{ #category : #private }
SpMillerLayout >> adapterName [

	^ #MillerAdapter
]

{ #category : #adding }
SpMillerLayout >> add: aName [

	self 
		add: aName 
		withConstraints: [ :constraints | ]
]

{ #category : #adding }
SpMillerLayout >> add: aPresenter withConstraints: aBlock [
	
	super add: aPresenter withConstraints: aBlock.
	adapter ifNotNil: [ :theAdapter |
		theAdapter add: aPresenter constraints: (children at: aPresenter) ]
]

{ #category : #initialization }
SpMillerLayout >> beHorizontal [

	direction := SpLayoutDirection horizontal
]

{ #category : #initialization }
SpMillerLayout >> beVertical [

	direction := SpLayoutDirection vertical
]

{ #category : #accessing }
SpMillerLayout >> borderWidth [

	^ borderWidth
]

{ #category : #accessing }
SpMillerLayout >> borderWidth: aNumber [

	borderWidth := aNumber
]

{ #category : #private }
SpMillerLayout >> constraintsClass [

	^ SpLayoutConstraints
]

{ #category : #accessing }
SpMillerLayout >> direction [ 

	^ direction
]

{ #category : #initialization }
SpMillerLayout >> initialize [

	super initialize.
	self spacing: 0.
	self borderWidth: 0
]

{ #category : #testing }
SpMillerLayout >> isHorizontal [ 

	^ self direction = SpLayoutDirection horizontal
]

{ #category : #testing }
SpMillerLayout >> isVertical [ 

	^ self direction = SpLayoutDirection vertical
]

{ #category : #removing }
SpMillerLayout >> remove: aPresenter [

	children removeKey: aPresenter.
	adapter ifNotNil: [ :theAdapter | theAdapter remove: aPresenter ]
]

{ #category : #removing }
SpMillerLayout >> removeAll [

	children removeAll.
	adapter ifNotNil: [ :anAdapter | anAdapter removeAll ]
]

{ #category : #accessing }
SpMillerLayout >> spacing [

	^ spacing
]

{ #category : #accessing }
SpMillerLayout >> spacing: aNumber [

	spacing := aNumber
]
