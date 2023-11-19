"
I am a visitor that builds a Spec MenuBarPresenter from a commands and commands group.
"
Class {
	#name : 'SpMenuBarPresenterBuilder',
	#superclass : 'SpMenuPresenterBuilder',
	#category : 'Spec2-Commander2-Visitors',
	#package : 'Spec2-Commander2',
	#tag : 'Visitors'
}

{ #category : 'accessing' }
SpMenuBarPresenterBuilder class >> menuPresenterClass [
	^ SpMenuBarPresenter
]
