Feature: clockify
  Background:
   Given  base url https://api.clockify.me/api/

  @getAllWorkspaces
  Scenario: GetAllMyWorkspaces
    And endpoint v1/workspaces
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $.[0].id

  @getWorkspaceInfoWithCall
  Scenario: Get Workspace Info - Step call
    And call Clockify.feature@getAllWorkspaces
    And endpoint /v1/workspaces/{{idWorkspace}}
    And header x-api-key = "NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh"
    When execute method GET
    Then the status code should be 200


  @createProjects
  Scenario: CreatetAllMyProjects
    And call Clockify.feature@getAllWorkspaces
    And base url https://api.clockify.me/api/
    And endpoint v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    And header Content-Type = "application/json"
    And set value proyectLowCode1 of key name in body jsons/bodies/createProyects.json
    When execute method POST
    Then the status code should be 201

@GetAllProjects @Do
Scenario: GetAllWorkProjects
  And call Clockify.feature@getAllWorkspaces
  And endpoint v1/workspaces/{{idWorkspace}}/projects
  And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
  When execute method GET
  Then the status code should be 200
  * define projectId = $.[0].id