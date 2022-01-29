Extension { #name : #SpTextInputFieldPresenter }

{ #category : #'*Spec2-Examples' }
SpTextInputFieldPresenter class >> example [

	<sampleInstance>
	^ self new
		  extent: 300 @ 25;
		  placeholder: 'This is a ghost';
		  text: 'This is a text';
		  open
]

{ #category : #'*Spec2-Examples' }
SpTextInputFieldPresenter class >> exampleEntryCompletion [
	| applicants entryCompletion |

	applicants := (Array
		streamContents: [ :strm | 
			Symbol allSymbolTablesDo: [ :each | 
				(each notEmpty 
					and: [ each isValidGlobalName 
					and: [ Smalltalk globals includesKey: each ] ])
					ifTrue: [ strm nextPut: each ] ] ]) sort.
	
	entryCompletion := EntryCompletion new
		dataSourceBlock: [ :currText | applicants ];
		filterBlock: [ :currApplicant :currText | 
			currText size > 3 
				and: [ currApplicant asUppercase includesSubstring: currText asString asUppercase ] ].

	^ self new
		extent: 300 @ 25;
		placeholder: 'Enter a class name (at least 4 letters)';
		entryCompletion: entryCompletion;
		open
]

{ #category : #'*Spec2-Examples' }
SpTextInputFieldPresenter class >> examplePassword [

	^ self new
		extent: 300 @ 25;
		bePassword;
		placeholder: 'This is a ghost';
		text: 'shhh';
		open
]
