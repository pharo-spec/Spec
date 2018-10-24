Class {
	#name : #StatusBarPresenter,
	#superclass : #ToolBarPresenter,
	#category : #'Spec-Core-Widgets'
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
