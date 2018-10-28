Feature: Edit a technology
As a techmenu community member
I need to be able to easily update technologies in techmenu
So that all users can see our wise technology decisions

Background: 
	Given Jesper has a valid security token
	When Jesper wants to edit a technology with the name "#slack"
	

Scenario: User can change technology name, and it is persisted
	When I change the name to "#slack!"
	Then I see that name is "#slack!"
	And the API returns a technology record with the name "#slack!"

Scenario: Technology Names are always unique 

Scenario: User can change the description, and it is persisted

Scenario: Primary usecase is defining status and taxonomy of the technology

Scenario: User can add a link, at it is persisted

Scenario: User can remove a link, at the change is persisted

Scenario: User can change a link, and the change is persisted

Scenario: User can add technical debt, and it is persisted

Scenario: User can change technicald debt, and it is persisted

Scenario: Add usecase

Scenario: Remove usecase

Scenario: Edit usecase

Scenario: Change taxonomy in usecase

Scenario: Reorder usecases
