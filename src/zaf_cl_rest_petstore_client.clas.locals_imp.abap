"! <p class="shorttext synchronized" lang="en">SAP Gateway Exception</p>
CLASS lx_rest_json_pl DEFINITION
  INHERITING FROM /iwbep/cx_gateway
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS if_message~get_text REDEFINITION.

    METHODS constructor
      IMPORTING
        iv_error_text TYPE string.



  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA mv_error_text TYPE string.


ENDCLASS.



CLASS lx_rest_json_pl IMPLEMENTATION.

  METHOD constructor.
    super->constructor( ).
    mv_error_text = iv_error_text.
  ENDMETHOD.


  METHOD if_message~get_text.
    result = mv_error_text.
  ENDMETHOD.

ENDCLASS.
