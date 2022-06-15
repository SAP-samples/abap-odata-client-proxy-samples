CLASS zaf_cl_petstore_test DEFINITION DEFERRED.
class zaf_cl_rest_petstore_client  definition local friends
zaf_cl_petstore_test.

CLASS zaf_cl_petstore_test DEFINITION
FINAL
FOR TESTING
DURATION SHORT
  RISK LEVEL HARMLESS.

  PUBLIC SECTION.

    METHODS:
      pet_operations FOR TESTING RAISING /iwbep/cx_gateway.


  PRIVATE SECTION.

    DATA mo_cut TYPE REF TO zaf_cl_rest_petstore_client.

    METHODS: setup RAISING /iwbep/cx_gateway.

ENDCLASS.

CLASS zaf_cl_petstore_test IMPLEMENTATION.


  METHOD pet_operations.

    DATA:
      ls_payload           TYPE zaf_if_petstore_types=>tys_pet,
      ls_response_exp     TYPE zaf_if_petstore_types=>tys_pet,
      ls_response_act     TYPE zaf_if_petstore_types=>tys_pet,
      ls_category         TYPE zaf_if_petstore_types=>tys_category,
      lv_http_status_code TYPE string,
      lv_id               TYPE i,
      lx_gateway          TYPE REF TO /iwbep/cx_gateway.

*CREATE
    ls_category = VALUE #(
                       id   = 20
                       name = 'Persian'  ).
    ls_payload = VALUE #(
              id         = 34
              name       = 'Cat'
              status     = 'Brand New'
              category   = ls_category
              photo_urls = VALUE #( ( |url_1| )  ) ).

    ls_response_exp = ls_payload.

    ls_response_act = mo_cut->pet_create( ls_payload ).

    "Then the expected pet data should be returned.
    cl_abap_unit_assert=>assert_equals( exp =  ls_response_exp
                                        act =  ls_response_act ).
    CLEAR ls_response_act.

*READ BY ID

    "When we make a get request for a pet with this id.
    lv_id = 34.
    ls_response_act = mo_cut->pet_read_by_id( lv_id ).

    "Then the expected pet data should be returned.
    cl_abap_unit_assert=>assert_equals( exp =  ls_response_exp
                                        act =  ls_response_act ).
    CLEAR ls_response_act.

*UPDATE NAME AND STATUS
    ls_response_act = mo_cut->pet_update_name_and_status(
                    iv_id     =  34
                    iv_name   = 'new_name'
                    iv_status = 'new_status' ).

    ls_response_exp-name    = 'new_name'.
    ls_response_exp-status  = 'new_status'.

    cl_abap_unit_assert=>assert_equals( exp =  ls_response_exp
                                        act =  ls_response_act ).

*UPDATE
    ls_payload-name = 'Schrodingers Cat'.
    ls_payload-status = 'Dead and Alive'.
    ls_payload-category = VALUE #(
                       id   = 21
                      name = 'Mystery Kitty'  ).

    ls_response_exp = ls_payload.

    ls_response_act = mo_cut->pet_update( ls_payload ).

    cl_abap_unit_assert=>assert_equals( exp =  ls_response_exp
                                        act =  ls_response_act ).

*DELETE
  lv_http_status_code = mo_cut->pet_delete( 4 ).

 "the expected pet data should be returned.
    cl_abap_unit_assert=>assert_equals( exp =  200
                                        act =  lv_http_status_code ).

  ENDMETHOD.


  METHOD setup.
   mo_cut = NEW zaf_cl_rest_petstore_client( ).
  ENDMETHOD.

ENDCLASS.
