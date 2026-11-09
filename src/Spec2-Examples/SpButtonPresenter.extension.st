Extension { #name : 'SpButtonPresenter' }

{ #category : '*Spec2-Examples' }
SpButtonPresenter class >> example [
	"Show a simple button with an action."
	<sampleInstance>

	^ self new
		icon: (self iconNamed: #smallOk);
		label: 'Click me!';
		action: [ 'Clicked!' newLineTrace ];
		open
]

{ #category : '*Spec2-Examples' }
SpButtonPresenter class >> exampleDisabled [
	"Show a disabled button"

	^ self new
		icon: (self iconNamed: #smallCancel);
		label: 'Click me!';
		action: [ 'Clicked!' newLineTrace ];
		disable;
		open
]
