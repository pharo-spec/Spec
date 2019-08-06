Class {
	#name : #SpStyleLookup,
	#superclass : #Object,
	#instVars : [
		'styles'
	],
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #'instance creation' }
SpStyleLookup class >> fromStylesheet: aStyle adapter: anAdapter [
	| allStyleClasses |
		
	allStyleClasses := aStyle flattenClasses.
	"WARNING. Order is important"
	^ self newStyles: (({ 'application'. anAdapter newStyleName }, anAdapter presenter styles) 
		collect: [ :each |
			"a hack to not do a double dispatch on string :(" 
			each isString 
				ifTrue: [ allStyleClasses detect: [ :eachStyle | eachStyle fullName = each ] ] 
				ifFalse: [ each ] ])
]

{ #category : #'instance creation' }
SpStyleLookup class >> newStyles: anArray [

	^ self new 
		styles: anArray;
		yourself
]

{ #category : #accessing }
SpStyleLookup >> applyTo: aMorph [ 

	self styles do: [ :each |
		each applyTo: aMorph ]
]

{ #category : #'accessing container' }
SpStyleLookup >> borderWidth [

	^ self lookupProperty: SpStyleContainer valueOf: #borderWidth
]

{ #category : #'accessing geometry' }
SpStyleLookup >> extent [

	^ self lookupProperty: SpStyleGeometry valueOf: #extent
]

{ #category : #'accessing font' }
SpStyleLookup >> font [

	^ self lookupProperty: SpStyleFont valueOf: #definedFont
]

{ #category : #'accessing geometry' }
SpStyleLookup >> height [

	^ self lookupProperty: SpStyleGeometry valueOf: #height
]

{ #category : #private }
SpStyleLookup >> lookupProperty: aPropertyClass valueOf: aSymbol [

	(self propertiesLike: aPropertyClass)
		reverseDo: [ :each | 
			(each perform: aSymbol) 
				ifNotNil: [ :value | ^ value ] ].
	^ nil
]

{ #category : #'accessing geometry' }
SpStyleLookup >> maxHeight [

	^ self lookupProperty: SpStyleGeometry valueOf: #maxHeight
]

{ #category : #'accessing geometry' }
SpStyleLookup >> maxWidth [

	^ self lookupProperty: SpStyleGeometry valueOf: #maxWidth
]

{ #category : #'accessing geometry' }
SpStyleLookup >> minHeight [

	^ self lookupProperty: SpStyleGeometry valueOf: #minHeight
]

{ #category : #'accessing geometry' }
SpStyleLookup >> minWidth [

	^ self lookupProperty: SpStyleGeometry valueOf: #minWidth
]

{ #category : #'accessing container' }
SpStyleLookup >> padding [ 

	^ self lookupProperty: SpStyleContainer valueOf: #padding
]

{ #category : #private }
SpStyleLookup >> propertiesLike: aClass [

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
SpStyleLookup >> styles [
	^ styles
]

{ #category : #accessing }
SpStyleLookup >> styles: anObject [
	styles := anObject
]

{ #category : #'accessing geometry' }
SpStyleLookup >> width [

	^ self lookupProperty: SpStyleGeometry valueOf: #width
]
