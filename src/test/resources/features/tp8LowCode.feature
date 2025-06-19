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
    * print response
    * define idProject = $.[0].id


  @CheckProjectById
  Scenario: CheckProjectById
    And call Clockify.feature@GetAllProjects
    #And endpoint v1/workspaces/{{idWorkspace}}/projects
    #And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    #When execute method GET
   # * define idProject = $.[0].id
    And base url https://api.clockify.me/api/
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    When execute method GET
    Then the status code should be 200
    And response should be $.name = "tp8LowCode"

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

  @EditValueProjectError400
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

  @TpFinal
    #2. Automatizar en Lippia escenarios para:
    #a. Consultar las horas registradas.
    #b. Agregar horas a un proyecto.
    #c. Editar un campo de algún registro de hora.
    #d. Eliminar hora registrada.
  @CheckAllHours
  Scenario: CheckAllHours
    And call Clockify.feature@getAllWorkspaces
    And endpoint v1/workspaces/{{idWorkspace}}/time-entries/status/in-progress
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    When execute method GET
    Then the status code should be 200

  @AddHours
  Scenario: AddHours
    And call Clockify.feature@getAllWorkspaces
    And endpoint v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    When execute method GET
    * define idProject = $.[0].id
    And endpoint v1/workspaces/{{idWorkspace}}/time-entries
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    And header Content-Type = "application/json"
    And set value {{idProject}} of key projectId in body jsons/bodies/addHours.json
    And set value 2025-06-17T00:01:00Z of key start in body jsons/bodies/addHours.json
    And set value 2025-06-17T00:05:00Z of key end in body jsons/bodies/addHours.json
    When execute method POST
    Then the status code should be 201


  @EditHours
  Scenario: EditHours
    And call Clockify.feature@getAllWorkspaces
    And endpoint v1/workspaces/{{idWorkspace}}/user/{{userId}}/time-entries?start=2025-06-17T00:00:00Z
    When execute method GET
    * define idEntry = $.[0].id
    And endpoint v1/user
    When execute method GET
    * define userId = $.id
    And endpoint v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    When execute method GET
    * define idProject = $.[0].id
    And endpoint v1/workspaces/{{idWorkspace}}/time-entries/{{idEntry}}
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh
    And header Content-Type = "application/json"
    And set value 2025-06-17T01:00:00Z of key start in body jsons/bodies/editHours.json
    And set value 2025-06-17T02:00:00Z of key end in body jsons/bodies/editHours.json
    When execute method PUT
    Then the status code should be 200

  @DeleteHours @Do
  Scenario: DeleteHours
    And call Clockify.feature@getAllWorkspaces
    And endpoint v1/workspaces/{{idWorkspace}}/user/{{userId}}/time-entries?start=2025-06-17T00:00:00Z
    When execute method GET
    * define idEntry = $.[0].id
    And endpoint v1/workspaces/{{idWorkspace}}/time-entries/{{idEntry}}
    And header x-api-key = NTYxNDE2ZjItNDQzMS00YTlkLWEzNWQtNWJiYjFkNjQxNTdh...
    When execute method DELETE
    Then the status code should be 204




