Extension { #name : #SpNotebookPresenter }

{ #category : #'*Spec2-Examples' }
SpNotebookPresenter class >> example [

	^ self new 
		addPageTitle: 'Test 1' provider: [ SpLabelPresenter new label: 'Content 1' ];
		addPageTitle: 'Test 2' provider: [ SpLabelPresenter new label: 'Content 2' ];
		addPageTitle: 'Test 3' provider: [ SpLabelPresenter new label: 'Content 3' ];
		open
]
