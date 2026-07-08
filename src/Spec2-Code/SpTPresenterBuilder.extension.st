Extension { #name : 'SpTPresenterBuilder' }

{ #category : '*Spec2-Code' }
SpTPresenterBuilder >> newCode [

	^ self instantiate: SpCodePresenter
]

{ #category : '*Spec2-Code' }
SpTPresenterBuilder >> newCodeEditor [

	^ self instantiate: SpCodeEditorPresenter
]
