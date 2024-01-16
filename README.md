# Backup Script

Este script executa três tipos de backups: incremental, completo e diferencial.

## Sobre os backups utilizados
- Backup Incremental: Este tipo de backup apenas armazena as alterações feitas desde o último backup, seja ele completo ou incremental. Portanto, ele captura a última modificação de um arquivo.

- Backup Completo: Este tipo de backup faz uma cópia de todos os arquivos, independentemente de terem sido modificados ou não. Portanto, se um arquivo foi modificado, a última modificação será capturada em um backup completo.

- Backup Diferencial: Este tipo de backup armazena todas as alterações feitas desde o último backup completo. Portanto, ele também captura a última modificação de um arquivo.

### Tecnologias Utilizadas

- **Bash**: Bash foi usado para escrever este script devido à sua simplicidade e eficácia para automação de tarefas no sistema operacional Unix/Linux. Bash é uma linguagem de script padrão em muitos sistemas Linux, o que torna uma escolha natural para tarefas de administração do sistema.

- **rsync**: rsync é uma ferramenta de cópia de arquivos extremamente poderosa e versátil. Ele é usado neste script para realizar os backups. A opção `-avh` garante que os arquivos sejam transferidos de forma eficiente (apenas as diferenças são transferidas) e preserva as permissões dos arquivos, tornando-o ideal para backups.

#### Uso

Você pode executar este script com as seguintes opções:

- `-h, --help`: Mostra a tela de ajuda e sai.
- `-v, --version`: Mostra a versão do programa e sai.
- `-i, --incremental`: Realiza um backup incremental.
- `-c, --complete`: Realiza um backup completo.
- `-d, --diferencial`: Realiza um backup diferencial.

## Informações Complementares
Essas sãos as variáveis que estava sendo em uso no scritp, $diretorio_backup, $incremental_backup, $complete_backup, $diferencial_backup. A explicação é feita a partir delas.

- Diretórios de Backup: Verifique se os diretórios de backup ($diretorio_backup, $incremental_backup, $complete_backup, $diferencial_backup) existem e têm as permissões corretas.
- Comandos Rsync: Os comandos rsync parecem estar corretos. Eles estão configurados para preservar as permissões dos arquivos (-a), dar saída em um formato mais legível (-h) e mostrar o progresso durante a transferência (--progress). No backup incremental, a opção --delete é usada para excluir arquivos no destino que não existem mais na origem, o que é típico de um backup incremental.
- Backup Diferencial: No backup diferencial, a opção --link-dest é usada para criar links para arquivos inalterados, economizando espaço. Certifique-se de que o diretório fornecido a --link-dest (neste caso, $diferencial_backup/ultimo) sempre aponte para o backup mais recente.

Antes de iniciar o backup, o script verifica se o diretório de destino existe. Se não existir, o backup será abortado.

## Versões

- Versão 0.01: Declarando variáveis a serem utilizadas.
- Versão 0.02: Adicionando suporte `-h --help`.
- Versão 0.03: Adicionando menu de suporte para usuário.
- Versão 0.04: Melhoria no código, deixando-o mais limpo.
- Versão 0.05: Criando funções para deixar o código mais legível.
