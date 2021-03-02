% Trabalho Pr�tico 1: Prolog
% prot�tipo de um sistema de diagn�stico m�dico.
:- use_module(library(plunit)).
:- include('menus.pl').

% --------------------------------DOEN�AS--------------------------------

doenca('catapora', ['coceira', 'erup��es cut�neas', 'fadiga', 'febre baixa']).
doenca('dengue', ['dor atr�s dos olhos', 'dores no corpo', 'febre alta', 'n�usea']).
doenca('ebola', ['erup��es cut�neas', 'diarreia', 'dores no corpo', 'febre alta']).
doenca('febre amarela', ['dores de cabe�a', 'febre alta', 'hemorragia', 'pele amarelada']).
doenca('hepatite', ['diarreia', 'fadiga', 'febre baixa', 'n�usea']).
doenca('raiva', ['confus�o mental', 'convuls�es', 'mal-estar', 'paralisia']).
doenca('rub�ola', ['dor na articula��o', 'febre baixa', 'incha�o dos n�dulos linf�ticos', 'manchas avermelhadas']).
doenca('sarampo', ['conjuntivite', 'febre alta', 'renite', 'tosse']).
doenca('var�ola', ['dores de cabe�a', 'dores no corpo', 'erup��es cut�neas', 'febre alta']).
doenca('zika', ['dor atr�s dos olhos', 'dores no corpo', 'febre baixa', 'n�usea']).

% --------------------------------DOEN�AS--------------------------------



% -------------------------------SINTOMAS--------------------------------

sintoma('coceira').
sintoma('confus�o mental').
sintoma('conjuntivite').
sintoma('convuls�es').
sintoma('diarreia').
sintoma('dor atr�s dos olhos').
sintoma('dor na articula��o').
sintoma('dores de cabe�a').
sintoma('dores no corpo').
sintoma('erup��es cut�neas').
sintoma('fadiga').
sintoma('febre alta').
sintoma('febre baixa').
sintoma('hemorragia').
sintoma('incha�o dos n�dulos linf�ticos').
sintoma('mal-estar').
sintoma('manchas avermelhadas').
sintoma('n�usea').
sintoma('paralisia').
sintoma('pele amarelada').
sintoma('renite').
sintoma('tosse').

% -------------------------------SINTOMAS--------------------------------



% ---------------------------------CRUD----------------------------------

inclusao() :-
    nl,
    write("--------------- Inclus�o de Paciente --------------- "),
    nl,
    write("Digite o nome do paciente a ser inclu�do:\n"),
    get_char(_),
    read_string(user_input, "\n", "\r\t ", _, Nome),
    write("Digite a idade do paciente a ser inclu�do:\n"),
    read(Idade),
    escrevePaciente(Nome, Idade),
    get_char(_),
    nl,
    write("PACIENTE INCLUIDO COM SUCESSO!\n"),
    nl,
    writeln("Pressione Enter para finalizar"),
    get_char(_),
    menuPaciente().

consulta() :-
    nl,
    write("--------------- Consulta de Paciente --------------- "),
    nl,
    write("Digite o nome do paciente a ser consultado:\n"),
    get_char(_),
    read_string(user_input, "\n", "\r\t ", _, Paciente),
    lePaciente(Paciente),
    nl,
    writeln("Pressione Enter para finalizar"),
    get_char(_),
    menuPaciente().

alteracao() :-
    nl,
    write("--------------- Alterar Paciente --------------- "),
    nl,
    write("Digite o nome do paciente que deseja ser alterado:\n"),
    get_char(_),
    read_string(user_input, "\n", "\r\t ", _, Paciente),
    write("Digite o novo nome do paciente desejado:\n"),
    read_string(user_input, "\n", "\r\t ", _, NovoNome),
    write("Digite a nova idade do paciente desejado:\n"),
    read_string(user_input, "\n", "\r\t ", _, NovaIdade),
    exists_file('pacientes.txt'),
    open('pacientes.txt', read, Arquivo1),
    read_file(Arquivo1, Lista),
    close(Arquivo1),
    open('pacientes.txt', write, Arquivo),
    altera(Arquivo, Lista, Paciente, NovoNome, NovaIdade),
    close(Arquivo),
    writeln("ALTERA��O REALIZADA COM SUCESSO!"),
    nl,
    writeln("Pressione Enter para finalizar"),
    get_char(_),
    menuPaciente().

exclusao() :-
    nl,
    write("--------------- Excluir Paciente --------------- "),
    nl,
    write("Digite o nome do paciente que deseja ser exclu�do:\n"),
    get_char(_),
    read_string(user_input, "\n", "\r\t ", _, Paciente),
    exists_file('pacientes.txt'),
    open('pacientes.txt', read, Arquivo1),
    read_file(Arquivo1, Lista),
    close(Arquivo1),
    open('pacientes.txt', write, Arquivo),
    exclui(Arquivo, Lista, Paciente),
    close(Arquivo),
    writeln("EXCLUS�O REALIZADA COM SUCESSO!"),
    nl,
    writeln("Pressione Enter para finalizar"),
    get_char(_),
    menuPaciente().

% ---------------------------------CRUD----------------------------------

%% escrevePaciente(+Nome, +Idade) is det
%
%  Verdadeiro se foi possivel escrever o conte�do
%  de Nome e Idade no arquivo pacientes.txt.

:- begin_tests(escrevePaciente).

test(t0) :- escrevePaciente("pablo diamante", 22).
test(t1) :- escrevePaciente("paciente dois", 30).
test(t2) :- escrevePaciente("nome do paciente tres", 100).

:- end_tests(escrevePaciente).

escrevePaciente(Nome, Idade) :-
    exists_file('pacientes.txt'),
    open('pacientes.txt', append, X),
    current_output(Stream2),
    set_output(X),
    write(Nome),
    write("|"),
    write(Idade),
    write("\n"),
    close(X),
    set_output(Stream2).



%% lePaciente(+Paciente) is det
%
%  Verdadeiro se o conte�do de Paciente
%  foi encontrado no arquivo pacientes.txt.

:- begin_tests(lePaciente).

test(t0) :- lePaciente("pablo diamante").
test(t1) :- lePaciente("paciente dois").
test(t2) :- lePaciente("nome do paciente tres").

:- end_tests(lePaciente).

lePaciente(Paciente) :-
    exists_file('pacientes.txt'),
    open('pacientes.txt', read, Arquivo),
    read_file(Arquivo, Lista),
    busca(Paciente, Lista),
    close(Arquivo).

busca(_, []) :-
    writeln("PACIENTE N�O ENCONTRADO!").

busca(Paciente, [E | R]) :-
    split_string(E, "|", "", [Nome | X]),
    [Idade | _] = X,
    Paciente == Nome,
    writeln("PACIENTE ENCONTRADO!"),
    write("Nome = "),
    writeln(Nome),
    write("Idade = "),
    writeln(Idade), !;
    busca(Paciente, R).



%!  altera(+Arquivo, +Lista, +Paciente, +NovoNome, +NovaIdade) is det
%
%   predicado que altera o nome e idade de Paciente para NovoNome e
%   NovaIdade.

altera(_, [], _, _, _) :-
    !.

altera(Arquivo, [E | R], Paciente, NovoNome, NovaIdade) :-
    split_string(E, "|", "", [Nome | _]),
    Paciente == Nome, !,
    write(Arquivo, NovoNome),
    write(Arquivo, "|"),
    write(Arquivo, NovaIdade),
    write(Arquivo, "\n"),
    altera(Arquivo, R, Paciente, NovoNome, NovaIdade), !.

altera(Arquivo, [E | R], Paciente, NovoNome, NovaIdade) :-
    split_string(E, "|", "", [Nome | X]),
    [Idade | _] = X,
    Paciente \== Nome, !,
    write(Arquivo, Nome),
    write(Arquivo, "|"),
    write(Arquivo, Idade),
    write(Arquivo, "\n"),
    altera(Arquivo, R, Paciente, NovoNome, NovaIdade), !.



%!  exclui(+Arquivo, +Lista, +Paciente) is det
%
%   predicado que reescreve todos os pacientes contido na Lista
%   que s�o diferentes de Paciente.

exclui(_, [], _) :-
    !.

exclui(Arquivo, [E | R], Paciente) :-
    split_string(E, "|", "", [Nome | _]),
    Paciente == Nome, !,
    exclui(Arquivo, R, Paciente), !.

exclui(Arquivo, [E | R], Paciente) :-
    split_string(E, "|", "", [Nome | X]),
    [Idade | _] = X,
    Paciente \== Nome, !,
    write(Arquivo, Nome),
    write(Arquivo, "|"),
    write(Arquivo, Idade),
    write(Arquivo, "\n"),
    exclui(Arquivo, R, Paciente), !.



% ----------------------------LeArquivo-----------------------------

%!  read_file(+Stream, +Lista) is det
%
%   predicado que l� todo o conte�do de Stream e insere na Lista.

read_file(Stream, []) :-
    at_end_of_stream(Stream).

read_file(Stream, [Line | L]) :-
    \+ at_end_of_stream(Stream),
    read_string(Stream, "\n", "\r\t ", _, Line),
    read_file(Stream, L).

% ----------------------------LeArquivo-----------------------------



% --------------------------InsertionSort---------------------------

%!  ordenaLista(+Lista, +ListaOrd) is det
%
%   predicado que insere em ordem decrescente os elementos de Lista
%   na ListaOrd.

ordenaLista([], []).

ordenaLista([E | R], ListaOrd) :-
    ordenaLista(R, ROrd),
    inserir(E, ROrd, ListaOrd).

inserir(X, [Y | ROrd1], [Y | ROrd2]) :-
    maior(X, Y),
    !,
    inserir(X, ROrd1, ROrd2).

inserir(X, ROrd, [X | ROrd]).

maior((_,X), (_,Y)) :- X < Y.

% --------------------------InsertionSort---------------------------



% --------------------------SomaElementos---------------------------

%!  somaLista(+Lista, -Soma) is semidet
%
%   predicado que soma todos os elementos de Lista e unifica com Soma.

somaLista(Lista, Soma) :-
    somaLista(Lista, 0, Soma).% chamada inicial.

somaLista([], Acc, Acc).

somaLista([(_, N) | R], Acc, Total) :-
    NovoAcc is Acc + N,
    somaLista(R, NovoAcc, Total).

% --------------------------SomaElementos---------------------------



% -------------------------InsereElementos--------------------------

%!  addLista(+X, +Doenca, +ListaE, -ListaS) is det
%
%   predicado que insere o elemento (X, Doenca) junto com os elementos
%   de ListaE na ListaS.

addLista(X, Doenca, ListaE, ListaS) :-
    X \== 0,
    append(ListaE, [(Doenca, X)], ListaS);
    ListaS = ListaE.

% -------------------------InsereElementos--------------------------



% ---------------------------Diagn�stico----------------------------

diagnostico() :-
    perguntas(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, []).

perguntas(C, D, E, F, H, Ra, Ru, S, V, Z, Sintomas) :-
    write('\33\[2J'),
    write("Sistema de Diagn�stico M�dico\n"),
    nl,
    write("--------------- Diagn�stico --------------- "),
    nl,
    write("Escolha os sintomas que o paciente apresenta:\n"),
    write("1 - coceira\n"),
    write("2 - confus�o mental\n"),
    write("3 - conjuntivite\n"),
    write("4 - convuls�es\n"),
    write("5 - diarr�ia\n"),
    write("6 - dor atr�s dos olhos\n"),
    write("7 - dor na articula��o\n"),
    write("8 - dores de cabe�a\n"),
    write("9 - dores no corpo\n"),
    write("10 - erup��es cut�neas\n"),
    write("11 - fadiga\n"),
    write("12 - febre alta\n"),
    write("13 - febre baixa\n"),
    write("14 - hemorragia\n"),
    write("15 - incha�o nos n�dulos linf�ticos\n"),
    write("16 - mal-estar\n"),
    write("17 - manchas avermelhadas\n"),
    write("18 - n�usea\n"),
    write("19 - paralisia\n"),
    write("20 - pele amarelada\n"),
    write("21 - renite\n"),
    write("22 - tosse\n"),
    write("0 - Finalizar (Caso j� tenha escolhido todos os sintomas)\n"),
    read(Opcao),
    escolhaPerguntas(Opcao, C, D, E, F, H, Ra, Ru, S, V, Z, Sintomas).

escolhaPerguntas(Opcao, C, D, E, F, H, Ra, Ru, S, V, Z, Sintomas) :-
    Opcao = 1,
    X is C + 1,
    append(Sintomas, ['coceira'], ListaSintomas),
    perguntas(X, D, E, F, H, Ra, Ru, S, V, Z, ListaSintomas);
    Opcao = 2,
    X is Ra + 1,
    append(Sintomas, ['confus�o mental'], ListaSintomas),
    perguntas(C, D, E, F, H, X, Ru, S, V, Z, ListaSintomas);
    Opcao = 3,
    X is S + 1,
    append(Sintomas, ['conjuntivite'], ListaSintomas),
    perguntas(C, D, E, F, H, Ra, Ru, X, V, Z, ListaSintomas);
    Opcao = 4,
    X is Ra + 1,
    append(Sintomas, ['convuls�es'], ListaSintomas),
    perguntas(C, D, E, F, H, X, Ru, S, V, Z, ListaSintomas);
    Opcao = 5,
    X is E + 1,
    Y is H + 1,
    append(Sintomas, ['diarr�ia'], ListaSintomas),
    perguntas(C, D, X, F, Y, Ra, Ru, S, V, Z, ListaSintomas);
    Opcao = 6,
    X is D + 1,
    Y is Z + 1,
    append(Sintomas, ['dor atr�s dos olhos'], ListaSintomas),
    perguntas(C, X, E, F, H, Ra, Ru, S, V, Y, ListaSintomas);
    Opcao = 7,
    X is Ru + 1,
    append(Sintomas, ['dor na articula��o'], ListaSintomas),
    perguntas(C, D, E, F, H, Ra, X, S, V, Z, ListaSintomas);
    Opcao = 8,
    X is F + 1,
    Y is V + 1,
    append(Sintomas, ['dores de cabe�a'], ListaSintomas),
    perguntas(C, D, E, X, H, Ra, Ru, S, Y, Z, ListaSintomas);
    Opcao = 9,
    X is D + 1,
    Y is E + 1,
    X2 is V + 1,
    Y2 is Z + 1,
    append(Sintomas, ['dores no corpo'], ListaSintomas),
    perguntas(C, X, Y, F, H, Ra, Ru, S, X2, Y2, ListaSintomas);
    Opcao = 10,
    X is C + 1,
    Y is E + 1,
    X2 is V + 1,
    append(Sintomas, ['erup��es cut�neas'], ListaSintomas),
    perguntas(X, D, Y, F, H, Ra, Ru, S, X2, Z, ListaSintomas);
    Opcao = 11,
    X is C + 1,
    Y is H + 1,
    append(Sintomas, ['fadiga'], ListaSintomas),
    perguntas(X, D, E, F, Y, Ra, Ru, S, V, Z, ListaSintomas);
    Opcao = 12,
    X is D + 1,
    Y is E + 1,
    X2 is F + 1,
    Y2 is S + 1,
    X3 is V + 1,
    append(Sintomas, ['febre alta'], ListaSintomas),
    perguntas(C, X, Y, X2, H, Ra, Ru, Y2, X3, Z, ListaSintomas);
    Opcao = 13,
    X is C + 1,
    Y is H + 1,
    X2 is Ru + 1,
    Y2 is Z + 1,
    append(Sintomas, ['febre baixa'], ListaSintomas),
    perguntas(X, D, E, F, Y, Ra, X2, S, V, Y2, ListaSintomas);
    Opcao = 14,
    X is F + 1,
    append(Sintomas, ['hemorragia'], ListaSintomas),
    perguntas(C, D, E, X, H, Ra, Ru, S, V, Z, ListaSintomas);
    Opcao = 15,
    X is Ru + 1,
    append(Sintomas, ['incha�o nos n�dulos linf�ticos'], ListaSintomas),
    perguntas(C, D, E, F, H, Ra, X, S, V, Z, ListaSintomas);
    Opcao = 16,
    X is Ra + 1,
    append(Sintomas, ['mal-estar'], ListaSintomas),
    perguntas(C, D, E, F, H, X, Ru, S, V, Z, ListaSintomas);
    Opcao = 17,
    X is Ru + 1,
    append(Sintomas, ['manchas avermelhadas'], ListaSintomas),
    perguntas(C, D, E, F, H, Ra, X, S, V, Z, ListaSintomas);
    Opcao = 18,
    X is D + 1,
    Y is H + 1,
    X2 is Z + 1,
    append(Sintomas, ['n�usea'], ListaSintomas),
    perguntas(C, X, E, F, Y, Ra, Ru, S, V, X2, ListaSintomas);
    Opcao = 19,
    X is Ra + 1,
    append(Sintomas, ['paralisia'], ListaSintomas),
    perguntas(C, D, E, F, H, X, Ru, S, V, Z, ListaSintomas);
    Opcao = 20,
    X is F + 1,
    append(Sintomas, ['pele amarelada'], ListaSintomas),
    perguntas(C, D, E, X, H, Ra, Ru, S, V, Z, ListaSintomas);
    Opcao = 21,
    X is S + 1,
    append(Sintomas, ['renite'], ListaSintomas),
    perguntas(C, D, E, F, H, Ra, Ru, X, V, Z, ListaSintomas);
    Opcao = 22,
    X is S + 1,
    append(Sintomas, ['tosse'], ListaSintomas),
    perguntas(C, D, E, F, H, Ra, Ru, X, V, Z, ListaSintomas);
    Opcao = 0,
    Lista0 = [],
    addLista(C, 'catapora', Lista0, Lista1),
    addLista(D, 'dengue', Lista1, Lista2),
    addLista(E, 'ebola', Lista2, Lista3),
    addLista(F, 'febre amarela', Lista3, Lista4),
    addLista(H, 'hepatite', Lista4, Lista5),
    addLista(Ra, 'raiva', Lista5, Lista6),
    addLista(Ru, 'rub�ola', Lista6, Lista7),
    addLista(S, 'sarampo', Lista7, Lista8),
    addLista(V, 'var�ola', Lista8, Lista9),
    addLista(Z, 'zika', Lista9, Lista10),
    ordenaLista(Lista10, Lista),
    somaLista(Lista, Soma),
    write('\33\[2J'),
    writeln("--------------- Resultado do Diagn�stico --------------- "),
    format('~`.t ~w~34| ~`.t ~w~72|~n', ["DOEN�A", "PROBABILIDADE"]),
    fim(Lista, Soma),
    writeln("O RESULTADO DESTE PROT�TIPO � APENAS INFORMATIVO!"),
    writeln("O PACIENTE DEVE CONSULTAR UM M�DICO PARA OBTER UM DIAGN�STICO CORRETO E PRECISO!"),
    escolhaFinal(Sintomas, Lista).

fim([], _) :-
    nl.

fim([(D, P) | R], Soma) :-
    X is P / Soma,
    Y is X * 100,
    format('~`.t ~w~34| ~`.t ~2f%~72|~n',[D,Y]),
    fim(R, Soma).

escolhaFinal(Sintomas, Lista) :-
    nl,
    writeln("1 - mais informa��es"),
    writeln("2 - sair"),
    read(Opcao),
    Opcao = 1,
    maisInformacoes(Sintomas, Lista);
    writeln("FIM!").

maisInformacoes(Sintomas, [(D, _) | _]) :-
    writeln("MAIS INFORMA��ES:"),
    doenca(D, Lista),
    compara1(Sintomas, Lista, []).

compara1([], Lista, Iguais) :-
    writeln("Lista de sintomas da doen�a com maior probabilidade que o paciente APRESENTA"),
    writeln(Iguais),
    compara(Lista, Iguais, []).

compara1([E | R], Lista, Iguais) :-
    member(E, Lista),
    append(Iguais, [E], ListaIguais),
    compara1(R, Lista, ListaIguais);
    compara1(R, Lista, Iguais).

compara([], _, Diferentes) :-
    writeln("Lista de sintomas da doen�a com maior probabilidade que o paciente N�O APRESENTA"),
    writeln(Diferentes).

compara([E | R], Lista, Diferentes) :-
    member(E, Lista),
    compara(R, Lista, Diferentes);
    append(Diferentes, [E], ListaDiferentes),
    compara(R, Lista, ListaDiferentes).

% ---------------------------Diagn�stico----------------------------
