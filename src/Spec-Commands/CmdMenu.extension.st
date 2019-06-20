Extension { #name : #CmdMenu }

{ #category : #'*Spec-Commands' }
CmdMenu >> buildContextMenu [
	| menu |

	menu := SpMenuPresenter new.
	rootGroup buildContextMenu: menu.
	^ menu
]
