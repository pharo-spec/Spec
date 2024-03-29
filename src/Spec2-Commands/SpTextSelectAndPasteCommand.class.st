Class {
	#name : 'SpTextSelectAndPasteCommand',
	#superclass : 'SpTextEditionCommand',
	#category : 'Spec2-Commands-Code',
	#package : 'Spec2-Commands',
	#tag : 'Code'
}

{ #category : 'defaults' }
SpTextSelectAndPasteCommand class >> defaultIconName [
	^#smallCopy 
]

{ #category : 'default' }
SpTextSelectAndPasteCommand class >> defaultName [

	^ 'Paste...'
]

{ #category : 'execution' }
SpTextSelectAndPasteCommand >> execute [

	context doTextSelectAndPaste
]
