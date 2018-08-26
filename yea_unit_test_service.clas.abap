class YEA_UNIT_TEST_SERVICE definition
  public
  inheriting from YEA_ABS_SERVICE
  final
  create public .

public section.

  data POOP type STRING .

  methods CONSTRUCTOR .

  methods YEA_SERVICE~ROOT
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS YEA_UNIT_TEST_SERVICE IMPLEMENTATION.


  method CONSTRUCTOR.
    super->constructor( ).

    poop = 'poop'.

    " Simple root element for basic http methods
    data(root_route) = new root( ).
    get(    path = '/' route = root_route ).
    post(   path = '/' route = root_route ).
    put(    path = '/' route = root_route ).
    delete( path = '/' route = root_route ).
    head(   path = '/' route = root_route ).

  endmethod.


  method YEA_SERVICE~ROOT.
    returning = '/yea/unit/test'.
  endmethod.
ENDCLASS.
