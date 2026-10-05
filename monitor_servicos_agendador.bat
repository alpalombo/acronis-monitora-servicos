@echo off
setlocal EnableDelayedExpansion

REM ============================================================
REM  Verifica os servicos e inicia os que estiverem parados.
REM  Executa UMA vez e encerra (agende no Agendador de Tarefas).
REM  Execute como ADMINISTRADOR (ou conta SYSTEM no Agendador).
REM ============================================================

REM --- Nomes dos servicos (nome do servico, nao o nome de exibicao) ---
set SERVICOS="AcronisActiveProtectionService" "aakore" "emergency-updater-0.0.1.3369" "MMS" "AcrSch2Svc" "AcronisSystemMonitorService"

REM --- Arquivo de log ---
set LOG=%~dp0log_servicos.txt

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

endlocal
exit /b 0
