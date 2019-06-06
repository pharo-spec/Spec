"
A group of option buttons
"
Class {
	#name : #ToolBarOptionButtonGroup,
	#superclass : #ToolBarItemPresenter,
	#instVars : [
		'options'
	],
	#category : #'Spec-Core-Widgets-Toolbar'
}

{ #category : #specs }
ToolBarOptionButtonGroup class >> adapterName [

	^ #ToolBarOptionButtonGroupAdapter
]

{ #category : #accessing }
ToolBarOptionButtonGroup >> addOption: anOption [

	(anOption isSelected not and: [ options isEmpty ])
		ifTrue: [ anOption beSelected ].
		
	(anOption isSelected and: [ options notEmpty ])
		ifTrue: [ options do: #beUnselected ].	

	options add: anOption.
	anOption buttonGroup: self.
]

{ #category : #initialization }
ToolBarOptionButtonGroup >> initialize [
	super initialize.
	options := OrderedCollection new
]

{ #category : #accessing }
ToolBarOptionButtonGroup >> options [
	^ options
]

{ #category : #accessing }
ToolBarOptionButtonGroup >> options: anObject [
	options := anObject
]

{ #category : #refreshing }
ToolBarOptionButtonGroup >> refresh [
	self shouldBeImplemented.
]

{ #category : #selection }
ToolBarOptionButtonGroup >> unselectAll [
	
	options do: #beUnselected
]
