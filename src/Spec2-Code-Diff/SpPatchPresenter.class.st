Class {
	#name : #SpPatchPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'#patch => ObservableSlot',
		'#interactionModel => ObservableSlot',
		'#syntaxHighlightTheme',
		'#marks'
	],
	#category : #'Spec2-Code-Diff'
}

{ #category : #specs }
SpPatchPresenter class >> adapterName [

	^ #PatchAdapter
]

{ #category : #'as yet unclassified' }
SpPatchPresenter class >> defaultMarks [

	^ {  
		(SpPatchMark newName: #insert) 
			backgroundColor: (Color green alpha: 0.1); 
			iconName: #changeAdd;
			yourself.
		(SpPatchMark newName: #delete)
			backgroundColor: (Color red alpha: 0.1);
			iconName: #changeRemove;
			yourself.
		(SpPatchMark newName: #change)
			backgroundColor: (Color gray alpha: 0.1);
			iconName: #changeUpdate;
			yourself.
	}
]

{ #category : #private }
SpPatchPresenter >> basicInteractionModel: anInteractionModel [

	interactionModel := anInteractionModel
]

{ #category : #'api - model' }
SpPatchPresenter >> beForBehavior: aBehavior [
	"used when browsing classes or alike"

	self interactionModel: (SpCodeBehaviorInteractionModel on: aBehavior)
]

{ #category : #'api - model' }
SpPatchPresenter >> beForMethod: aMethod [
	"used when browsing methods"

	self interactionModel: (SpCodeMethodInteractionModel on: aMethod)
]

{ #category : #'api - model' }
SpPatchPresenter >> beForScripting [
	"Use in playgrounds"

	self interactionModel: SpCodeScriptingInteractionModel new
]

{ #category : #initialization }
SpPatchPresenter >> initialize [ 

	super initialize.
]

{ #category : #private }
SpPatchPresenter >> interactionModel: anInteractionModel [

	anInteractionModel owner: self.
	self basicInteractionModel: anInteractionModel
]

{ #category : #api }
SpPatchPresenter >> marks [

	^ marks ifNil: [ 
		self marks: self class defaultMarks.
		marks ]
]

{ #category : #api }
SpPatchPresenter >> marks: aCollectionOfMarks [

	marks := aCollectionOfMarks 
		collect: [ :each | each name -> each ]
		as: SmallDictionary
]

{ #category : #private }
SpPatchPresenter >> model [

	^ patch
]

{ #category : #'api - model' }
SpPatchPresenter >> patch: aPatchModel [

	patch := aPatchModel
]

{ #category : #'api - model' }
SpPatchPresenter >> patchFrom: source to: destination [

	self patch: (SpPatchModel 
		newFrom: source 
		to: destination)
]

{ #category : #api }
SpPatchPresenter >> syntaxHighlightTheme [
	"The name of the syntax highlight theme to use (e.g. 'Blue', 'Vintage', 'Solarized', 'Tango'). 
	 If not defined, the component will take the default value from the system."

	^ syntaxHighlightTheme
]

{ #category : #api }
SpPatchPresenter >> syntaxHighlightTheme: aSymbol [
	"The name of the syntax highlight theme to use (e.g. 'Blue', 'Vintage', 'Solarized', 'Tango')"

	syntaxHighlightTheme := aSymbol
]

{ #category : #'api - events' }
SpPatchPresenter >> whenPatchChangedDo: aBlock [

	self property: #patch whenChangedDo: aBlock
]
