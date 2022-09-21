Extension { #name : #SpPresenter }

{ #category : #'*Spec2-Interactions' }
SpPresenter >> confirm: queryString label: titleString [
	
	^ (self application newConfirm 
		title: titleString;
		label: queryString;
		openModal)
		isOk
]

{ #category : #'*Spec2-Interactions' }
SpPresenter >> request: request initialAnswer: initialAnwser title: title [
	| answer |
	
	answer := self application newRequest
		title: title;
		label: request;
		text: initialAnwser;
		openModal.
					
	answer ifNil: [ SpCancelledInteractionError signal ].
	
	^ answer
]
