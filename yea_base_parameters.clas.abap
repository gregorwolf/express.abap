class YEA_BASE_PARAMETERS definition
  public
  create public .

public section.

  interfaces YEA_PARAMETERS .

  data _PARAMS type ZTT_EA_KEY_VALUES .

  methods CONSTRUCTOR
    importing
      !URI_ARGUMENTS type STRING optional
      !URI_REQUEST type STRING optional .
  protected section.
  private section.
ENDCLASS.



CLASS YEA_BASE_PARAMETERS IMPLEMENTATION.


  method CONSTRUCTOR.
    split uri_arguments at '/' into table data(_args).
    split uri_request at '/' into table data(_vals).
    data(index) = 0.
    loop at _args assigning field-symbol(<arg>).

      index = index + 1.

      read table _vals index index assigning field-symbol(<val>).
      if ( sy-subrc <> 0 ).
        continue.
      endif.

      if ( strlen( <arg> ) > 0 and <arg>+0(1) = ':' ).
        append value yea_key_value(
          key = <arg>
          value = <val>
        ) to me->_params.
      endif.

    endloop.
  endmethod.


  method YEA_PARAMETERS~GET.
    try.
        returning = _params[ key = parameter ]-value.
      catch cx_root.
    endtry.
  endmethod.


  method YEA_PARAMETERS~HAS.
    try.
        data(ok) = _params[ key = parameter ]-value.
        returning = abap_true.
      catch cx_root.
    endtry.
  endmethod.


  method YEA_PARAMETERS~LIST.
    data params type stringtab.
    loop at _params assigning field-symbol(<p>).
      append <p>-value to returning.
    endloop.
  endmethod.
ENDCLASS.
