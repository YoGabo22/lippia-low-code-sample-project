Feature: ErrorLoco

  Background:
    Given  base url https://api.clockify.me/api/

  @getAllWorkspaces
  Scenario: GetAllMyWorkspaces
    And endpoint v1/workspaces
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $.[0].id

  @GetAllProjects
  Scenario: GetAllProjects
    And call Clockify.feature@getAllWorkspaces
    And endpoint v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    When execute method GET
    Then the status code should be 200
    * print response
    * define idProject = $.[0].id

  @CheckProjectById @Do
  Scenario: CheckProjectById
    And call Clockify.feature@GetAllProjects
    #And endpoint v1/workspaces/{{idWorkspace}}/projects
    #And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    #When execute method GET
    #* define idProject = $.[0].id
    And base url https://api.clockify.me/api/
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    When execute method GET
    Then the status code should be 200
    And response should be $.name = "tp8LowCode"