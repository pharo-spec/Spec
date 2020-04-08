Class {
	#name : #SpPillarTextWriter,
	#superclass : #PRDocumentWriter,
	#instVars : [
		'nesting'
	],
	#category : #'Spec2-Pillar'
}

{ #category : #accessing }
SpPillarTextWriter class >> fileExtension [
	^ 'txt'
]

{ #category : #accessing }
SpPillarTextWriter class >> folderName [
	^ #text
]

{ #category : #accessing }
SpPillarTextWriter class >> writerName [
	^ #text
]

{ #category : #accessing }
SpPillarTextWriter >> canvasClass [
	^ PRTextCanvas
]

{ #category : #private }
SpPillarTextWriter >> nest: aString do: aBlock [
	nesting add: aString.
	aBlock ensure: [ nesting removeLast ]
]

{ #category : #visiting }
SpPillarTextWriter >> start: anObject [
	nesting := OrderedCollection new.
	super start: anObject.
	canvas lastIsNewLine
		ifTrue: [ stream trimLastNewLine ]

]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitDataItem: anObject [
	self nest: ' ' do: [ super visitDataItem: anObject ]
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitDefinitionList: anObject [
	"self halt.
	canvas potentialNewLine."
	self visitAll: anObject children
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitHeader: anObject [
	super visitHeader: anObject.
	canvas newLine
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitHorizontalRule: anObject [
	self halt.
	canvas
		nextPutAll: ((String new: 40) atAllPut: $-);
		newLine
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitLineBreak: aLineBreak [
	canvas newLine
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitListItem: anObject [ 
	"nesting last isInteger ifTrue: [ nesting addLast: nesting removeLast + 1 ].
	nesting size - 1 timesRepeat: [ canvas tab ].
	canvas nextPutAll: nesting last asString.
	canvas nextPutAll: (nesting last isInteger 
			ifTrue: [ '. ' ]
			ifFalse: [ ' ' ])."
	super visitListItem: anObject.
	"canvas potentialNewLine"
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitOrderedList: anObject [
	"self halt.
	canvas potentialNewLine."
	self nest: 0 do: [ super visitOrderedList: anObject ]
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitParagraph: anObject [
	super visitParagraph: anObject.
	canvas newLine
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitPreformatted: anObject [
	"self halt."
	anObject children do: [ :each | self visit: each. canvas newLine ]
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitRaw: anObject [
	self halt.
	(anObject type isNil or: [ anObject type = 'text' ])
		ifTrue: [ canvas nextPutAll: anObject text ]
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitReference: anObject [
	anObject hasAlias
		ifTrue: [ super visitReference: anObject ]
		ifFalse: [ canvas nextPutAll: anObject title ]
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitTableRow: anObject [
	"self halt."
	anObject children
		do: [ :each | self visit: each ]
		separatedBy: [ canvas tab ].
	canvas newLine
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitTermItem: anObject [
	"self halt."
	self nest: '-' do: [ super visitDataItem: anObject ]
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitText: anObject [
	canvas nextPutAll: anObject text
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitUnorderedList: anObject [
	"self halt."
	"canvas potentialNewLine."
	self nest: '*' do: [ super visitUnorderedList: anObject ]
]
