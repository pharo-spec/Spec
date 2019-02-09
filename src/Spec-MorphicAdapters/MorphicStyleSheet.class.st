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
		addClass: #Button with: { MorphicStyleSheetExtent value: 80@26 };
		addClass: #CheckBox with: { MorphicStyleSheetExtent value: 15@26 };
		addClass: #RadioButton with: { MorphicStyleSheetExtent value: 15@26 };
		addClass: #DropList with: { MorphicStyleSheetExtent value: 150@26 };
		addClass: #List with: { MorphicStyleSheetExtent value: 150@104 };
		addClass: #Label with: { MorphicStyleSheetExtent value: 50@26 };
		addClass: #Link with: { MorphicStyleSheetExtent value: 50@26 };
		addClass: #Text with: { MorphicStyleSheetExtent value: 150@104 };
		addClass: #TextInputField with: { MorphicStyleSheetExtent value: 150@26 };
		addClass: #NumberInputField with: { MorphicStyleSheetExtent value: 150@26 };
		yourself
]

{ #category : #adding }
MorphicStyleSheet >> addClass: aSymbol with: anArray [

	self 
		propertyAt: aSymbol 
		put: (MorphicStyleSheet fromProperties: anArray)
]

{ #category : #operations }
MorphicStyleSheet >> applyTo: aMorph [ 

	properties valuesDo: [ :each | each applyTo: aMorph ]
]

{ #category : #accessing }
MorphicStyleSheet >> atClass: aName [

	^ self 
		propertyAt: aName 
		ifAbsentPut: [ self class new ]
]

{ #category : #style }
MorphicStyleSheet >> initialExtent [

	^ self propertyAt: #extent
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
