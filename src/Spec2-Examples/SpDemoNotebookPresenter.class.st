"
Description
--------------------

I am a presenter to show how to use notebook with spec.
"
Class {
	#name : #SpDemoNotebookPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'notebook',
		'checkbox',
		'dynamicPage'
	],
	#category : #'Spec2-Examples-Demo-Notebook'
}

{ #category : #examples }
SpDemoNotebookPresenter class >> example [
	^ self new open
]

{ #category : #pages }
SpDemoNotebookPresenter >> browserPage [

	^ SpNotebookPage
		title: 'Browser'
		icon: (self iconNamed: #nautilusIcon)
		provider: [ 
			SpClassMethodBrowser new
				classes: self class environment allClasses;
				yourself ]
]

{ #category : #initialization }
SpDemoNotebookPresenter >> connectPresenters [
	super connectPresenters.

	checkbox whenActivatedDo: [ notebook addPage: (dynamicPage := self dynamicPage) ].

	checkbox
		whenDeactivatedDo: [ dynamicPage
				ifNotNil: [ :page | 
					notebook removePage: page.
					dynamicPage := nil ] ]
]

{ #category : #layout }
SpDemoNotebookPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: notebook;
		  add: checkbox expand: false;
		  yourself
]

{ #category : #pages }
SpDemoNotebookPresenter >> dynamicPage [
	^ SpNotebookPage title: 'Dynamic' icon: (self iconNamed: #nautilusIcon) provider: [ SpDynamicWidgetChange new ]
]

{ #category : #initialization }
SpDemoNotebookPresenter >> initializePresenters [

	notebook := self newNotebook.
	checkbox := self newCheckBox.
	checkbox label: 'Show dynamic presenter'.

	notebook
		addPage: self objectClassPage;
		addPage: self objectInspectorPage;
		addPage: self browserPage
]

{ #category : #pages }
SpDemoNotebookPresenter >> objectClassPage [

	^ (SpNotebookPage 
		title: 'Object class' 
		icon: (self iconNamed: #nautilusIcon) 
		provider: [ 
			SpDemoMessageBrowser new
				messages: Object methods;
				yourself ])
		beCloseable;
		yourself
]

{ #category : #pages }
SpDemoNotebookPresenter >> objectInspectorPage [
	^ SpNotebookPage
		title: 'Object inspector'
		icon: (self iconNamed: #nautilusIcon)
		provider: [ 
			SpObjectInspector new
				inspect: Object;
				yourself ]
		layoutSpec: #inspectorSpec
]
