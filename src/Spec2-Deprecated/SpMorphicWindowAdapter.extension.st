Extension { #name : #SpMorphicWindowAdapter }

{ #category : #'*Spec2-Deprecated' }
SpMorphicWindowAdapter >> modalRelativeTo: aWindow [
	self deprecated: 'Do not use this directly. Use #openModalWithSpec (and family) instead.' on: '2019-02-26' in: #Pharo8.

	self widgetDo: [ :w | aWindow spSetModal: w ]
]
