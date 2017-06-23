
" Basic root route
class root definition.
  public section.
    interfaces yea_route.
endclass.
class root implementation.
  method yea_route~execute.
    case request->method( ).
      when 'GET'.
        response->set_status( 200 ).
      when 'POST'.
        response->set_status( 201 ).
      when 'PUT'.
        response->set_status( 202 ).
      when 'DELETE'.
        response->set_status( 202 ).
      when 'HEAD'.
        response->set_status( 204 ).
    endcase.
    response->send_text( request->method( ) ).
  endmethod.
endclass.
