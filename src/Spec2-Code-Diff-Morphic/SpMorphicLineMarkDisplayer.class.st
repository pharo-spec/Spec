Class {
	#name : #SpMorphicLineMarkDisplayer,
	#superclass : #RubScrolledTextSideRuler,
	#instVars : [
		'adapter'
	],
	#category : #'Spec2-Code-Diff-Morphic'
}

{ #category : #querying }
SpMorphicLineMarkDisplayer class >> key [
	^ #patchLineMarks
]

{ #category : #accessing }
SpMorphicLineMarkDisplayer >> adapter [

	^ adapter
]

{ #category : #accessing }
SpMorphicLineMarkDisplayer >> adapter: anObject [

	adapter := anObject
]

{ #category : #accessing }
SpMorphicLineMarkDisplayer >> backgroundColor [
	^ self paragraphProvider lineNumbersBackgroundColor 
]

{ #category : #geometry }
SpMorphicLineMarkDisplayer >> computedWidthFrom: aRectangle [
	^ (((self fontToUse widthOfString: self paragraph numberOfPhysicalLines asString) + self horizontalGapBefore
		+ self horizontalGapAfter + self verticalSeparatorWidth) max: self minimumWidth) truncated
]

{ #category : #drawing }
SpMorphicLineMarkDisplayer >> drawOn: aCanvas [
	| right font lines visibleRectangle left lineMarks lineMarkNumbers |
	
	super drawOn: aCanvas.
	
	self paragraph selectionStart ifNil: [ ^ self ].
	self paragraph selectionStop ifNil: [ ^ self ].
	self paragraph lines ifNil: [ ^ self ].
	
	right := self bounds right.
	left := self bounds left.
	font := self fontToUse. "needed for the ygap"
	lines := self lines.
	lineMarks := self adapter lineMarks asDictionary.
	lineMarkNumbers := lineMarks keys.

	aCanvas
		clipBy: self bounds
		during: [ :clippedCanvas | 
			clippedCanvas 
				fillRectangle: self verticalSeparatorBounds 
				color: self verticalSeparatorColor.
			
			visibleRectangle := clippedCanvas clipRect.
			((self lineIndexForPoint: visibleRectangle topLeft) to: (self lineIndexForPoint: visibleRectangle bottomRight))
			select: [ :i | lineMarkNumbers includes: i ] 
			thenDo: [ :i | 
				| line iconForm lineBounds ygap |

				line := lines at: i.			
				ygap := ((line lineHeight - font height) // 2 - 1) rounded.
				iconForm := self iconNamed: (self markAt: (lineMarks at: i) value) iconName. 
				lineBounds := self side = #left
					ifTrue: [ 
						(right - (iconForm width/2)) @ (line bottom - font height - ygap) corner: (right + (iconForm width/2)) @ line bottom ]
					ifFalse: [ 
						(left + self horizontalGapBefore) @ (line bottom - font height - ygap) corner: right @ line bottom ].
				lineBounds := lineBounds translateBy: 0 @ (self offset y negated + self bounds top).
				clippedCanvas 
					translucentImage: iconForm
					at: lineBounds topLeft - (iconForm width@0) ] ]
]

{ #category : #drawing }
SpMorphicLineMarkDisplayer >> drawOnAthensCanvas: aCanvas [
	| prev right font lines visibleRectangle tcolor left |
	
	true ifTrue: [ ^ self ].
	
	super drawOnAthensCanvas: aCanvas.
	self paragraph selectionStart ifNil: [ ^ self ].
	self paragraph selectionStop ifNil: [ ^ self ].
	self paragraph lines ifNil: [ ^ self ].
	right := self bounds right.
	left := self bounds left.
	font := self fontToUse.
	prev := nil.
	lines := self lines.
	tcolor := self textColor.
	aCanvas
		clipBy: self bounds
		during: [ 
			| backBnd |
			aCanvas setShape: self verticalSeparatorBounds.
			aCanvas setPaint: self verticalSeparatorColor.
			aCanvas draw.
			visibleRectangle := aCanvas clipRect.
			(self lineIndexForPoint: visibleRectangle topLeft) to: (self lineIndexForPoint: visibleRectangle bottomRight) do: [ :i | 
				| line |
				line := lines at: i.
				(self selectionStart == self selectionStop and: [self selectionStop textLine lineNumber = line lineNumber])
					ifTrue: [ 
						backBnd := self bounds.
						backBnd := (backBnd left) @ line top corner: self verticalSeparatorBounds left @ line bottom.
						backBnd := backBnd translateBy: 0 @ (self offset y negated + self bounds top).
						aCanvas setShape: backBnd.
						aCanvas setPaint: self selectionColorToUse.
						aCanvas draw ].
				prev = line lineNumber
					ifFalse: [ 
						| lineMark lineBnd ygap |
						ygap := ((line lineHeight - font height) // 2 - 1) rounded.
						lineMark := line lineNumber asString.
						self side = #left
							ifTrue: [ 
								| width |
								width := (self fontToUse widthOfString: lineMark) + self horizontalGapAfter.
								lineBnd := (right - width) @ (line bottom - font height - ygap) corner: (right + width) @ line bottom ]
							ifFalse: [ lineBnd := (left + self horizontalGapBefore) @ (line bottom - font height - ygap) corner: right @ line bottom ].
						lineBnd := lineBnd translateBy: 0 @ (self offset y negated + self bounds top).
						aCanvas morphicDrawString: lineMark in: lineBnd font: font color: tcolor.
						prev := line lineNumber ] ] ]
]

{ #category : #accessing }
SpMorphicLineMarkDisplayer >> fontToUse [

	^ self textArea font
]

{ #category : #menus }
SpMorphicLineMarkDisplayer >> getMenu: shiftState [
	"Answer the menu to be presented when the yellow button is pressed while the shift key is down"

	^ nil "self menu"
]

{ #category : #'event handling' }
SpMorphicLineMarkDisplayer >> handlesMouseDown: evt [
	^ true
]

{ #category : #geometry }
SpMorphicLineMarkDisplayer >> horizontalGapAfter [
	^ 3
]

{ #category : #geometry }
SpMorphicLineMarkDisplayer >> horizontalGapBefore [
	^ 3
]

{ #category : #accessing }
SpMorphicLineMarkDisplayer >> iconNamed: aSymbol [

	^ self adapter presenter application iconNamed: aSymbol
]

{ #category : #accessing }
SpMorphicLineMarkDisplayer >> level [
	^ 2
]

{ #category : #accessing }
SpMorphicLineMarkDisplayer >> markAt: aSymbol [

	^ self adapter markAt: aSymbol
]

{ #category : #menus }
SpMorphicLineMarkDisplayer >> menu [
	"Answer the menu to be presented when the yellow button is pressed while the shift key is down"

	^ (PragmaMenuBuilder pragmaKeyword: self menuKeyword  model: self) menu
]

{ #category : #menus }
SpMorphicLineMarkDisplayer >> menuKeyword [ 
	^ #RubLineNumberMenu
	
]

{ #category : #geometry }
SpMorphicLineMarkDisplayer >> minimumWidth [
	^ (self fontToUse widthOfString: 'MM') + self horizontalGapAfter + self horizontalGapBefore + self  verticalSeparatorWidth 

]

{ #category : #'event handling' }
SpMorphicLineMarkDisplayer >> mouseDown: anEvent [
	| lineIndex line |
	(anEvent yellowButtonPressed and: [ anEvent commandKeyPressed not ]) "First check for option (menu) click"
		ifTrue: [ ^ (self yellowButtonActivity: anEvent shiftPressed) ].

	lineIndex := self lineIndexForPoint: anEvent position.
	line := self lines at: lineIndex.
	anEvent setPosition: line topLeft.
	self textArea mouseDown: anEvent
]

{ #category : #'event handling' }
SpMorphicLineMarkDisplayer >> mouseMove: anEvent [
	| lineIndex line |
	lineIndex := self lineIndexForPoint: anEvent position.
	line := self lines at: lineIndex.
	anEvent setPosition: line topLeft.
	self textArea mouseMove: anEvent

]

{ #category : #'event handling' }
SpMorphicLineMarkDisplayer >> mouseUp: anEvent [
	| lineIndex line |
	lineIndex := self lineIndexForPoint: anEvent position.
	line := self lines at: lineIndex.
	anEvent setPosition: line topLeft.
	self textArea mouseUp: anEvent.

]

{ #category : #accessing }
SpMorphicLineMarkDisplayer >> selectionColorToUse [
	^ self primarySelectionColor
]

{ #category : #accessing }
SpMorphicLineMarkDisplayer >> textColor [
	^ self textArea lineNumbersTextColor 

]

{ #category : #accessing }
SpMorphicLineMarkDisplayer >> verticalSeparatorBounds [
	| bnds  |
	bnds := self bounds.
	^ self side = #left
		ifTrue: [ (bnds topRight -  (self verticalSeparatorWidth @ 0)) corner: bnds bottomRight ]
		ifFalse: [ (bnds topLeft corner: bnds bottomLeft + (self verticalSeparatorWidth @ 0)) ]
]

{ #category : #accessing }
SpMorphicLineMarkDisplayer >> verticalSeparatorColor [
	^ (self textArea backgroundColor contrastingBlackAndWhiteColor ) alpha: 0.3
]

{ #category : #accessing }
SpMorphicLineMarkDisplayer >> verticalSeparatorWidth [
	^ 1
]

{ #category : #'event handling' }
SpMorphicLineMarkDisplayer >> yellowButtonActivity: shiftKeyState [ 
	"Invoke the text-editing menu.
	Check if required first!"
	(self getMenu: shiftKeyState)
		ifNotNil: [ :menu|
			menu invokeModal. 
			self changed.
			^ true].
	^ true
]
