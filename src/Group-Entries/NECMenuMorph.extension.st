Extension { #name : 'NECMenuMorph' }

{ #category : '*Group-Entries' }
NECMenuMorph >> insertSelected [

	| selectionIndex selectedEntry |
	context hasEntries ifFalse: [ ^ false ].

	selectionIndex := self selectedIndex.
	selectedEntry := context entries at: selectionIndex.

	selectedEntry isGroupEntry ifTrue: [
		selectedEntry activateOn: context.
		self hideDetail.
		self refreshSelection.
		^ true ].

	self delete.
	context activateEntryAt: selectionIndex.

	^ true
]

{ #category : '*Group-Entries' }
NECMenuMorph >> leaveGroup [

	(context leaveGroup) ifFalse: [ ^ false ].
	self hideDetail.
	self refreshSelection.
	^ true
]
