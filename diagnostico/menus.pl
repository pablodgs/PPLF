% Trabalho Prático 1: Prolog
% protótipo de um sistema de diagnóstico médico.

start :-
    write('\33\[2J'),
    write("Sistema de Diagnóstico Médico\n"),
    nl,
    write("--------------- Menu Principal --------------- "),
    nl,
    write("1 - Menu de Paciente\n"),
    write("2 - Menu de Diagnóstico\n"),
    write("3 - Sair\n"),
    nl,
    write("Escolha uma das opções dadas:"),
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
    write("Sistema de Diagnóstico Médico\n"),
    nl,
    write("--------------- Menu de Paciente --------------- "),
    nl,
    write("1 - Consulta\n"),
    write("2 - Inclusão\n"),
    write("3 - Alteração\n"),
    write("4 - Exclusão\n"),
    write("5 - Menu Principal\n"),
    nl,
    write("Escolha uma das opções dadas:"),
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
    write("Sistema de Diagnóstico Médico\n"),
    nl,
    write("--------------- Menu de Diagnóstico --------------- "),
    nl,
    write("1 - Começar diagnóstico\n"),
    write("2 - Menu Principal\n"),
    nl,
    write("Escolha uma das opções dadas:"),
    read(Opcao),
    write('\33\[2J'),
    escolhaDiagnostico(Opcao).

escolhaDiagnostico(Opcao) :-
    Opcao = 1,
    diagnostico();
    Opcao = 2,
    start().
