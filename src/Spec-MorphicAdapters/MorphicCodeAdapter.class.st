Class {
	#name : #MorphicCodeAdapter,
	#superclass : #MorphicTextAdapter,
	#category : #'Spec-MorphicAdapters-Base'
}

{ #category : #'widget API' }
MorphicCodeAdapter >> behavior [

	^ self model behavior
]

{ #category : #'spec protocol' }
MorphicCodeAdapter >> classOrMetaClass: aClass [
	self setEditingModeFor: self widget withBehavior: aClass
]

{ #category : #'widget API' }
MorphicCodeAdapter >> doItContext [

	^ self model doItContext
]

{ #category : #'widget API' }
MorphicCodeAdapter >> doItReceiver [

	^ self model doItReceiver
]

{ #category : #NOCompletion }
MorphicCodeAdapter >> guessTypeForName: aString [

	^nil
]

{ #category : #initialization }
MorphicCodeAdapter >> initialize [

	super initialize.
]

{ #category : #shout }
MorphicCodeAdapter >> isAboutToStyle [

	^ self model isAboutToStyle
]

{ #category : #NOCompletion }
MorphicCodeAdapter >> isCodeCompletionAllowed [

	^ true
]

{ #category : #'private-shout' }
MorphicCodeAdapter >> okToStyle [

	^ true
]

{ #category : #NOCompletion }
MorphicCodeAdapter >> receiverClass [

	^ self behavior
]

{ #category : #'widget API' }
MorphicCodeAdapter >> selectedBehavior [

	^ self model selectedBehavior
]

{ #category : #NOCompletion }
MorphicCodeAdapter >> selectedClassOrMetaClass [

	^ self behavior
]

{ #category : #private }
MorphicCodeAdapter >> setEditingModeFor: textArea [ 

	self setEditingModeFor: textArea withBehavior: self behavior
]

{ #category : #private }
MorphicCodeAdapter >> setEditingModeFor: textArea withBehavior: behavior [

	behavior
		ifNotNil: [ :class | textArea beForSmalltalkCodeInClass: class ]		
		ifNil: [ textArea beForSmalltalkScripting ]
]

{ #category : #shout }
MorphicCodeAdapter >> shoutAboutToStyle: aMorph [
	
	^ self model isAboutToStyle
]
