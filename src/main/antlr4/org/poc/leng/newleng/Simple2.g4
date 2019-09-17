grammar Simple2;

program : start_block body+ end_block                               ;


start_block: INIT                                                   ;
end_block: END                                                      ;
body: (assign                                                       
    | if_block                                                      
    | read_block                                                    
    | write_block
    | while_block);                                                   
    

while_block : LPAR cond RPAR LCOR body_block RCOR; 
assign : VARID ASSIGN expr                                          ; 
if_block: IF cond THEN body_block (ELIF cond THEN body_block)* (ELSE THEN body_block)?  ;
write_block: WRITE LPAR VARID RPAR                                  ;
read_block: READ LPAR VARID RPAR                                    ;
declaration: var_type VARID | var_type assign ;
var_type: (FLOAT | INT | BOOLEAN | STRING | VARID  );
body_block: body*  ;
cond: expr ;
expr : (expr_nat | expr_real | expr_string)                         ;
expr_real : LPAR expr_real op expr_real RPAR | FLOAT                ;
expr_nat : LPAR expr_nat op expr_nat RPAR | NUM                     ;
expr_string : expr_string op expr_string | STRING                   ;
op : PLUS | MINUS | MULT | GT | LT | EQT                            ;
string : '"'.*?'"'                                                  ;


fragment INT : [0-9]+                                                        ;
fragment FLOAT: INT DOT INT                                                  ;
fragment DOT: '.'                                                            ;
fragment BOOLEAN : 'true' | 'false'                                          ;

COMMENT	:  '!' .*? '\r'? '\n' -> skip	                            ;
WS 		: [ \t\r\n]+ -> skip                                        ;

VARID		: [a-zA-Z]+;

WRITE:  'write'                                                     ;
READ:   'read'                                                      ;

FLOAT_V : 'float'	;
INT_V : 'int';
STRING_V : 'str';

IF : 'if';
ELIF: 'elif';
ELSE: 'else';
THEN: ':';

INIT : 'init';
END : ';;';

LPAR: '(';
RPAR: ')';

LCOR: '{';
RCOR: '}';

PLUS : '+';
MINUS : '-';
MULT : '*';

GT: '>';
LT: '<';
EQT: '==';
ASSIGN: '<-';