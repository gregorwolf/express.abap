interface yea_parameters
  public .
  methods get
    importing
      !parameter       type string
    returning
      value(returning) type string .
  methods has
    importing
      !parameter       type string
    returning
      value(returning) type abap_bool .
  methods list
    returning
      value(returning) type stringtab .
endinterface.
