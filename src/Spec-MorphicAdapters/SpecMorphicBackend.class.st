Class {
	#name : #SpecMorphicBackend,
	#superclass : #SpecApplicationBackend,
	#category : #'Spec-MorphicAdapters-Backend'
}

{ #category : #accessing }
SpecMorphicBackend class >> backendName [

	^ #Morphic
]

{ #category : #private }
SpecMorphicBackend >> adapterBindingsClass [

	^ MorphicAdapterBindings
]

{ #category : #'private notifying' }
SpecMorphicBackend >> notifyError: aSpecNotification [

	GrowlMorph 
		openWithLabel: 'Error' 
		contents: aSpecNotification message 
		backgroundColor: Smalltalk ui theme dangerBackgroundColor
		labelColor: Smalltalk ui theme textColor
]

{ #category : #'private notifying' }
SpecMorphicBackend >> notifyInfo: aSpecNotification [

	GrowlMorph 
		openWithLabel: 'Information' translated 
		contents: aSpecNotification message
]
