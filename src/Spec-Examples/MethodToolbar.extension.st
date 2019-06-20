Extension { #name : #MethodToolbar }

{ #category : #'*Spec-Examples' }
MethodToolbar class >> example [
	<sampleInstance>
	| example |
	example := MethodToolbar new.
	example
		method: SpButtonPresenter >> #state:;
		method: nil;
		extent: 550 @ 100;
		openWithSpec.
		^example 
]
