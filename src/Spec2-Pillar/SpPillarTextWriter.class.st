Class {
	#name : #SpPillarTextWriter,
	#superclass : #PRVisitor,
	#instVars : [
		'nesting',
		'stream'
	],
	#category : #'Spec2-Pillar'
}

{ #category : #writing }
SpPillarTextWriter class >> write: aDocument [
	^ self new 
		visit: aDocument	
]

{ #category : #initialization }
SpPillarTextWriter >> initialize [ 
	super initialize.
	stream := String new writeStream.
	nesting := OrderedCollection new.
]

{ #category : #private }
SpPillarTextWriter >> nest: aString do: aBlock [
	nesting add: aString.
	aBlock ensure: [ nesting removeLast ]
]

{ #category : #private }
SpPillarTextWriter >> newline [
	stream nextPut: Character cr
]

{ #category : #visiting }
SpPillarTextWriter >> start: anObject [
	nesting := OrderedCollection new.
	super start: anObject.
	"canvas lastIsNewLine
		ifTrue: [ stream trimLastNewLine ]"

]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitCodeblock: aCodeBlock [ 
	| code |
	code := self visitText: aCodeBlock.
	self writeAppendix: aCodeBlock.
	^ code
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
SpPillarTextWriter >> visitDocument: aDocument [
	super visitDocument: aDocument.
	^  stream
		flush;
		contents
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitDocumentGroup: anObject [
	| group |
	group := super visitDocumentGroup: anObject.
	self writeAppendix: anObject.
	^ group
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitHorizontalRule: anObject [
	stream
		nextPutAll: ((String new: 40) atAllPut: $-);
		newLine
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitLineBreak: anObject [

	self newline
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
SpPillarTextWriter >> visitPreformatted: anObject [
	anObject children do: [ :each | self visit: each. self newline ]
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitRaw: anObject [
	(anObject type isNil or: [ anObject type = 'text' ])
		ifTrue: [ stream nextPutAll: anObject text ]
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitReference: anObject [
	anObject hasAlias
		ifTrue: [ super visitReference: anObject ]
		ifFalse: [ stream nextPutAll: anObject title ]
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitTableRow: anObject [
	"self halt."
	anObject children
		do: [ :each | self visit: each ]
		separatedBy: [ stream tab ].

]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitTermItem: anObject [
	"self halt."
	self nest: '-' do: [ super visitDataItem: anObject ]
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitText: anObject [
	stream nextPutAll: anObject text.
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> visitUnorderedList: anObject [
	"self halt."
	"canvas potentialNewLine."
	self nest: '*' do: [ super visitUnorderedList: anObject ]
]

{ #category : #'visiting-document' }
SpPillarTextWriter >> writeAppendix: anObject [
	anObject plaintextAppendix ifNotNil: [ :appendix |
		stream nextPutAll: appendix ]
]
