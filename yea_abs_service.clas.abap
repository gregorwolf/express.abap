class YEA_ABS_SERVICE definition
  public
  abstract
  create public .

public section.

  interfaces YEA_SERVICE .
  interfaces IF_HTTP_EXTENSION .

  aliases COPY
    for YEA_SERVICE~COPY .
  aliases DELETE
    for YEA_SERVICE~DELETE .
  aliases GET
    for YEA_SERVICE~GET .
  aliases HEAD
    for YEA_SERVICE~HEAD .
  aliases LINK
    for YEA_SERVICE~LINK .
  aliases LOCK
    for YEA_SERVICE~LOCK .
  aliases OPTIONS
    for YEA_SERVICE~OPTIONS .
  aliases PATCH
    for YEA_SERVICE~PATCH .
  aliases POST
    for YEA_SERVICE~POST .
  aliases PROPFIND
    for YEA_SERVICE~PROPFIND .
  aliases PURGE
    for YEA_SERVICE~PURGE .
  aliases PUT
    for YEA_SERVICE~PUT .
  aliases ROOT
    for YEA_SERVICE~ROOT .
  aliases UNLINK
    for YEA_SERVICE~UNLINK .
  aliases UNLOCK
    for YEA_SERVICE~UNLOCK .
  aliases USE
    for YEA_SERVICE~USE .
  aliases VIEW
    for YEA_SERVICE~VIEW .

  methods CONSTRUCTOR .
  protected section.
private section.

  data _ROUTES type YEA_INTL_ROUTES .
  data _ALLOWED type STRINGTAB .
  data _TRACE type STRINGTAB .

  methods _PREPARE_REQUEST
    importing
      !SAP_REQUEST type ref to IF_HTTP_REQUEST
    returning
      value(RETURNING) type ref to YEA_REQUEST .
  methods _PREPARE_RESPONSE
    importing
      !SAP_RESPONSE type ref to IF_HTTP_RESPONSE
    returning
      value(RETURNING) type ref to YEA_RESPONSE .
  methods _MATCH_PATHS
    importing
      !PATH type STRING
      !METHOD type STRING
    returning
      value(RETURNING) type YEA_INTL_ROUTES .
  methods _PATH_TO_REGEX
    importing
      !PATH type STRING
    returning
      value(RETURNING) type STRING .
  methods _METHOD_ALLOWED
    importing
      !METHOD type STRING
    returning
      value(RETURNING) type ABAP_BOOL .
  methods _MATCHED_PATH .
ENDCLASS.



CLASS YEA_ABS_SERVICE IMPLEMENTATION.


  method CONSTRUCTOR.
    append yea_const=>method_get      to _allowed.
    append yea_const=>method_post     to _allowed.
    append yea_const=>method_put      to _allowed.
    append yea_const=>method_delete   to _allowed.
    append yea_const=>method_patch    to _allowed.
    append yea_const=>method_head     to _allowed.
    append yea_const=>method_copy     to _allowed.
    append yea_const=>method_options  to _allowed.
    append yea_const=>method_link     to _allowed.
    append yea_const=>method_purge    to _allowed.
    append yea_const=>method_lock     to _allowed.
    append yea_const=>method_unlock   to _allowed.
    append yea_const=>method_unlink   to _allowed.
    append yea_const=>method_propfind to _allowed.
    append yea_const=>method_view     to _allowed.
  endmethod.


  method if_http_extension~handle_request.
    clear: _trace.
    data(rq) = _prepare_request( server->request ).
    data(rs) = _prepare_response( server->response ).
    data headers type tihttpnvp.
    server->request->get_header_fields( changing fields = headers ).
    try.
        data(path) = headers[ name = '~path' ]-value.
        replace first occurrence of regex '\/$' in path with ''.
      catch cx_root.
    endtry.
    data(root_regex) = '^' && me->root( ).
    replace first occurrence of regex root_regex in path with ''.

    data(method) = server->request->get_method( ).
    if ( _method_allowed( method ) = abap_false ).
      rs->set_status( 405 )->end( ).
      return.
    endif.

    data(matched_routes) = _match_paths( path = path method = method ).
    read table matched_routes transporting no fields with key method = method.
    if ( sy-subrc <> 0 and lines( matched_routes ) = 0 ).
      rs->set_status( 404 )->end( ).
      return.
    elseif ( sy-subrc <> 0 and lines( matched_routes ) > 0 ).
      rs->set_status( 405 )->end( ).
      return.
    endif.

    loop at matched_routes assigning field-symbol(<route>).
      data(cast_request) = cast yea_base_request( rq ).
      cast_request->set_params(
        new yea_base_parameters(
          uri_arguments = <route>-path
          uri_request = path
        )
      ).
      data(do_next) = <route>-impl->execute( request = rq response = rs ).
      data(cl_def) = cl_abap_typedescr=>describe_by_object_ref( <route>-impl ).
      append |['{ <route>-method }','{ <route>-path }','{ cl_def->get_relative_name( ) }']| to _trace.
      if ( do_next = abap_false ).
        if ( rs->finished( ) = abap_false ).
          rs->set_status( 400 )->end( ).
        endif.
        exit.
      endif.
    endloop.
  endmethod.


  method yea_service~copy.
    append value yea_intl_route(
      path = path
      method = yea_const=>method_copy
      impl = route
      ) to me->_routes.
    returning = me.
  endmethod.


  method yea_service~delete.
    append value yea_intl_route(
      path = path
      method = yea_const=>method_delete
      impl = route
      ) to me->_routes.
    returning = me.
  endmethod.


  method yea_service~get.
    append value yea_intl_route(
      path = path
      method = yea_const=>method_get
      impl = route
      ) to me->_routes.
    returning = me.
  endmethod.


  method yea_service~head.
    append value yea_intl_route(
      path = path
      method = yea_const=>method_head
      impl = route
      ) to me->_routes.
    returning = me.
  endmethod.


  method yea_service~link.
    append value yea_intl_route(
      path = path
      method = yea_const=>method_link
      impl = route
      ) to me->_routes.
    returning = me.
  endmethod.


  method yea_service~lock.
    append value yea_intl_route(
      path = path
      method = yea_const=>method_lock
      impl = route
      ) to me->_routes.
    returning = me.
  endmethod.


  method yea_service~options.
    append value yea_intl_route(
      path = path
      method = yea_const=>method_options
      impl = route
      ) to me->_routes.
    returning = me.
  endmethod.


  method yea_service~patch.
    append value yea_intl_route(
      path = path
      method = yea_const=>method_patch
      impl = route
      ) to me->_routes.
    returning = me.
  endmethod.


  method yea_service~post.
    append value yea_intl_route(
      path = path
      method = yea_const=>method_post
      impl = route
      ) to me->_routes.
    returning = me.
  endmethod.


  method yea_service~propfind.
    append value yea_intl_route(
      path = path
      method = yea_const=>method_propfind
      impl = route
      ) to me->_routes.
    returning = me.
  endmethod.


  method yea_service~purge.
    append value yea_intl_route(
      path = path
      method = yea_const=>method_purge
      impl = route
      ) to me->_routes.
    returning = me.
  endmethod.


  method yea_service~put.
    append value yea_intl_route(
      path = path
      method = yea_const=>method_put
      impl = route
      ) to me->_routes.
    returning = me.
  endmethod.


  method yea_service~root.
    raise exception type cx_rs_not_implemented.
  endmethod.


  method yea_service~trace.
    returning = _trace.
  endmethod.


  method yea_service~unlink.
    append value yea_intl_route(
      path = path
      method = yea_const=>method_unlink
      impl = route
      ) to me->_routes.
    returning = me.
  endmethod.


  method yea_service~unlock.
    append value yea_intl_route(
      path = path
      method = yea_const=>method_unlock
      impl = route
      ) to me->_routes.
    returning = me.
  endmethod.


  method yea_service~use.
    append value yea_intl_route(
      path = path
      method = yea_const=>middleware_use
      impl = route
      ) to me->_routes.
    returning = me.
  endmethod.


  method yea_service~view.
    append value yea_intl_route(
      path = path
      method = yea_const=>method_view
      impl = route
      ) to me->_routes.
    returning = me.
  endmethod.


  method _MATCHED_PATH.
  endmethod.


  method _match_paths.
    data matching type yea_intl_routes.
    data in_path type string.
    in_path = path.
    split in_path at yea_const=>url_split into table data(route_split).
    data(route_count) = lines( route_split ).
    if ( route_count = 0 ).
      in_path = yea_const=>url_split.
    endif.

    loop at me->_routes assigning field-symbol(<route>) where ( method = method or method = 'USE' ).

      " Middleware with '*' applies to all routes
      if ( <route>-path   = yea_const=>wildcard and
           <route>-method = yea_const=>middleware_use ).
        append <route> to matching.
        continue.
      endif.

      data(rt_regex) = _path_to_regex( <route>-path ).

      " Exact Matches
      if ( <route>-path = in_path and ( <route>-method = method or
                                        <route>-method = yea_const=>middleware_use ) ).
        append <route> to matching.
        continue.
      elseif ( <route> is not initial and ( <route>-method = method or
                                            <route>-method = yea_const=>middleware_use ) ).
        " Check Regex match
        try.
            data matches type i.
            if ( <route>-method = yea_const=>middleware_use ).
              find all occurrences of regex rt_regex in path match count matches.
            else.
              if ( strlen( rt_regex ) > 0 ).
                rt_regex = rt_regex && '$'.
                find all occurrences of regex rt_regex in path match count matches.
              endif.
            endif.
            if ( matches > 0 ).
              append <route> to matching.
            endif.
            matches = 0.
          catch cx_sy_invalid_regex.
        endtry.
      endif.
    endloop.
    returning = matching.
  endmethod.


  method _METHOD_ALLOWED.
    read table _allowed with key table_line = method transporting no fields.
    if ( sy-subrc = 0 ).
      returning = abap_true.
    endif.
  endmethod.


  method _path_to_regex.
    data path_splits type stringtab.
    split path at '/' into table path_splits.
    loop at path_splits assigning field-symbol(<ps>).
      if ( strlen( <ps> ) > 0 and <ps>+0(1) = ':' ).
        returning = returning && '\/' && yea_const=>url_rgx. "
      elseif ( <ps> is not initial ).
        returning = returning && '\/' && <ps>.
      endif.
    endloop.
  endmethod.


  method _prepare_request.
    returning = new yea_base_request(
      sap_request = sap_request
      service_root = me->root( )
    ).
  endmethod.


  method _prepare_response.
    returning = new yea_base_response( sap_response ).
  endmethod.
ENDCLASS.
