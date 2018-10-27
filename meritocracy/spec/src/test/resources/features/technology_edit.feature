Feature: Edit a technology
As a techmenu community member
I need to be able to easily update technologies in techmenu
So that all users can see our wise technology decisions

Background: 
	Given I have a valid security token

Scenario: User can change technology name, and it is persisted
	Given I edit technology with name "#slack"
	When I change the name to "#slack!"
	Then I see that name is "#slack!"
	And the API return a technology record with the name "#slack!"

Scenario: Technology Names are always unique 

Scenario: User can change the description, and it is persisted
Given i

Scenario: User can add a link, at it is persisted
Given i

Scenario: User can remove a link, at the change is persisted
Given i

Scenario: User can change a link, and the change is persisted
Given i

Scenario: User can add technical debt, and it is persisted
Given i

Scenario: User can change technicald debt, and it is persisted
Given i

Scenario: Add usecase

#Scenario: Remove usecase

#Scenario: Edit usecase

#Scenario: Change taxonomy in usecase

#Scenario: Reorder usecases

#Scenario: First usecase is defining status and taxonomy of the technology