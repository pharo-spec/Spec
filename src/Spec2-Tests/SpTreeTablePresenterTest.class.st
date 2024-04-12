Class {
	#name : 'SpTreeTablePresenterTest',
	#superclass : 'SpAbstractTreePresenterTest',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'accessing' }
SpTreeTablePresenterTest >> classToTest [

	^ SpTreeTablePresenter
]

{ #category : 'tests' }
SpTreeTablePresenterTest >> testAlternateRowsColor [

	[ 
		| widgetAdapter |
		presenter
			alternateRowsColor;
			addColumn: (SpStringTableColumn 
				title: 'Name' 
				evaluated: [ : val | val asString ]);
			addColumn: (SpStringTableColumn 
				title: 'Description' 
				evaluated: [ : val | val asString ]);
			children: [ : cls | cls allSubclasses ];
			roots: { Object };
			open.
		widgetAdapter := presenter adapter widget.
		self 
			assert: (widgetAdapter container instVarNamed: #rowColors) size
			equals: 2 
	] 
	ensure: [ presenter delete ].




]
