"
I am an abstract test class that makes all my subclass' test run on the UI thread to avoid concurrency issues.
"
Class {
	#name : 'SpBaseTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Tests-Utils',
	#package : 'Spec2-Tests',
	#tag : 'Utils'
}

{ #category : 'running' }
SpBaseTest >> application [

	^ SpApplication new
		  useBackend: #Morphic with: StPharoMorphicConfiguration new;
		  yourself
]

{ #category : 'running' }
SpBaseTest >> run [

	| finished result |
	UIManager default uiProcess == Processor activeProcess ifTrue: [
		^ super run ].

	finished := Semaphore new.
	self application defer: [
		result := super run.
		finished signal ].
	finished wait.
	^ result
]

{ #category : 'running' }
SpBaseTest >> run: aResult [

	| finished result |
	UIManager default uiProcess == Processor activeProcess ifTrue: [
		^ super run: aResult ].

	finished := Semaphore new.
	self application backend defer: [
		result := super run: aResult.
		finished signal ].
	finished wait.
	^ result
]
