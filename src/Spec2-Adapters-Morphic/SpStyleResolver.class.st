Class {
	#name : #SpStyleResolver,
	#superclass : #Object,
	#instVars : [
		'styles'
	],
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #'instance creation' }
SpStyleResolver class >> newStyles: anArray [

	^ self new 
		styles: anArray;
		yourself
]

{ #category : #'accessing container' }
SpStyleResolver >> borderWidth [

	^ self lookupProperty: SpStyleContainer valueOf: #borderWidth
]

{ #category : #'accessing geometry' }
SpStyleResolver >> extent [

	^ self lookupProperty: SpStyleGeometry valueOf: #extent
]

{ #category : #'accessing font' }
SpStyleResolver >> font [

	^ self lookupProperty: SpStyleFont valueOf: #definedFont
]

{ #category : #'accessing geometry' }
SpStyleResolver >> height [

	^ self lookupProperty: SpStyleGeometry valueOf: #height
]

{ #category : #private }
SpStyleResolver >> lookupProperty: aPropertyClass valueOf: aSymbol [

	(self propertiesLike: aPropertyClass)
		reverseDo: [ :each | 
			(each perform: aSymbol) 
				ifNotNil: [ :value | ^ value ] ].
	^ nil
]

{ #category : #'accessing container' }
SpStyleResolver >> padding [ 

	^ self lookupProperty: SpStyleContainer valueOf: #padding
]

{ #category : #private }
SpStyleResolver >> propertiesLike: aClass [

	^ (self styles 
		inject: OrderedCollection new
		into: [ :all :eachStyle | 
			eachStyle flattenProperties 
				select: [ :eachProperty | eachProperty class = aClass ]
				thenDo: [ :eachProperty | all add: eachProperty ].
			all ])
		flattened
]

{ #category : #accessing }
SpStyleResolver >> styles [
	^ styles
]

{ #category : #accessing }
SpStyleResolver >> styles: anObject [
	styles := anObject
]

{ #category : #'accessing geometry' }
SpStyleResolver >> width [

	^ self lookupProperty: SpStyleGeometry valueOf: #width
]
