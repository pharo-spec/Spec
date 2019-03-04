Extension { #name : #MonticelloRepositoryBrowser }

{ #category : #'*Spec-Examples' }
MonticelloRepositoryBrowser class >> example [
	"self example"
	
	self new 
		openWithSpec ; 
		workingCopies: (self allManagers)
]
