CLASS zaf_cl_rest_petstore_client DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.



    INTERFACES if_oo_adt_classrun.

    METHODS CONSTRUCTOR raising /iwbep/cx_gateway.

    "! <p class="shorttext synchronized" lang="en">Create a Pet</p>
    "! @parameter is_pet | <p class="shorttext synchronized" lang="en">typed structure containing create data</p>
    "! @parameter rs_pet | <p class="shorttext synchronized" lang="en">typed structure containing response data from server </p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized" lang="en"></p>
    METHODS pet_create
      IMPORTING
        is_pet        TYPE zaf_if_petstore_types=>tys_pet
      RETURNING
        VALUE(rs_pet) TYPE zaf_if_petstore_types=>tys_pet
      RAISING
        /iwbep/cx_gateway.


    "! <p class="shorttext synchronized" lang="en">Delete a Pet with supplied id</p>
    "! This method does not return a json response body which can be serialized in to abap structure, so the http code is returned.
    "! @parameter iv_id | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter rv_http_status_code | <p class="shorttext synchronized" lang="en"></p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized" lang="en"></p>
    METHODS pet_delete
      IMPORTING
        iv_id                      TYPE  i
      RETURNING
        VALUE(rv_http_status_code) TYPE i
      RAISING
        /iwbep/cx_gateway.


    "! <p class="shorttext synchronized" lang="en">Get a pet with supplied id</p>
    "!
    "! @parameter iv_id | <p class="shorttext synchronized" lang="en">The id of the pet</p>
    "! @parameter rs_pet | <p class="shorttext synchronized" lang="en">Returned pet as ABAP structure, complete with deep fields.</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized" lang="en"></p>
    METHODS pet_read_by_id
      IMPORTING
        iv_id         TYPE  i
      RETURNING
        VALUE(rs_pet) TYPE zaf_if_petstore_types=>tys_pet
      RAISING
        /iwbep/cx_gateway.


    "! <p class="shorttext synchronized" lang="en">Update a pet using PUT</p>
    "! @parameter is_pet | <p class="shorttext synchronized" lang="en">typed structure containing update data</p>
    "! @parameter rs_pet | <p class="shorttext synchronized" lang="en">typed structure containing response data from server </p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized" lang="en"></p>
    METHODS pet_update
      IMPORTING
        is_pet        TYPE zaf_if_petstore_types=>tys_pet
      RETURNING
        VALUE(rs_pet) TYPE zaf_if_petstore_types=>tys_pet
      RAISING
        /iwbep/cx_gateway.


    "! <p class="shorttext synchronized" lang="en">Update the name and status of the pet having the supplied ID</p>
    "! The variables to be updated are sent as query parameters. The request type is POST
    "! @parameter iv_id | <p class="shorttext synchronized" lang="en">ID of the pet that is to be updated.</p>
    "! @parameter iv_name | <p class="shorttext synchronized" lang="en">new name for the pet</p>
    "! @parameter iv_status | <p class="shorttext synchronized" lang="en">new status for the pet</p>
    "! @parameter rs_pet | <p class="shorttext synchronized" lang="en">Updated pet </p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized" lang="en"></p>
    METHODS pet_update_name_and_status
      IMPORTING
        iv_id         TYPE  i
        iv_name       TYPE  zaf_if_petstore_types=>tys_pet-name
        iv_status     TYPE  zaf_if_petstore_types=>tys_pet-status
      RETURNING
        VALUE(rs_pet) TYPE zaf_if_petstore_types=>tys_pet
      RAISING
        /iwbep/cx_gateway.

PRIVATE SECTION.

  DATA: mo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy_rest,
        mo_http_client   TYPE REF TO if_http_client.

  METHODS create_client_proxy
    RETURNING
      VALUE(ro_client_proxy) TYPE REF TO /iwbep/if_cp_client_proxy_rest
    RAISING
      /iwbep/cx_gateway.

ENDCLASS.


CLASS zaf_cl_rest_petstore_client IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA:
      ls_pet              TYPE zaf_if_petstore_types=>tys_pet,
      ls_response_data    TYPE zaf_if_petstore_types=>tys_pet,
      ls_category         TYPE zaf_if_petstore_types=>tys_category,
      lv_http_status_code TYPE string,
      lv_id               TYPE i,
      lx_gateway          TYPE REF TO /iwbep/cx_gateway.


    TRY.
        mo_client_proxy = create_client_proxy( ).

*Get
      lv_id = 2.
      ls_response_data = pet_read_by_id( lv_id ).

      out->write( |=========| ).
      out->write( |Read| ).
      out->write( |=========| ).
      out->write( |Name:   { ls_response_data-name }| ).
      out->write( |Status: { ls_response_data-status }| ).
      CLEAR ls_response_data.

*Update Status and Name
        ls_response_data = pet_update_name_and_status(
                   iv_id     =  7
                   iv_name   = 'new_name'
                   iv_status = 'new_status' ).

        out->write( |=========| ).
        out->write( |Update Name and Status| ).
        out->write( |=========| ).
        out->write( |Name:   { ls_response_data-name }| ).
        out->write( |Status: { ls_response_data-status }| ).
        CLEAR ls_response_data.

*Create
        ls_category = VALUE #(
                        id   = 20
                        name = 'Persian'  ).
        ls_pet = VALUE #(
                  id         = 34
                  name       = 'Cat'
                  status     = 'Brand New'
                  category   = ls_category
                  photo_urls = VALUE #( ( |url_1| )  ) ).

        ls_response_data = pet_create( ls_pet ).

        out->write( |=========| ).
        out->write( |Create| ).
        out->write( |=========| ).
        out->write( |Name:      { ls_response_data-name }| ).
        out->write( |Photo URL: { ls_response_data-photo_urls[ 1 ] }| ).
        CLEAR ls_response_data.

*Update with Put
        ls_pet-name = 'Schrodingers Cat'.
        ls_pet-status = 'Dead and Alive'.
        ls_pet-category = VALUE #(
                           id   = 21
                           name = 'Mystery Kitty'  ).

        ls_response_data = pet_update( ls_pet ).

        out->write( |=========| ).
        out->write( |Update| ).
        out->write( |=========| ).
        out->write( |Name:   { ls_response_data-name }| ).
        out->write( |Status: { ls_response_data-status }| ).
        out->write( |Category-Name: { ls_response_data-category-name }| ).

*Delete
        lv_http_status_code = pet_delete( 4 ).

        IF lv_http_status_code = 200.
          out->write( |=========| ).
          out->write( |Delete| ).
          out->write( |=========| ).
          out->write( 'Delete Successful!').
        ENDIF.

      CATCH /iwbep/cx_gateway INTO lx_gateway.
        out->write( lx_gateway->if_message~get_text(  ) ).

    ENDTRY.

  ENDMETHOD.


  METHOD create_client_proxy.

    DATA:

      ls_proxy_model_key TYPE /iwbep/if_cp_registry_types=>ty_s_proxy_model_key,
      lv_error_text      TYPE string.

    cl_http_client=>create_by_url(
      EXPORTING
        url                    = 'https://petstore3.swagger.io'
      IMPORTING
        client                 = mo_http_client
      EXCEPTIONS
        argument_not_found     = 1
        plugin_not_active      = 2
        internal_error         = 3
        pse_not_found          = 4
        pse_not_distrib        = 5
        pse_errors             = 6
        OTHERS                 = 7 ).

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 INTO lv_error_text.
      RAISE EXCEPTION TYPE lx_rest_json_pl
        EXPORTING
          iv_error_text = lv_error_text.
    ENDIF.

    "Proxy model defined in ZAF_CL_REST_PETSTORE_MODEL
    ls_proxy_model_key = VALUE #( repository_id       = /iwbep/if_cp_registry_types=>gcs_repository_id-default
                                  proxy_model_id      = 'ZAF_REST_PETSTORE'
                                  proxy_model_version = 0003 ).

    ro_client_proxy ?= /iwbep/cl_cp_client_proxy=>create_rest_remote_proxy(
                is_proxy_model_key       = ls_proxy_model_key
                io_http_client           = mo_http_client
                iv_do_fetch_csrf_token   = abap_false
                iv_relative_service_root = '/api/v3').

  ENDMETHOD.


  METHOD pet_create.
*https://petstore3.swagger.io/api/v3/pet POST
    mo_client_proxy->create_resource( zaf_if_petstore_types=>gcs_resource_names-pets
                  )->create_request( /iwbep/if_v4_rest_types=>gcs_http_method-post
                  )->set_body_data( is_pet
                  )->execute(
                  )->get_body_data( IMPORTING ea_body_data = rs_pet ).

  ENDMETHOD.


  METHOD pet_delete.
*https://petstore3.swagger.io/api/v3/pet DELETE

    DATA:
      ls_key TYPE zaf_if_petstore_types=>tys_pet.

    rv_http_status_code = mo_client_proxy->create_resource( zaf_if_petstore_types=>gcs_resource_names-pet_id
                                        )->set_path_template_parameters( ls_key
                                        )->create_request( /iwbep/if_v4_rest_types=>gcs_http_method-delete
                                        )->execute( )->get_http_status_code(  ).

  ENDMETHOD.


  METHOD pet_read_by_id.

*https://petstore3.swagger.io/api/v3/pet/{id} GET
    mo_client_proxy->create_resource( zaf_if_petstore_types=>gcs_resource_names-pet_id
                  )->set_path_template_parameters(  VALUE zaf_if_petstore_types=>tys_pet( id  = iv_id )
                  )->create_request( /iwbep/if_v4_rest_types=>gcs_http_method-get
                  )->execute(
                  )->get_body_data( IMPORTING ea_body_data = rs_pet ).

  ENDMETHOD.


  METHOD pet_update_name_and_status.

*https://petstore3.swagger.io/api/v3/pet/{id}?name={name}&status={status} POST
    mo_client_proxy->create_resource( zaf_if_petstore_types=>gcs_resource_names-pet_id_name_status
                  )->set_path_template_parameters(
                       VALUE zaf_if_petstore_types=>tys_pet(
                                id     = iv_id
                                name   = iv_name
                                status = iv_status )
                  )->create_request( /iwbep/if_v4_rest_types=>gcs_http_method-post
                  )->execute(
                  )->get_body_data( IMPORTING ea_body_data = rs_pet ).

  ENDMETHOD.


  METHOD pet_update.

*https://petstore3.swagger.io/api/v3/pet PUT
    mo_client_proxy->create_resource( zaf_if_petstore_types=>gcs_resource_names-pets
                  )->create_request(  /iwbep/if_v4_rest_types=>gcs_http_method-put
                  )->set_body_data( is_pet
                  )->execute(
                  )->get_body_data( IMPORTING ea_body_data = rs_pet ).

  ENDMETHOD.

  METHOD constructor.

   mo_client_proxy = create_client_proxy(  ).

  ENDMETHOD.

ENDCLASS.
