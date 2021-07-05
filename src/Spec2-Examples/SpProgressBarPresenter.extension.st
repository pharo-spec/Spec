Extension { #name : #SpProgressBarPresenter }

{ #category : #'*Spec2-Examples' }
SpProgressBarPresenter class >> example [
	| progress |

	progress := 0.
	^ self new 
		progress: [ progress:= progress + 0.1 ] every: 0.5 seconds;
		openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpProgressBarPresenter class >> exampleFixedAt [

	^ self new 
		application: (SpApplication new useBackend: #Gtk);
		fixedAt: 0.3;
		openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpProgressBarPresenter class >> exampleFixedPercentage [

	^ self new 
		application: (SpApplication new useBackend: #Gtk);
		fixedPercentage: 30;
		openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpProgressBarPresenter class >> exampleIndeterminate [

	^ self new 
		application: (SpApplication new useBackend: #Gtk);
		indeterminate;
		openWithSpec
]
