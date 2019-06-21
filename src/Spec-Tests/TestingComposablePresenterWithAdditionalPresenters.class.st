"
This presenter contains several subpresenters that are stored in additionalSubpresentersMap plus one presenter that is stored in instance variable but does not have any public accessors.
"
Class {
	#name : #TestingComposablePresenterWithAdditionalPresenters,
	#superclass : #SpComposablePresenter,
	#instVars : [
		'subpresenter1',
		'subpresenter2',
		'subpresenter3',
		'subpresenter4'
	],
	#category : #'Spec-Tests-Utils'
}
