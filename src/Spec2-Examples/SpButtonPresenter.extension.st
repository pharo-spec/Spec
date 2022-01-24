Extension { #name : #SpButtonPresenter }

{ #category : #'*Spec2-Examples' }
SpButtonPresenter class >> example [
	<sampleInstance>
	
	^ self new
		icon: (self iconNamed: #smallOk);
		label: 'Click me!';
		action: [ 'Clicked!' crTrace ];
		open
]

{ #category : #'*Spec2-Examples' }
SpButtonPresenter class >> exampleDisabled [
	
	^ self new
		icon: (self iconNamed: #smallCancel);
		label: 'Click me!';
		action: [ 'Clicked!' crTrace ];
		disable;
		open
]
