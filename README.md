# acronis-monitora-servicos

Scripts .bat para verificar os servicos do Acronis e inicia-los caso estejam parados, gravando o horario do start em `log_servicos.txt`.

## Arquivos

- `monitor_servicos_agendador.bat` - executa uma vez e encerra. Indicado para uso com o Agendador de Tarefas do Windows (ex.: repeticao a cada 2 horas).
- `monitor_servicos_loop.bat` - fica em loop e verifica a cada `INTERVALO` segundos (padrao: 7200 = 2 horas).

## Servicos monitorados

AcronisActiveProtectionService, aakore, emergency-updater-0.0.1.3369, MMS, AcrSch2Svc, AcronisSystemMonitorService

> O nome `emergency-updater-0.0.1.3369` contem a versao e pode mudar apos atualizacoes do Acronis.

## Uso

Execute como Administrador (ou com a conta SYSTEM no Agendador de Tarefas).
