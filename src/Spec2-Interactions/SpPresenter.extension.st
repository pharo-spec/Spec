Extension { #name : #SpPresenter }

{ #category : #'*Spec2-Interactions' }
SpPresenter >> confirm: queryString label: titleString [
	
	^ (self application newConfirm 
		title: titleString;
		message: queryString;
		openModalWithSpec)
		isOk
]

{ #category : #'*Spec2-Interactions' }
SpPresenter >> request: request initialAnswer: initialAnwser title: title [
	| answer |
	
	answer := self application newRequest
		title: title;
		label: request;
		text: initialAnwser;
		openModalWithSpec.
					
	answer ifFalse: [ SpCancelledInteractionError signal ].
	
	^ answer
]
