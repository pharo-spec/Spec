Class {
	#name : 'SpNotebookPageMorph',
	#superclass : 'Morph',
	#instVars : [
		'actualPageMorph',
		'lazyPageMorphCreation',
		'labelMorph',
		'model'
	],
	#category : 'Spec2-Adapters-Morphic-Notebook',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Notebook'
}

{ #category : 'accessing' }
SpNotebookPageMorph >> actualPageMorph [

	^ actualPageMorph ifNil: [
		actualPageMorph := self lazyPageMorphCreation value
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			yourself ]
]

{ #category : 'accessing' }
SpNotebookPageMorph >> actualPageMorph: anObject [

	actualPageMorph := anObject
]

{ #category : 'testing' }
SpNotebookPageMorph >> isRendered [

	^ actualPageMorph isNotNil
]

{ #category : 'accessing' }
SpNotebookPageMorph >> labelMorph [

	^ labelMorph
]

{ #category : 'accessing' }
SpNotebookPageMorph >> labelMorph: anObject [

	labelMorph := anObject
]

{ #category : 'accessing' }
SpNotebookPageMorph >> lazyPageMorphCreation [

	^ lazyPageMorphCreation
]

{ #category : 'accessing' }
SpNotebookPageMorph >> lazyPageMorphCreation: anObject [

	lazyPageMorphCreation := anObject
]

{ #category : 'accessing' }
SpNotebookPageMorph >> model [

	^ model
]

{ #category : 'accessing' }
SpNotebookPageMorph >> model: anObject [

	model := anObject
]

{ #category : 'initialization' }
SpNotebookPageMorph >> reset [

	self actualPageMorph: nil
]

{ #category : 'theme' }
SpNotebookPageMorph >> themeChanged [

	super themeChanged.
	labelMorph themeChanged.
	actualPageMorph ifNotNil: [ 
		actualPageMorph themeChanged ]
]
