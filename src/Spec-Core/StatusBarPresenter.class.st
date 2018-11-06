Class {
	#name : #StatusBarPresenter,
	#superclass : #AbstractWidgetPresenter,
	#category : #'Spec-Core-Widgets-Toolbar'
}

{ #category : #specs }
StatusBarPresenter class >> adapterName [

	^ #StatusBarAdapter
]

{ #category : #specs }
StatusBarPresenter class >> defaultSpec [
	<spec: #default>
	
	^ #(StatusBarAdapter
		adapt: #(model))
]
