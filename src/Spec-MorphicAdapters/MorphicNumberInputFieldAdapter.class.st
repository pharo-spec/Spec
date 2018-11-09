"
I am the adapter used to display a NumberInputFieldPresenter with Morphic
"
Class {
	#name : #MorphicNumberInputFieldAdapter,
	#superclass : #MorphicTextAdapter,
	#category : #'Spec-MorphicAdapters-Base'
}

{ #category : #'widget API' }
MorphicNumberInputFieldAdapter >> accept: aText [
	| textToSet |
	
	textToSet := (self shouldAccept: aText)
		ifTrue: [ aText ]
		ifFalse: [ self model text ].
		
	self model accept: textToSet
]

{ #category : #'widget API' }
MorphicNumberInputFieldAdapter >> acceptOnCR [

	^ self model acceptOnCR
]

{ #category : #initialization }
MorphicNumberInputFieldAdapter >> adapt: aModel [
	
	super adapt: aModel.
	aModel whenBuiltDo: [ :w | w widget color: Smalltalk ui theme backgroundColor ]
]

{ #category : #factory }
MorphicNumberInputFieldAdapter >> buildWidget [
	| plu |
	plu := PluggableTextFieldMorph new
		convertTo: String;
		on: self
			text: #getText
			accept: #accept:
			readSelection: nil
			menu: nil
			setSelection: #setSelection:.
	plu
		entryCompletion: self entryCompletion;
		autoAccept: self autoAccept;
		ghostText: self placeholder;
		enabled: self enabled;
		setBalloonText: self help;
		dragEnabled: self dragEnabled;
		dropEnabled: self dropEnabled;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		acceptOnCR: self acceptOnCR;
		hideScrollBarsIndefinitely;
		eventHandler: (MorphicEventHandler new on: #keyStroke send: #keystroke:from: to: self).
	^ plu
]

{ #category : #'as yet unclassified' }
MorphicNumberInputFieldAdapter >> decreaseValueOf: aTextMorph [
	aTextMorph setTextAndAccept: (self decreasedValueFrom: aTextMorph getText)
]

{ #category : #'as yet unclassified' }
MorphicNumberInputFieldAdapter >> decreasedValueFrom: aString [
	"I get the current value from a string and decrease it by the step.
	
	In case of a float we need to print only up to a number of decimals even if the step is of the right number of decimals because float do not have a good precision."

	| newValue |
	newValue := aString ifEmpty: [ 0 ] ifNotEmpty: [ :text | text asNumber - self model climbRate ].
	newValue := self inBounds: newValue.
	
	^ self model isInteger
		ifTrue: [ newValue rounded asString ]
		ifFalse: [ newValue printShowingDecimalPlaces: self model digits ]
]

{ #category : #'widget API' }
MorphicNumberInputFieldAdapter >> entryCompletion [

	^ self model entryCompletion
]

{ #category : #accessing }
MorphicNumberInputFieldAdapter >> inBounds: aNumber [
	^ self inferiorToMaximum: (self superiorToMinimum: aNumber)
]

{ #category : #'as yet unclassified' }
MorphicNumberInputFieldAdapter >> increaseValueOf: aTextMorph [
	aTextMorph setTextAndAccept: (self increasedValueFrom: aTextMorph getText)
]

{ #category : #'as yet unclassified' }
MorphicNumberInputFieldAdapter >> increasedValueFrom: aString [
	"I get the current value from a aString and increase it by the step.
	
	In case of a float we need to print only up to a number of decimals even if the step is of the right number of decimals because float do not have a good precision."

	| newValue |
	newValue := aString ifEmpty: [ 0 ] ifNotEmpty: [ :text | text asNumber + self model climbRate ].
	newValue := self inBounds: newValue.
	
	^ self model isInteger
		ifTrue: [ newValue rounded asString ]
		ifFalse: [ newValue printShowingDecimalPlaces: self model digits ]
]

{ #category : #accessing }
MorphicNumberInputFieldAdapter >> inferiorToMaximum: aNumber [
	^ self model maximum ifNil: [ aNumber ] ifNotNil: [ :max | aNumber min: max ]
]

{ #category : #NOCompletion }
MorphicNumberInputFieldAdapter >> isCodeCompletionAllowed [
	
	^ false
]

{ #category : #events }
MorphicNumberInputFieldAdapter >> keystroke: aKeyboardEvent from: aTextMorph [

	aKeyboardEvent keyCharacter = Character arrowUp
		ifTrue: [ self increaseValueOf: aTextMorph.
			^ true ].

	aKeyboardEvent keyCharacter = Character arrowDown
		ifTrue: [ self decreaseValueOf: aTextMorph.
			^ true ].
		
	^ false
]

{ #category : #'widget API' }
MorphicNumberInputFieldAdapter >> placeholder [
	^ self model placeholder
]

{ #category : #'widget API' }
MorphicNumberInputFieldAdapter >> placeholder: aText [
	^ self model placeholder: aText
]

{ #category : #testing }
MorphicNumberInputFieldAdapter >> shouldAccept: aText [
	| regex value |
	aText ifEmpty: [ ^ true ].

	"First we check if it matches the number type and the number of digits if it is a float."
	regex := self model isInteger
		ifTrue: [ '(\-)?[0-9]*' ]
		ifFalse: [ '(\-)?[0-9]+(\.[0-9]{0,' , self model digits asString , '})?' ].
		
	(regex asRegex matches: aText) ifFalse: [ ^ false ].

	"Then we need to verify the min and max value"
	value := aText asNumber.
	self model minimum ifNotNil: [ :min | value < min ifTrue: [ ^ false ] ].
	self model maximum ifNotNil: [ :max | value > max ifTrue: [ ^ false ] ].
	
	^ true
	
]

{ #category : #accessing }
MorphicNumberInputFieldAdapter >> superiorToMinimum: aNumber [
	^ self model minimum ifNil: [ aNumber ] ifNotNil: [ :min | aNumber max: min ]
]
