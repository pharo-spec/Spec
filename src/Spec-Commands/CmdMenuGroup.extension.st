Extension { #name : #CmdMenuGroup }

{ #category : #'*Spec-Commands' }
CmdMenuGroup >> inlineContextMenuItemsInto: aMenu [

	aMenu addGroup: [ :group |
		contents do: [ :each | each buildContextMenu: group ] ]
]
