interface yea_route
  public .
  methods execute
    importing
      !request         type ref to yea_request
      !response        type ref to yea_response
    returning
      value(returning) type abap_bool .
endinterface.
