"
I build a ToolBarPresenter from a group of commands.

To do that, I visit recursively groups of command breadth first and simple add each command encountered to the tool bar.
"
Class {
	#name : #SpToolbarPresenterBuilder,
	#superclass : #CmVisitor,
	#instVars : [
		'toolbarPresenter'
	],
	#category : #'Spec2-Commander2-Visitors'
}

{ #category : #private }
SpToolbarPresenterBuilder >> addPopoverButtonFrom: aCommandsGroup [
	| button |

	self toolbarPresenter addItem: ((button := self toolbarPresenter newToolbarPopoverButton) 
		label: aCommandsGroup name;
		icon: aCommandsGroup icon;
		content: [ 
			self class new
				toolbarPresenter: self toolbarPresenter newToolbar;
				visit: aCommandsGroup copy beToolbarGroup;
				toolbarPresenter ];
		yourself)	
]

{ #category : #initialization }
SpToolbarPresenterBuilder >> initialize [
	super initialize.
	self toolbarPresenter: SpToolbarPresenter new.
]

{ #category : #accessing }
SpToolbarPresenterBuilder >> toolbarPresenter [
	^ toolbarPresenter
]

{ #category : #accessing }
SpToolbarPresenterBuilder >> toolbarPresenter: anObject [
	toolbarPresenter := anObject
]

{ #category : #visiting }
SpToolbarPresenterBuilder >> visitCommand: anEntry [

	"initialize icon provider if it is not there."
	anEntry iconProvider ifNil: [ 
		anEntry iconProvider: self toolbarPresenter application ].
	anEntry positionStrategy
		addButton: anEntry buildPresenter
		toToolbar: self toolbarPresenter
]

{ #category : #visiting }
SpToolbarPresenterBuilder >> visitCommandGroup: aGroup [
	
	"initialize icon provider if it is not there."
	aGroup iconProvider ifNil: [ 
		aGroup iconProvider: self toolbarPresenter application ].
	aGroup isToolbarPopoverButton 
		ifTrue: [ self addPopoverButtonFrom: aGroup ]
		ifFalse: [ super visitCommandGroup: aGroup ]
]
