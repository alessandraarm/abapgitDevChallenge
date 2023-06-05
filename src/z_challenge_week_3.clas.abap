CLASS z_challenge_week_3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    TYPES:
      BEGIN OF ty_shop_item,
        name      TYPE string,
        price(15) TYPE p DECIMALS 2,
      END OF ty_shop_item .
    TYPES:
      ty_shop_item_tt TYPE TABLE OF ty_shop_item WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ty_shop,
        shop_name TYPE string,
        items     TYPE ty_shop_item_tt,
      END OF ty_shop .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS z_challenge_week_3 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA lo_mustache TYPE REF TO zcl_mustache.
    DATA lt_my_data TYPE STANDARD TABLE OF ty_shop WITH DEFAULT KEY.
    DATA lr_data TYPE REF TO ty_shop.
    DATA: cx TYPE REF TO zcx_mustache_error.

    APPEND INITIAL LINE TO lt_my_data REFERENCE INTO lr_data.
    lr_data->shop_name = 'Shoes Shop'.
    lr_data->items = VALUE ty_shop_item_tt( ( name = 'Havaianas' price = '30.00' )
                                            ( name = 'Melissa' price = '250.00' )
                                            ( name = 'All Star' price = '130.00' ) ).

    APPEND INITIAL LINE TO lt_my_data REFERENCE INTO lr_data.
    lr_data->shop_name = 'Festa Junina Shop'.
    lr_data->items = VALUE ty_shop_item_tt( ( name = 'Paçoca' price = '5.00' )
                                            ( name = 'Milho' price = '15.00' )
                                            ( name = 'Questão'  price = '12.00' ) ).

    TRY.
        lo_mustache = zcl_mustache=>create(
       'Welcome to {{shop_name}}' && cl_abap_char_utilities=>newline &&
       '{{#items }}'             && cl_abap_char_utilities=>newline &&
       '* {{name}} - ${{price}}'  && cl_abap_char_utilities=>newline &&
       '{{/items}}' && cl_abap_char_utilities=>newline ).
        out->write( lo_mustache->render( lt_my_data ) ).
      CATCH zcx_mustache_error INTO cx.
        out->write( 'Error raised' ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
