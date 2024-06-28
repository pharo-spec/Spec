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

{ #category : 'private - dialogs' }
SpMorphicBackend >> executeOpenDirectoryDialog: aFileDialog [

	^ StOpenDirectoryPresenter new
		defaultFolder: (aFileDialog path ifNil: [ StFileSystemModel defaultDirectory ]);
		title: (aFileDialog title ifNil: [ 'Choose Directory' translated ]);
		openModal;
		selectedEntry
]

{ #category : 'private - dialogs' }
SpMorphicBackend >> executeOpenFileDialog: aFileDialog [
	| dialog |

	dialog := self newFileDialogFor: aFileDialog.
	^ dialog openModal answer 
		ifNotNil: [ :aString | aString asFileReference ]
]

{ #category : 'private - dialogs' }
SpMorphicBackend >> executeSaveFileDialog: aFileDialog [
	| dialog |

	dialog := self newFileDialogFor: aFileDialog.
	dialog answerSaveFile.
	^ dialog openModal answer 
		ifNotNil: [ :aString | aString asFileReference ]
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

{ #category : 'private - dialogs' }
SpMorphicBackend >> newFileDialogFor: aFileDialog [
	| dialog |

	dialog := FileDialogWindow basicNew
		previewType: false;
		initialize;
		title: (aFileDialog title ifNil: [ 'Select File...' ]);
		answerPathName.
	
	aFileDialog filters ifNotEmpty: [ :filters | 
		dialog validExtensions: filters ].
	aFileDialog path ifNotNil: [ :path | 
		dialog fileNameText: path path fullName.
		dialog selectPath: path fullName ].

	^ dialog
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

{ #category : 'ui - dialogs' }
SpMorphicBackend >> openFileDialog: aFileDialog [

	aFileDialog isOpenFile ifTrue: [ ^ self executeOpenFileDialog: aFileDialog ].
	aFileDialog isOpenDirectory ifTrue: [ ^ self executeOpenDirectoryDialog: aFileDialog ].
	
	^ self executeSaveFileDialog: aFileDialog
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
