Extension { #name : 'CmUICommand' }

{ #category : '*Spec2-Commander2' }
CmUICommand >> id [

	^ String streamContents: [ :stream |
		| parts name |
		
		name := self name 
			ifNil: [ 
				self shortcutKey
					ifNotNil: [ 'shortcut ', (KMShortcutPrinter toString: self shortcutKey) ]
					ifNil: [ 'unknown' ] ].
		parts := name substrings.
		stream << parts first asLowercase.
		parts allButFirstDo: [ :each | stream << each capitalized ] ]
]
