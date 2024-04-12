Class {
	#name : 'ScSpec01IntroductionPagePresenter',
	#superclass : 'ScPagePresenter',
	#instVars : [
		'introductionText'
	],
	#category : 'Spec2-Contributor',
	#package : 'Spec2-Contributor'
}

{ #category : 'as yet unclassified' }
ScSpec01IntroductionPagePresenter class >> introductionText [

	^ 'Welcome to the Spec Contributor. 
This wizard will guide you through some steps that will easy hopefully) you contributions to Spec2.
Spec2 is a subproject of Pharo, which means its classes are already included within the image, but since its handled externally, it requires you to create pull requests there in order to contribute.
This wizard will guide you through this basic steps: 

1. Locate of pharo-spec source project, origin remote (the destination of the PR) and your own remote (the place where you do your commits).
2. Do a pull from pharo-spec/master to update your system.  
3. Create a branch to store your changes.
4. Allow you to commit your changes.
5. Do a Pull Request.

YOU CAN KEEP THIS WIZARD OPEN DURING ALL THE PROCESS!'

]

{ #category : 'initialization' }
ScSpec01IntroductionPagePresenter >> initializePresenters [

	self layout: (SpBoxLayout newTopToBottom
		add: (introductionText := self newText);
		yourself).
		
	introductionText 
		beNotEditable;
		text: self class introductionText
]
