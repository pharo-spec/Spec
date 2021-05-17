Extension { #name : #SHRBTextStyler }

{ #category : #'*Spec2-Code' }
SHRBTextStyler class >> initialTextAttributesForPixelHeight: aNumber styleTable: aStyleTable [ 
	| d |
	
	d := IdentityDictionary new.
	aStyleTable do: [ :each | 
		| textStyle element emphasis font pixelHeight attrArray color textStyleName |
		element := each first.
		color := each at: 2 ifAbsent: [].
		color := color ifNotNil: [Color colorFrom: color].
		emphasis := each at: 3 ifAbsent: [].
		textStyleName := each at: 4 ifAbsent: [].
		pixelHeight := each at: 5 ifAbsent: [aNumber].
		textStyleName ifNil: [pixelHeight := nil].
		textStyle := TextStyle named: textStyleName.
		font := textStyle ifNotNil: [ pixelHeight ifNotNil: [textStyle fontOfSize: pixelHeight]].
		attrArray := self
			attributeArrayForColor: color
			emphasis: emphasis
			font: font.
		attrArray ifNotEmpty: [ d at: element put: attrArray ] ].

	^ d
]

{ #category : #'*Spec2-Code' }
SHRBTextStyler class >> newAttributesForStyleTable: aTable [
	
	^ self 
		initialTextAttributesForPixelHeight: TextStyle defaultFont pixelSize 
		styleTable: aTable
]

{ #category : #'*Spec2-Code' }
SHRBTextStyler class >> newAttributesForStyleTableNamed: aString [
	| table |
	
	table := self styleTableNamed: aString.
	^ self newAttributesForStyleTable: (table ifNil: [ self styleTable ])
]

{ #category : #'*Spec2-Code' }
SHRBTextStyler class >> styleTableNamed: aString [
		
	^ (Pragma allNamed: #styleTable: in: SHRBTextStyler class)
		detect: [ :each | (each argumentAt: 1) = aString ]
		ifFound: [ :each | self perform: each methodSelector ]
		ifNone: [ nil ]
]
