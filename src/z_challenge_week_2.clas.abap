CLASS z_challenge_week_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA user TYPE string.
    DATA date TYPE string.
    DATA value TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
      DATA internal_date TYPE d.
ENDCLASS.



CLASS z_challenge_week_2 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    "event handling
    CASE client->get( )-event.
      WHEN 'BUTTON_POST'.
        client->popup_message_toast( |App Executed on { date } by { user }| ).
    ENDCASE.

    "view rendering
    client->set_next( VALUE #( xml_main = z2ui5_cl_xml_view=>factory(
        )->page( title = 'abap2UI5 - First Example'
            )->simple_form( title = 'Form Title' editable = abap_true
                )->content( 'form'
                    )->title( 'Input'
                    )->label( 'User'
                    )->input( client->_bind( user )
                    )->label( 'Date'
                    )->date_picker( client->_bind( date )
                    )->button( text  = 'post' press = client->_event( 'BUTTON_POST' )
         )->get_root( )->xml_get( ) ) ).

  ENDMETHOD.

ENDCLASS.
