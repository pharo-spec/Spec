"
I'm a Spec2 backend for the morphic UI framework. See class comment of class `SpApplicationBackend` for more details
"
Class {
	#name : 'SpMorphicBackend',
	#superclass : 'SpApplicationBackend',
	#category : 'Spec2-Adapters-Morphic-Backend',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Backend'
}

{ #category : 'accessing' }
SpMorphicBackend class >> backendName [

	^ #Morphic
]

{ #category : 'private' }
SpMorphicBackend >> adapterBindingsClass [

	^ SpMorphicAdapterBindings
]

{ #category : 'accessing' }
SpMorphicBackend >> componentListClass [

	^ SpComponentListPresenter
]

{ #category : 'accessing' }
SpMorphicBackend >> defaultConfigurationFor: anApplication [

	^ anApplication defaultConfigurationForMorphic
]

{ #category : 'deferred message' }
SpMorphicBackend >> defer: aBlock [

	UIManager default defer: aBlock
]

{ #category : 'accessing' }
SpMorphicBackend >> dropListClass [

	^ SpDropListPresenter
]

{ #category : 'deferred message' }
SpMorphicBackend >> forceDefer: aBlock [

	UIManager default defer: aBlock
]

{ #category : 'ui - dialogs' }
SpMorphicBackend >> inform: aString [

	(ProvideAnswerNotification signal: aString) ifNotNil: [ :answer | ^ true ].
	GrowlMorph
		openWithLabel: 'Information' translated
		contents: aString
]

{ #category : 'accessing' }
SpMorphicBackend >> listClass [

	^ SpListPresenter
]

{ #category : 'private - notifying' }
SpMorphicBackend >> notifyError: aSpecNotification [

	GrowlMorph
		openWithLabel: 'Error'
		contents: aSpecNotification message
		backgroundColor: GrowlMorph theme dangerBackgroundColor
		labelColor: GrowlMorph theme textColor
]

{ #category : 'private - notifying' }
SpMorphicBackend >> notifyInfo: aSpecNotification [

	GrowlMorph 
		openWithLabel: 'Information' translated 
		contents: aSpecNotification message
]

{ #category : 'display' }
SpMorphicBackend >> showWaitCursorWhile: aBlock inApplication: anApplication [

	Cursor wait showWhile: aBlock
]

{ #category : 'accessing' }
SpMorphicBackend >> tableClass [

	^ SpTablePresenter
]

{ #category : 'accessing' }
SpMorphicBackend >> treeClass [

	^ SpTreePresenter	
]

{ #category : 'accessing' }
SpMorphicBackend >> treeTableClass [

	^ SpTreeTablePresenter
]
