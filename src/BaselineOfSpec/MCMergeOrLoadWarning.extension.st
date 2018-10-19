Extension { #name : #MCMergeOrLoadWarning }

{ #category : #'*BaselineOfSpec' }
MCMergeOrLoadWarning >> defaultAction [
	'Default action of merge or load' crLog.
	^ UIManager default
		confirm: self messageText
		trueChoice: 'Load' translated
		falseChoice: 'Merge' translated
		cancelChoice: 'Cancel' translated
		default: nil
]
