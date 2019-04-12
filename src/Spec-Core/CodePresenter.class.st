Class {
	#name : #CodePresenter,
	#superclass : #TextPresenter,
	#category : #'Spec-Core-Widgets'
}

{ #category : #specs }
CodePresenter class >> adapterName [

	^ #CodeAdapter
]

{ #category : #examples }
CodePresenter class >> example [
	<sampleInstance>

	^ self new
	 openWithSpec;
		text:
			'some method: 42'

]

{ #category : #specs }
CodePresenter class >> title [

	^ 'Code'
]

{ #category : #initialization }
CodePresenter >> initialize [ 

	super initialize
]
