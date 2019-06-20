Extension { #name : #SpDiffPresenter }

{ #category : #'*Spec-Deprecated80' }
SpDiffPresenter >> aboutToStyle: aBoolean [
	self
		deprecated:
			'This method is an horrible hack because the VersionBrowser was using Code or Diff presenter but was only using the API of the Code presenter... This method and other methods from the CodePresenter API will be removed.'
]

{ #category : #'*Spec-Deprecated80' }
SpDiffPresenter >> behavior [
	self
		deprecated:
			'This method is an horrible hack because the VersionBrowser was using Code or Diff presenter but was only using the API of the Code presenter... This method and other methods from the CodePresenter API will be removed.'.
	^ self contextClass
]

{ #category : #'*Spec-Deprecated80' }
SpDiffPresenter >> behavior: aClass [
	self
		deprecated:
			'This method is an horrible hack because the VersionBrowser was using Code or Diff presenter but was only using the API of the Code presenter... This method and other methods from the CodePresenter API will be removed.'.
	self contextClass: aClass
]

{ #category : #'*Spec-Deprecated80' }
SpDiffPresenter >> doItReceiver: aReceiver [
	self
		deprecated:
			'This method is an horrible hack because the VersionBrowser was using Code or Diff presenter but was only using the API of the Code presenter... This method and other methods from the CodePresenter API will be removed.'
]

{ #category : #'*Spec-Deprecated80' }
SpDiffPresenter >> getText [
	self
		deprecated:
			'This method is an horrible hack because the VersionBrowser was using Code or Diff presenter but was only using the API of the Code presenter... This method and other methods from the CodePresenter API will be removed.'.
	^ self rightText
]

{ #category : #'*Spec-Deprecated80' }
SpDiffPresenter >> text: aPairOfString [
	self
		deprecated:
			'This method is an horrible hack because the VersionBrowser was using Code or Diff presenter but was only using the API of the Code presenter... This method and other methods from the CodePresenter API will be removed.'.
	(aPairOfString isText or: [ aPairOfString isString ])
		ifTrue: [ self leftText: ''.
			self rightText: aPairOfString ]
		ifFalse: [ self leftText: aPairOfString first.
			self rightText: aPairOfString second ]
]
