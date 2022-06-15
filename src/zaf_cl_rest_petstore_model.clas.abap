"! <p class="shorttext synchronized" lang="en">Proxy Model consuming https://petstore3.swagger.io/api/v3 </p>
"! Used in client {@link ZAF_CL_REST_PETSTORE_CLIENT}
CLASS zaf_cl_rest_petstore_model DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_v4_abs_model_prov
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /iwbep/if_v4_mp_basic_rest~define REDEFINITION.

  PRIVATE SECTION.

    "! <p class="shorttext synchronized" lang="en">Define the structure type and resources for Pet</p>
    "!
    "! @parameter io_model        | <p class="shorttext synchronized" lang="en">Proxy model</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized" lang="en">Gateway exception</p>
    METHODS define_pet
      IMPORTING
        io_model TYPE REF TO /iwbep/if_v4_rest_model
      RAISING
        /iwbep/cx_gateway .

ENDCLASS.


CLASS zaf_cl_rest_petstore_model IMPLEMENTATION.


  METHOD  /iwbep/if_v4_mp_basic_rest~define.

    define_pet( CAST /iwbep/if_v4_rest_model( io_model ) ).

  ENDMETHOD.


  METHOD define_pet.
*
    DATA:
      ls_data_container_pet      TYPE zaf_if_petstore_types=>tys_pet,
      ls_data_container_tag      TYPE zaf_if_petstore_types=>tys_tag,
      ls_data_container_category TYPE zaf_if_petstore_types=>tys_category,
      lo_structured_type         TYPE REF TO /iwbep/if_v4_rest_struc_type,
      lo_resource                TYPE REF TO /iwbep/if_v4_rest_resource,
      lo_operation               TYPE REF TO /iwbep/if_v4_rest_operation.


*Define Category
    lo_structured_type = io_model->create_struct_type_by_struct(
                                      iv_name              = zaf_if_petstore_types=>gcs_internal_struct_type_names-category
                                      is_structure         = ls_data_container_category
                                      iv_do_gen_prim_props = abap_true ).

    lo_structured_type->camelcase_lower_prim_prp_names(  ).

*Define Tag
    lo_structured_type = io_model->create_struct_type_by_struct(
                                            iv_name              = zaf_if_petstore_types=>gcs_internal_struct_type_names-tag
                                            is_structure         = ls_data_container_tag
                                            iv_do_gen_prim_props = abap_true ).

    lo_structured_type->camelcase_lower_prim_prp_names(  ).

*Define Pet
    lo_structured_type = io_model->create_struct_type_by_struct(
                                            iv_name                   = zaf_if_petstore_types=>gcs_internal_struct_type_names-pet
                                            is_structure              = ls_data_container_pet
                                            iv_do_gen_prim_props      = abap_true
                                            iv_do_gen_prim_prop_colls = abap_true ).

    lo_structured_type->camelcase_lower_prim_prp_names(  ).

    lo_structured_type->create_structured_property( 'CATEGORY'
                     )->set_external_name( 'category'
                     )->set_structured_type( zaf_if_petstore_types=>gcs_internal_struct_type_names-category ).

    lo_structured_type->create_structured_property( 'TAGS'
                     )->set_external_name( 'tags'
                     )->set_structured_type( zaf_if_petstore_types=>gcs_internal_struct_type_names-tag )->set_is_collection(  ).

*Get by id
    lo_resource = io_model->create_resource( iv_name          = zaf_if_petstore_types=>gcs_resource_names-pet_id
                                             iv_path_template = zaf_if_petstore_types=>gcs_resource_paths-pet_id ).

    lo_resource->set_path_params_struct_type( zaf_if_petstore_types=>gcs_internal_struct_type_names-pet
              )->create_operation( /iwbep/if_v4_rest_types=>gcs_http_method-get
              )->create_response_body(
              )->set_structured_type( zaf_if_petstore_types=>gcs_internal_struct_type_names-pet ).

*Delete
    lo_resource->set_path_params_struct_type(  zaf_if_petstore_types=>gcs_internal_struct_type_names-pet
              )->create_operation( /iwbep/if_v4_rest_types=>gcs_http_method-delete
              )->create_response_body( ).

*Update Status and Name
    io_model->create_resource( iv_name          = zaf_if_petstore_types=>gcs_resource_names-pet_id_name_status
                               iv_path_template = zaf_if_petstore_types=>gcs_resource_paths-pet_id_name_status
                         )->set_path_params_struct_type( zaf_if_petstore_types=>gcs_internal_struct_type_names-pet
                         )->create_operation( /iwbep/if_v4_rest_types=>gcs_http_method-post
                         )->create_response_body(
                         )->set_structured_type( zaf_if_petstore_types=>gcs_internal_struct_type_names-pet ).

    lo_resource = io_model->create_resource( iv_name           = zaf_if_petstore_types=>gcs_resource_names-pets
                                             iv_path_template  = zaf_if_petstore_types=>gcs_resource_paths-pets ).

*Create
    lo_operation = lo_resource->create_operation( /iwbep/if_v4_rest_types=>gcs_http_method-post ).
    lo_operation->create_request_body(
               )->set_structured_type( zaf_if_petstore_types=>gcs_internal_struct_type_names-pet ).
    lo_operation->create_response_body(
               )->set_structured_type( zaf_if_petstore_types=>gcs_internal_struct_type_names-pet ).

*Update with put
    lo_operation = lo_resource->create_operation( /iwbep/if_v4_rest_types=>gcs_http_method-put ).
    lo_operation->create_request_body(
               )->set_structured_type( zaf_if_petstore_types=>gcs_internal_struct_type_names-pet ).
    lo_operation->create_response_body(
               )->set_structured_type( zaf_if_petstore_types=>gcs_internal_struct_type_names-pet ).


  ENDMETHOD.

ENDCLASS.
