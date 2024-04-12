"
A trait to add ""model"" behavior to a presenter.
"
Trait {
	#name : 'SpTModel',
	#instVars : [
		'model'
	],
	#category : 'Spec2-Core-Widgets',
	#package : 'Spec2-Core',
	#tag : 'Widgets'
}

{ #category : 'accessing - model' }
SpTModel >> model [

	^ model
]

{ #category : 'accessing - model' }
SpTModel >> model: aModel [

	model := aModel.
	self updatePresenter
]

{ #category : 'private' }
SpTModel >> setModel: aModel [

	self model: aModel
]

{ #category : 'accessing - model' }
SpTModel >> setModelBeforeInitialization: aModel [

	model := aModel
]
