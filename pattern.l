%{

int total_tokens =0 ;
int total_lines = 1;

%}

%option noyywrap

%%

("int")|("if")|("else")|("while")               {total_tokens++; fprintf(yyout,"<Keyword , %s>\n",yytext);}
("do")|("break")|("continue")|("double")        {total_tokens++; fprintf(yyout,"<Keyword , %s>\n",yytext);}
("float")|("return")|("EOF")|("return")         {total_tokens++; fprintf(yyout,"<Keyword , %s>\n",yytext);}
("char")|("case")|("sizeof")|("goto")           {total_tokens++; fprintf(yyout,"<Keyword , %s>\n",yytext);}
("long")|("short")|("typedef")|("static")       {total_tokens++; fprintf(yyout,"<Keyword , %s>\n",yytext);}
("switch")|("unsigned")|("void")|("struct")     {total_tokens++; fprintf(yyout,"<Keyword , %s>\n",yytext);}

[a-zA-Z_][a-zA-Z0-9_]*                          {total_tokens++; fprintf(yyout,"<Identifier , %s>\n",yytext);}

-?(([0-9]+)|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?) {total_tokens++; fprintf(yyout,"<Number , %s>\n", yytext);}
("0"("X"|"x"))[0-9A-F]+                         {total_tokens++; fprintf(yyout,"<Number , %s>\n", yytext);}
("0"("B"|"b"))[01]+                             {total_tokens++; fprintf(yyout,"<Number , %s>\n", yytext);}

["]([^"\\\n]|\\.|\\\n)*["]                      {total_tokens++; fprintf(yyout,"<String , %s>\n",yytext);}

[',";(){}._:]                                   {total_tokens++; fprintf(yyout,"<Separator , %s>\n",yytext);}
"["|"]"                                         {total_tokens++; fprintf(yyout,"<Separator , %s>\n",yytext);}

"="                                             {total_tokens++; fprintf(yyout,"<Operator , %s>\n",yytext);}
"+"|"-"|"*"|"/"|"%"|"++"|"--"                   {total_tokens++; fprintf(yyout,"<Operator , %s>\n",yytext);}
"=="|"!="|"<"|">"|"<="|">="|"?"                 {total_tokens++; fprintf(yyout,"<Operator , %s>\n",yytext);}
"&&"|[|][|]|"!"                                 {total_tokens++; fprintf(yyout,"<Operator , %s>\n",yytext);}
"<<"|">>"|"~"|"&"|"^"|[|]                       {total_tokens++; fprintf(yyout,"<Operator , %s>\n",yytext);}


#.*                                             {total_tokens++; fprintf(yyout,"<Preprocessor , %s>\n",yytext);}

"//".*" "*                                      {total_tokens++;fprintf(yyout,"<Comments , %s>\n",yytext);}
\/\*(.*)*.*\*\/                                 {total_tokens++;fprintf(yyout,"<Comments , %s>\n",yytext);}

[ \t\v\n\r]                                     {if(yytext[0] == '\n') total_lines++;}

.                                               {fprintf(yyout,"<Unrecognized , %s>\n",yytext);}

%%

int main()
{
extern FILE *yyin, *yyout; 
    
    char filename[50];

    printf("Enter the input file name: \n");
    scanf("%s",filename);

    yyin = fopen(filename, "r"); 
    yyout = fopen("output.txt", "w"); 
  
    yylex();

	fprintf(yyout,"\nTotal no. of tokens = %d \n",total_tokens);
	fprintf(yyout,"Total no. of lines = %d \n",total_lines); 

    return 0; 
}