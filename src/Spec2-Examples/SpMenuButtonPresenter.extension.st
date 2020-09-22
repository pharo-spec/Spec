Extension { #name : #SpMenuButtonPresenter }

{ #category : #'*Spec2-Examples' }
SpMenuButtonPresenter class >> example [
	| presenter menuButton loremIpsumWords |

	"A generic presenter with a list and an action bar"	
	(presenter := SpPresenter new) 
		layout: (SpBoxLayout newVertical
			add: (SpBoxLayout newHorizontal
					addLast: (menuButton := presenter newMenuButton) expand: false;
					yourself)
				expand: false;
			yourself).	

	loremIpsumWords := String loremIpsum substrings.
	menuButton menu: [ 
		SpMenuPresenter new
			addGroup: [ :group | group
				addItem: [ :item | item name: '1: ', loremIpsumWords atRandom ];
				addItem: [ :item | item name: '2: ', loremIpsumWords atRandom ];
				addItem: [ :item | item name: '3: ', loremIpsumWords atRandom ] ];
			yourself ].
		
	^ presenter openWithSpec
]
