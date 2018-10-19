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

{ #category : #'*BaselineOfSpec' }
MCMergeOrLoadWarning >> pass [
	'Pass' crLog.
	handlerContext nextHandlerContext crLog.
	super pass
]

{ #category : #'*BaselineOfSpec' }
MCMergeOrLoadWarning >> resume [
	'resume' crLog.
	super resume
]

{ #category : #'*BaselineOfSpec' }
MCMergeOrLoadWarning class >> signalFor: aVersionCollection [
	'Signal merge or load ' crLog.
	^ self new
		versions: aVersionCollection;
		signal
]
