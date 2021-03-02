% Trabalho Pr�tico 1: Prolog
% prot�tipo de um sistema de diagn�stico m�dico.

start :-
    write('\33\[2J'),
    write("Sistema de Diagn�stico M�dico\n"),
    nl,
    write("--------------- Menu Principal --------------- "),
    nl,
    write("1 - Menu de Paciente\n"),
    write("2 - Menu de Diagn�stico\n"),
    write("3 - Sair\n"),
    nl,
    write("Escolha uma das op��es dadas:"),
    read(Opcao),
    write('\33\[2J'),
    escolhaPrincipal(Opcao).

escolhaPrincipal(Opcao) :-
    Opcao = 1,
    menuPaciente();
    Opcao = 2,
    menuDiagnostico();
    Opcao = 3.



menuPaciente() :-
    write('\33\[2J'),
    write("Sistema de Diagn�stico M�dico\n"),
    nl,
    write("--------------- Menu de Paciente --------------- "),
    nl,
    write("1 - Consulta\n"),
    write("2 - Inclus�o\n"),
    write("3 - Altera��o\n"),
    write("4 - Exclus�o\n"),
    write("5 - Menu Principal\n"),
    nl,
    write("Escolha uma das op��es dadas:"),
    read(Opcao),
    write('\33\[2J'),
    escolhaPaciente(Opcao).

escolhaPaciente(Opcao) :-
    Opcao = 1,
    consulta();
    Opcao = 2,
    inclusao();
    Opcao = 3,
    alteracao();
    Opcao = 4,
    exclusao();
    Opcao = 5,
    start().



menuDiagnostico() :-
    write('\33\[2J'),
    write("Sistema de Diagn�stico M�dico\n"),
    nl,
    write("--------------- Menu de Diagn�stico --------------- "),
    nl,
    write("1 - Come�ar diagn�stico\n"),
    write("2 - Menu Principal\n"),
    nl,
    write("Escolha uma das op��es dadas:"),
    read(Opcao),
    write('\33\[2J'),
    escolhaDiagnostico(Opcao).

escolhaDiagnostico(Opcao) :-
    Opcao = 1,
    diagnostico();
    Opcao = 2,
    start().
