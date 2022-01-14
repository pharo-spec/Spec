Extension { #name : #SpFilteringListPresenter }

{ #category : #'*Spec2-Examples' }
SpFilteringListPresenter classSide >> example [
	<sampleInstance>
	| example |

	example := self new.
	example items: RBBrowserEnvironment default classes asArray.
	example openWithSpec.
	example withWindowDo: [ :window | 
		window title: self name asString , ' example' ].

	^ example
]

{ #category : #'*Spec2-Examples' }
SpFilteringListPresenter classSide >> exampleWithFilterOnTop [
	<sampleInstance>
	| example |

	example := self new.
	example items: RBBrowserEnvironment default classes asArray.
	example openWithSpec: #topLayout.
	example withWindowDo: [ :window | 
		window title: self name asString , ' example' ].

	^ example
]

{ #category : #'*Spec2-Examples' }
SpFilteringListPresenter classSide >> exampleWithInitializedFilter [

	<sampleInstance>
	| example |
	example := self new.
	example matchSubstring.
	example items: RBBrowserEnvironment default classes asArray.
	example displayIcon: [ :aClass | aClass systemIcon ].
	example applyFilter: 'ZZ'.
	example openWithSpec title:
		self name asString , ' example with filter'.

	^ example
]
