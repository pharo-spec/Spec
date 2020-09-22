Extension { #name : #SpMenuButtonPresenter }

{ #category : #'*Spec2-Examples' }
SpMenuButtonPresenter class >> example [
	| menuButton loremIpsumWords |

	loremIpsumWords := String loremIpsum substrings.
	menuButton := SpMenuButtonPresenter new 
		menu: [ SpMenuPresenter new
			addGroup: [ :group | group
				addItem: [ :item | item name: '1: ', loremIpsumWords atRandom ];
				addItem: [ :item | item name: '2: ', loremIpsumWords atRandom ];
				addItem: [ :item | item name: '3: ', loremIpsumWords atRandom ] ];
			yourself ];
		yourself.
		
	menuButton openWithSpec.
	
	^ menuButton
]
