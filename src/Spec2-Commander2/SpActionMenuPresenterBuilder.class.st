Class {
	#name : 'SpActionMenuPresenterBuilder',
	#superclass : 'SpMenuPresenterBuilder',
	#category : 'Spec2-Commander2-Action',
	#package : 'Spec2-Commander2',
	#tag : 'Action'
}

{ #category : 'private' }
SpActionMenuPresenterBuilder >> fillItem: aMenuItem with: aCommand [

	super fillItem: aMenuItem with: aCommand.
	aMenuItem name: aCommand dynamicName
]

{ #category : 'accessing' }
SpActionMenuPresenterBuilder >> menuPresenter: aMenuPresenter [

	menuPresenter := aMenuPresenter.
	stack := Stack new
		push: self menuPresenter;
		yourself
]

{ #category : 'visiting' }
SpActionMenuPresenterBuilder >> visitCommand: aCmCommand [

	aCmCommand isVisible ifFalse: [ ^ self ].
	super visitCommand: aCmCommand
]
