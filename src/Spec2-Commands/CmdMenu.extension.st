Extension { #name : #CmdMenu }

{ #category : #'*Spec2-Commands' }
CmdMenu >> buildContextMenu [
	| menu |

	menu := SpMenuPresenter new.
	rootGroup buildContextMenu: menu.
	^ menu
]
