Extension { #name : #SpDatePresenter }

{ #category : #'*Spec2-Deprecated' }
SpDatePresenter >> displayBlock [
	"Return the one argument block used to wrap your domain specific items.
	The block should return something that can be displayed in a list - like a String or a Text"

	self
		deprecated: 'Please use #display instead'
		transformWith: '`@receiver displayBlock' 
						-> '`@receiver display'.
	
	^ displayBlock
]

{ #category : #'*Spec2-Deprecated' }
SpDatePresenter >> displayBlock: aBlock [
	"Set the one argument block used to transfrom your date into a string"

	self
		deprecated: 'Please use #display: instead'
		transformWith: '`@receiver displayBlock: `@arg' 
						-> '`@receiver display: `@arg'.

	displayBlock := aBlock
]
