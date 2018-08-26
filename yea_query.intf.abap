interface yea_query
  public .


  methods get
    importing
      !argument        type string
    returning
      value(returning) type string .
  methods has
    importing
      !argument        type string
    returning
      value(returning) type abap_bool .
  methods list
    returning
      value(returning) type stringtab .
endinterface.
