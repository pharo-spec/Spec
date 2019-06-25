"
A ClassMethodBrowser is a simple browser using spec and reusing MethodBrowser to browse classes>>methods>>sourceCode.

self example
"
Class {
	#name : #SpClassMethodBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'listModel',
		'methodModel'
	],
	#category : #'Spec2-Examples-Standalone'
}

{ #category : #specs }
SpClassMethodBrowser class >> defaultSpec [
<spec>
	^ SpLayout composed
		newRow: [:row | row
						add: #listModel;
						add: #methodModel ];
		yourself
]

{ #category : #specs }
SpClassMethodBrowser class >> defaultSpec2 [
<spec: #default>

	^ SpLayout composed
		newRow: [:r | 
			r 
				newColumn: #listModel right: 0.5;
				addVSplitter;
				newColumn: #(methodModel listModel) left: 0.5 ] bottom: 0.5;
		addHSplitter;
		newRow: #(methodModel textModel) top: 0.5;
		yourself
]

{ #category : #example }
SpClassMethodBrowser class >> example [
	<sampleInstance>
	| example |
	example := SpClassMethodBrowser new.
	example
		classes: Smalltalk allClasses;
		openWithSpec.
		^example
]

{ #category : #specs }
SpClassMethodBrowser class >> title [

	^ 'Class Method Browser'
]

{ #category : #api }
SpClassMethodBrowser >> classes: aList [

	self listModel items: aList
]

{ #category : #initialization }
SpClassMethodBrowser >> initializePresenter [
	listModel
		whenSelectionChangedDo: [ :selection | 
			selection isEmpty
				ifFalse: [ methodModel
						methods:
							(selection selectedItem methods
								sort: [ :a :b | a selector < b selector ]).
					methodModel listModel unselectAll ] ]
]

{ #category : #initialization }
SpClassMethodBrowser >> initializeWidgets [
	listModel := self instantiate:  SpListPresenter .
	methodModel := self instantiate: SpMethodBrowser.
	self focusOrder
		add: listModel;
		add: methodModel.
	methodModel displayBlock: [ :method | method selector ]
]

{ #category : #accessing }
SpClassMethodBrowser >> listModel [

	^ listModel
]

{ #category : #accessing }
SpClassMethodBrowser >> methodModel [

	^ methodModel
]
