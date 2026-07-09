Extension { #name : 'Object' }

{ #category : '*Spec2-Core' }
Object >> asPresenter [

	^ self asString asPresenter
]

{ #category : '*Spec2-Core' }
Object >> asPresenterOn: aPresenter [

	^ self asString asPresenterOn: aPresenter
]

{ #category : '*Spec2-Core' }
Object >> isPresenter [

	^ false
]

{ #category : '*Spec2-Core' }
Object >> isSpAnnouncingObject [

	^ false
]

{ #category : '*Spec2-Core' }
Object >> isSpLayout [

	^ false
]
