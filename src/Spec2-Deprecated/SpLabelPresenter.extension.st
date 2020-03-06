Extension { #name : #SpLabelPresenter }

{ #category : #'*Spec2-Deprecated' }
SpLabelPresenter >> emphasis [

	self deprecated: 'You need to use a style to affect enfasis (see #addStyle:).'.

	^ nil
]

{ #category : #'*Spec2-Deprecated' }
SpLabelPresenter >> emphasis: anEmphasis [
	"accepts a symbol or an array of symbols: #bold, #italic, #underline, #narrow, #struck"

	self deprecated: 'You need to use a style to affect enfasis (see #addStyle:).'
]

{ #category : #'*Spec2-Deprecated' }
SpLabelPresenter >> labelHolder [
	self deprecated: 'Nobody should access directly to internals of Spec. Now this variable is not a value holder anymore.'
]
