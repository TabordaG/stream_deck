# Remote Authetication Use Case

> ## Caso de sucesso (200)
1. ✅ Sistema valida os dados
2. ✅ Sistema faz uma requisição para a URL da API de login
3. ✅ Sistema valida os dados recebidos da API
4. ✅ Sistema entrega os dados da conta do usuário

> ## Exceção - URL inválida (404)
1. ✅ Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Dados inválidos (400)
1. ✅ Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Resposta inválida (200)
1. ✅ Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Falha no servidor (500)
1. ✅ Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Credenciais inválidas (401)
1. ✅ Sistema retorna uma mensagem de erro informando que as credenciais estão erradas