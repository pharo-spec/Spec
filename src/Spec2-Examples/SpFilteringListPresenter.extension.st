Extension { #name : #SpFilteringListPresenter }

{ #category : #'*Spec2-Examples' }
SpFilteringListPresenter class >> example [
	<sampleInstance>
	| example |

	example := self new.
	example list items: RBBrowserEnvironment default classes asArray.
	example openWithSpec.
	example withWindowDo: [ :window | 
		window title: self name asString , ' example' ].

	^ example
]

{ #category : #'*Spec2-Examples' }
SpFilteringListPresenter class >> exampleTopLayout [
	<sampleInstance>
	| example |

	example := self new.
	example list items: RBBrowserEnvironment default classes asArray.
	example openWithSpec: #topLayout.
	example withWindowDo: [ :window | 
		window title: self name asString , ' example' ].

	^ example
]
