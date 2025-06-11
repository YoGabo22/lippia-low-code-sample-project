Feature: tp8LowCode

  Background:
    Given  base url https://api.clockify.me/api/

  @getAllWorkspaces
  Scenario: GetAllMyWorkspaces
    And endpoint v1/workspaces
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $.[0].id

  @createProjects
  Scenario: CreateProject
    And call Clockify.feature@getAllWorkspaces
    And base url https://api.clockify.me/api/
    And endpoint v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    And header Content-Type = "application/json"
    And set value tp8LowCode of key name in body jsons/bodies/createProjects.json
    When execute method POST
    Then the status code should be 201

  @GetAllProjects
  Scenario: GetAllProjects
    And call Clockify.feature@getAllWorkspaces
    And endpoint v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    When execute method GET
    Then the status code should be 200

  @CheckProjectById
  Scenario: CheckProjectById
    And call Clockify.feature@getAllWorkspaces
    And endpoint v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    When execute method GET
    * define idProject = $.[0].id
    And base url https://api.clockify.me/api/
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    When execute method GET
    Then the status code should be 200
    And response should be $.name = "proyectLowCode1"

  @EditValueProject
  Scenario: EditValueProject
    And call Clockify.feature@getAllWorkspaces
    And endpoint v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    When execute method GET
    * define idProject = $.[0].id
    And base url https://api.clockify.me/api/
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    And body jsons/bodies/editProject.json
    And set value test2 of key note in body jsons/bodies/editProject.json
    And header Content-Type = application/json
    When execute method PUT
    Then the status code should be 200
    And response should be $.note = "test2"


    #Casos de Error

  @createProjectsError401
  Scenario: CreateProjectError401
    And call Clockify.feature@getAllWorkspaces
    And base url https://api.clockify.me/api/
    And endpoint v1/workspaces/{{idWorkspace}}/projects
    And header Content-Type = "application/json"
    And set value tp8LowCode of key name in body jsons/bodies/createProjects.json
    When execute method POST
    Then the status code should be 401

  @CheckProjectByIdError404
  Scenario: CheckProjectByIdError404
    And call Clockify.feature@getAllWorkspaces
    And endpoint v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    When execute method GET
    * define idProject = ffffffffffffffffffffffff
    And base url https://api.clockify.me/api/
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    And header Content-Type = application/json
    When execute method GET
    Then the status code should be 404
    #Sobre este caso, probé muchas maneras y no encontré forma de que devuelva el código de error 404
    #En todas, devuelve código 400. Aparentemente es algo de Clockify, por lo que pude ver en Internet.

  @EditValueProjectError400 @Do
  Scenario: EditValueProjectError400
    And call Clockify.feature@getAllWorkspaces
    And endpoint v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    When execute method GET
    * define idProject = $.[0].id
    And base url https://api.clockify.me/api/
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    And body jsons/bodies/editProjectError.json
    And set value test2 of key note in body jsons/bodies/editProjectError.json
    And header Content-Type = application/json
    When execute method PUT
    Then the status code should be 400