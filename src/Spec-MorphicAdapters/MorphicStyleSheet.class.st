Class {
	#name : #MorphicStyleSheet,
	#superclass : #Object,
	#instVars : [
		'properties'
	],
	#classVars : [
		'Current'
	],
	#category : #'Spec-MorphicAdapters-StyleSheet'
}

{ #category : #'instance creation' }
MorphicStyleSheet class >> current [

	^ Current ifNil: [ Current := self newDefault ]
]

{ #category : #'instance creation' }
MorphicStyleSheet class >> fromDictionary: aDictionary [

	^ self basicNew 
		initializeWith: aDictionary;
		yourself
	
]

{ #category : #'instance creation' }
MorphicStyleSheet class >> fromProperties: anArrayofProperties [

	^ self fromDictionary: (anArrayofProperties collect: [ :each | each name -> each ]) asDictionary
]

{ #category : #'instance creation' }
MorphicStyleSheet class >> newDefault [
	
	^ self new 
		addClass: #Button with: { MorphicStyleSheetExtent newExtent: 80@25 };
		addClass: #CheckBox with: { MorphicStyleSheetExtent newExtent: 15@25 hResizing: true };
		addClass: #RadioButton with: { MorphicStyleSheetExtent newExtent: 15@25 };
		addClass: #DropList with: { MorphicStyleSheetExtent newExtent: 150@25 hResizing: true };
		addClass: #List with: { MorphicStyleSheetExtent newExtent: 150@100 hResizing: true };
		addClass: #Label with: { MorphicStyleSheetExtent newExtent: 50@25 hResizing: true };
		addClass: #Link with: { MorphicStyleSheetExtent newExtent: 50@25 hResizing: true };
		addClass: #Text with: { MorphicStyleSheetExtent newExtent: 150@100 hResizing: true vResizing: true};
		addClass: #TextInputField with: { MorphicStyleSheetExtent newExtent: 150@25 hResizing: true };
		addClass: #NumberInputField with: { MorphicStyleSheetExtent newExtent: 150@25 hResizing: true };
		yourself
]

{ #category : #accessing }
MorphicStyleSheet >> addClass: aSymbol with: anArray [

	self 
		propertyAt: aSymbol 
		put: (MorphicStyleSheet fromProperties: anArray)
]

{ #category : #operations }
MorphicStyleSheet >> applyTo: aMorph [ 

	aMorph setProperty: #style toValue: self.
	properties valuesDo: [ :each | 
		each applyTo: aMorph ]
]

{ #category : #accessing }
MorphicStyleSheet >> atClass: aName [

	^ self 
		propertyAt: aName 
		ifAbsentPut: [ self class new ]
]

{ #category : #style }
MorphicStyleSheet >> extent [

	^ self propertyAt: #extent
]

{ #category : #style }
MorphicStyleSheet >> height [

	^ self extent height
]

{ #category : #initialization }
MorphicStyleSheet >> initialize [

	super initialize.
	properties := Dictionary new
]

{ #category : #initialization }
MorphicStyleSheet >> initializeWith: aDictionary [ 

	super initialize.
	properties := aDictionary
]

{ #category : #accessing }
MorphicStyleSheet >> properties [ 

	^ properties
]

{ #category : #accessing }
MorphicStyleSheet >> propertyAt: aName [

	^ self propertyAt: aName ifAbsent: [ nil ]
]

{ #category : #accessing }
MorphicStyleSheet >> propertyAt: aName ifAbsent: aBlock [

	^ self properties 
		at: aName 
		ifAbsent: aBlock
]

{ #category : #accessing }
MorphicStyleSheet >> propertyAt: aName ifAbsentPut: aBlock [

	^ self properties 
		at: aName 
		ifAbsentPut: aBlock
]

{ #category : #accessing }
MorphicStyleSheet >> propertyAt: aName put: aValue [

	^ self properties 
		at: aName 
		put: aValue
]

{ #category : #style }
MorphicStyleSheet >> width [

	^ self extent width
]
