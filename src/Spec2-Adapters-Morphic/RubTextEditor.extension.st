Extension { #name : 'RubTextEditor' }

{ #category : '*Spec2-Adapters-Morphic' }
RubTextEditor >> lineAtCursorPosition [
	| string |
	
	string := self text asString ifEmpty: [ ^ '' ].
	^ self lineIntervalAtCursorPosition
		ifNotNil: [ :anInterval | string copyFrom: anInterval first to: anInterval last ]
		ifNil: [ '' ]
]

{ #category : '*Spec2-Adapters-Morphic' }
RubTextEditor >> lineIntervalAtCursorPosition [
	| string lastEnd index lastStart |
	
	index := self pointIndex.
	string := self text asString ifEmpty: [ ^ nil ].
	string lineIndicesDo: [ :start :endWithoutDelimiters :end | 
		index <= end ifTrue: [ 
			^ start to: endWithoutDelimiters ].
		lastStart := start.
		lastEnd := end ].
	
	"evaluate the case where the cursor is placed at the end of the text (there will not 
	 be delimiter, but there will be a line to answer anyway (maybe empty)"
	^ lastEnd + 1 <= index 
		ifTrue: [ lastStart to: lastEnd ]
		ifFalse: [ nil ]
]
