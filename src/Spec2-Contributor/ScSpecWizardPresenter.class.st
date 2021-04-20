Class {
	#name : #ScSpecWizardPresenter,
	#superclass : #ScWizardPresenter,
	#category : #'Spec2-Contributor'
}

{ #category : #accessing }
ScSpecWizardPresenter class >> title [

	^ 'Spec Contributor'
]

{ #category : #'private factory' }
ScSpecWizardPresenter >> newPages [

	^ { 
	ScSpec01IntroductionPagePresenter new.
	ScSpec02LocateProjectPresenter new.
	ScSpec03ChooseRemotesPresenter new 
	}
]
