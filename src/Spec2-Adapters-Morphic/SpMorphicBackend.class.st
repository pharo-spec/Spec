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
SpMorphicBackend >> diffClass [

	^ SpDiffPresenter
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
	"If we are not in interactive mode, we log in the stdout. Else we delegate to the Morphic notification"

	Smalltalk isInteractive
		ifTrue: [ 
			GrowlMorph openWithLabel: 'Information' contents: aString ]
		ifFalse: [
			Smalltalk logDuring: [ :aLogger |
	            aLogger
	            		cr; nextPutAll: (String new: 79 withAll: $=);
		            cr; nextPutAll: 'Notice: '; nextPutAll: aString;
		            cr; nextPutAll: (String new: 79 withAll: $=);
		            cr ] ]
]

{ #category : 'ui - dialogs' }
SpMorphicBackend >> inform: aString action: aBlock [
	"If we are not in interactive mode, we log in the stdout. Else we delegate to the Morphic notification"

	Smalltalk isInteractive
		ifTrue: [ 
			(ProvideAnswerNotification signal: aString) ifNotNil: [ :answer | ^ true ].
			(GrowlMorph openWithLabel: 'Information' translated contents: aString)
				vanishDelay: 2 second;
				actionBlock: aBlock	]
		ifFalse: [
			Smalltalk logDuring: [ :aLogger |
	            aLogger
	            		cr; nextPutAll: (String new: 79 withAll: $=);
		            cr; nextPutAll: 'Notice: '; nextPutAll: aString;
		            cr; nextPutAll: (String new: 79 withAll: $=);
		            cr ] ]
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
		openWithLabel: 'Information' 
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
