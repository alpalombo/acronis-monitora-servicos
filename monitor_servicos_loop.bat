@echo off
setlocal EnableDelayedExpansion

REM ============================================================
REM  Monitor de servicos - inicia automaticamente se estiver parado
REM  Versao com LOOP: fica rodando e verifica a cada INTERVALO segundos.
REM  Execute como ADMINISTRADOR.
REM ============================================================

REM --- Nomes dos servicos (nome do servico, nao o nome de exibicao) ---
set SERVICOS="AcronisActiveProtectionService" "aakore" "emergency-updater-0.0.1.3369" "MMS" "AcrSch2Svc" "AcronisSystemMonitorService"

REM --- Arquivo de log ---
set LOG=%~dp0log_servicos.txt

REM --- Intervalo entre verificacoes, em segundos (7200 = 2 horas) ---
set INTERVALO=7200

:LOOP
for %%S in (%SERVICOS%) do (
    sc query "%%~S" | find "RUNNING" >nul
    if errorlevel 1 (
        REM Verifica se o servico existe
        sc query "%%~S" >nul 2>&1
        if errorlevel 1 (
            echo [!date! !time!] ERRO: servico "%%~S" nao encontrado >> "%LOG%"
        ) else (
            net start "%%~S" >nul 2>&1
            if errorlevel 1 (
                echo [!date! !time!] FALHA ao iniciar o servico "%%~S" >> "%LOG%"
            ) else (
                echo [!date! !time!] Servico "%%~S" estava parado e foi INICIADO >> "%LOG%"
            )
        )
    )
)

REM ping funciona como pausa mesmo em segundo plano (timeout falha sem console)
ping -n %INTERVALO% 127.0.0.1 >nul
goto LOOP
