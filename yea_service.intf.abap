interface yea_service
  public .
  methods use
    importing
      !path            type string
      !route           type ref to yea_route
    returning
      value(returning) type ref to yea_service .
  methods get
    importing
      !path            type string
      !route           type ref to yea_route
    returning
      value(returning) type ref to yea_service .
  methods head
    importing
      !path            type string
      !route           type ref to yea_route
    returning
      value(returning) type ref to yea_service .
  methods post
    importing
      !path            type string
      !route           type ref to yea_route
    returning
      value(returning) type ref to yea_service .
  methods put
    importing
      !path            type string
      !route           type ref to yea_route
    returning
      value(returning) type ref to yea_service .
  methods delete
    importing
      !path            type string
      !route           type ref to yea_route
    returning
      value(returning) type ref to yea_service .
  methods patch
    importing
      !path            type string
      !route           type ref to yea_route
    returning
      value(returning) type ref to yea_service .
  methods copy
    importing
      !path            type string
      !route           type ref to yea_route
    returning
      value(returning) type ref to yea_service .
  methods options
    importing
      !path            type string
      !route           type ref to yea_route
    returning
      value(returning) type ref to yea_service .
  methods link
    importing
      !path            type string
      !route           type ref to yea_route
    returning
      value(returning) type ref to yea_service .
  methods unlink
    importing
      !path            type string
      !route           type ref to yea_route
    returning
      value(returning) type ref to yea_service .
  methods purge
    importing
      !path            type string
      !route           type ref to yea_route
    returning
      value(returning) type ref to yea_service .
  methods lock
    importing
      !path            type string
      !route           type ref to yea_route
    returning
      value(returning) type ref to yea_service .
  methods unlock
    importing
      !path            type string
      !route           type ref to yea_route
    returning
      value(returning) type ref to yea_service .
  methods propfind
    importing
      !path            type string
      !route           type ref to yea_route
    returning
      value(returning) type ref to yea_service .
  methods view
    importing
      !path            type string
      !route           type ref to yea_route
    returning
      value(returning) type ref to yea_service .
  methods root
    returning
      value(returning) type string .
endinterface.
