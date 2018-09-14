
class root definition.
  public section.
    interfaces yea_route.
endclass.
class root implementation.
  method yea_route~execute.
    response->send_text( 'hello' ).
  endmethod.
endclass.

" Returns the HTTP method used
class method_echo definition.
  public section.
    interfaces yea_route.
endclass.
class method_echo implementation.
  method yea_route~execute.
    response->send_text( request->method( ) ).
  endmethod.
endclass.

" Returns the body present in the message
class body_echo definition.
  public section.
    interfaces yea_route.
endclass.
class body_echo implementation.
  method yea_route~execute.
    response->send_text( request->body( ) ).
  endmethod.
endclass.

" Returns the query used in the call
class query_echo definition.
  public section.
    interfaces yea_route.
endclass.
class query_echo implementation.
  method yea_route~execute.
    data(query) = request->query( ).
    data query_arguments type stringtab.
    loop at query->list( ) assigning field-symbol(<q>).
      if <q>-value is not initial.
        append |{ <q>-key }={ <q>-value }| to query_arguments.
      else.
        append <q>-key to query_arguments.
      endif.
    endloop.
    concatenate lines of query_arguments into data(result) separated by '&'.
    response->send_text( result ).
  endmethod.
endclass.

" Returns the params used in the call
class params_echo definition.
  public section.
    interfaces yea_route.
endclass.
class params_echo implementation.
  method yea_route~execute.
    data(params) = request->parameters( ).
    data param_arguments type stringtab.
    loop at params->list( ) assigning field-symbol(<p>).
      append |{ <p>-key }={ <p>-value }| to param_arguments.
    endloop.
    concatenate lines of param_arguments into data(result) separated by '&'.
    response->send_text( result ).
  endmethod.
endclass.

" Returns the headers used in the call
class headers_echo definition.
  public section.
    interfaces yea_route.
endclass.
class headers_echo implementation.
  method yea_route~execute.
    data header_arguments type stringtab.
    loop at request->headers( ) assigning field-symbol(<h>).
      append |{ <h>-key }={ <h>-value }| to header_arguments.
    endloop.
    concatenate lines of header_arguments into data(result) separated by '&'.
    response->send_text( result ).
  endmethod.
endclass.

" Middleware to check roles
class role_check definition.
  public section.
    interfaces yea_route.
    methods: constructor importing role type string.
  private section.
    data: _role type string.
endclass.
class role_check implementation.
  method constructor.
    _role = role.
  endmethod.
  method yea_route~execute.
    select count(*) from agr_users
      where uname = sy-uname
        and agr_name = _role.
    if ( sy-dbcnt > 0 ).
      returning = abap_true.
    else.
      response->set_status( 401 )->send_text( |Missing role { _role }| ).
      returning = abap_false.
    endif.
  endmethod.
endclass.

" Middleware to check content-type
class ctype_check definition.
  public section.
    interfaces yea_route.
    methods: constructor importing ctype type string.
  private section.
    data: _ctype type string.
endclass.
class ctype_check implementation.
  method constructor.
    _ctype = ctype.
  endmethod.
  method yea_route~execute.
    if ( request->content_type( ) = _ctype ).
      returning = abap_true.
    else.
      response->set_status( 400 )->send_text( |Content-type: { _ctype } required| ).
    endif.
  endmethod.
endclass.
