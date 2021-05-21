"
Description
--------------------

I am a state of a ProgressBarPresenter managing the behavior of a progress bar which value can progress.

I will have a block that should return a number between 0 and 1 to get the current progress and a delay defining the refresh rate of the progress bar.

Examples
--------------------

	ProgressBarProgressing progression: [ model computationStep ] every: 0.2 seconds
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	currentValueHolder:		<aValueHolder>		Store the current value of the progress bar. We need it to be able to notify the user when it changes so that the user can register to the change.
	progression:					<aValuable>			A block returning a number between 0 and 1 defining the progress of the bar.
	refreshDelay:				<aDelay>				A delay defining the refresh rate of the bar.

"
Class {
	#name : #SpProgressBarProgressing,
	#superclass : #SpProgressBarState,
	#traits : 'SpTObservable',
	#classTraits : 'SpTObservable classTrait',
	#instVars : [
		'#refreshDelay',
		'#progression',
		'#currentValue => SpObservableSlot'
	],
	#category : #'Spec2-Core-Utils'
}
