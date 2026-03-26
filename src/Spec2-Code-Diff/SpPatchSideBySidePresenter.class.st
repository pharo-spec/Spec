Class {
	#name : 'SpPatchSideBySidePresenter',
	#superclass : 'SpPatchPresenter',
	#instVars : [
		'#lineNumbers => ObservableSlot'
	],
	#category : 'Spec2-Code-Diff',
	#package : 'Spec2-Code-Diff'
}

{ #category : 'specs' }
SpPatchSideBySidePresenter class >> adapterName [

	^ #PatchSideBySideAdapter
]

{ #category : 'testing' }
SpPatchSideBySidePresenter >> hasLineNumbers [

	^ lineNumbers
]

{ #category : 'initialization' }
SpPatchSideBySidePresenter >> initialize [

	super initialize.
	self showLineNumbers
]

{ #category : 'private' }
SpPatchSideBySidePresenter >> lineNumbers: aBoolean [

	lineNumbers := aBoolean
]

{ #category : 'private' }
SpPatchSideBySidePresenter >> showLineNumbers [

	self lineNumbers: self application codeShowLineNumbers
]

{ #category : 'api - events' }
SpPatchSideBySidePresenter >> whenLineNumbersChangedDo: aBlock [

	self property: #lineNumbers whenChangedDo: aBlock
]

{ #category : 'accessing - rulers' }
SpPatchSideBySidePresenter >> withLineNumbers [

	self lineNumbers: true
]

{ #category : 'accessing - rulers' }
SpPatchSideBySidePresenter >> withoutLineNumbers [

	self lineNumbers: false
]
