"
Description
--------------------

This demo show how to use the image presenter
"
Class {
	#name : #SpDemoImagePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'image1',
		'image2'
	],
	#category : #'Spec2-Examples-Demo-Other'
}

{ #category : #'instance creation' }
SpDemoImagePresenter class >> open [
	<script>
	self new open
]

{ #category : #layout }
SpDemoImagePresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: (SpBoxLayout newLeftToRight
			add: 'Image added through an ImagePresenter:';
			add: image1;
			yourself)
		height: 50;
		add: (SpBoxLayout newLeftToRight
			add: 'Image added through an ImagePresenter:';
			add: image2;
			yourself);
		add: (SpBoxLayout newLeftToRight
			add: 'Image added directly from the layout definition:';
			add: (self newImage image: (self iconNamed: #pharoBig));
			yourself);
		yourself
]

{ #category : #initialization }
SpDemoImagePresenter >> initializePresenters [

	image1 := self newImage.
	image2 := self newImage.

	image1 image: (self iconNamed: #pharo).
	image2 image: self currentWorld submorphs last form
]

{ #category : #'option list presenter' }
SpDemoImagePresenter >> optionIcon [

	^ self iconNamed: #image
]

{ #category : #'option list presenter' }
SpDemoImagePresenter >> optionTitle [

	^ 'Image Presenter'
]
