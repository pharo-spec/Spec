Extension { #name : #CmdMenu }

{ #category : #'*Spec2-CommanderCompatibility' }
CmdMenu >> asSpMenuPresenter [
	| menu |
	menu := SpMenuPresenter new.
	rootGroup contents do: [ :each | each addToMenuPresenter: menu  ].
	^menu
]
