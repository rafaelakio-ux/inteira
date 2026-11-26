# Inteira Studio OS — V4

## Demonstracao
Abra index.html. Dados ficam no navegador e usam uma chave V4 independente; nao use dados reais. O prototipo V3 foi preservado e estendido. Funil, briefing, filas, aprovacoes, portal demonstrativo e exportacoes estao no frontend. PDF usa a impressao do navegador; PPTX e XLSX usam bibliotecas CDN fixadas e precisam de internet. O limite local de imagens nao e uma barreira de seguranca. Nenhuma IA, API ou Drive esta conectada. Nenhum pagamento e realizado.

## GitHub / Cloudflare
Use repositorio privado e coloque index.html na raiz. Em Cloudflare Pages selecione sem framework, sem build e diretorio de saida raiz. A URL de teste e publica por padrao; use somente dados ficticios ou restrinja acesso. Nao publique dados locais exportados. Nao configure DNS do site atual.

## Supabase (proxima etapa)
schema.sql e uma proposta inicial com RLS e acesso externo bloqueado por padrao. Nao foi executado ou homologado. A interface ainda usa localStorage, nao Supabase. Implementar autenticacao, cadastro de membros por backend, operacoes de escrita autorizadas, projecao de dados aprovados para o portal, armazenamento de arquivos e testes de isolamento. Usar somente chave publishable no frontend; chaves service-role e tokens OAuth ficam no Worker. A quota de 3 solicitacoes por dia deve ser atomica por cliente e fuso America/Sao_Paulo, verificada no servidor antes da geracao. Upgrade requer aprovacao e cobranca separada.

## Integracoes previstas
Worker autenticado com Drive API para recuperar somente documentos das pastas autorizadas institucional e do cliente. Indexar IDs, revisoes e fontes; bloquear se insuficientes. Nao habilitar pesquisa externa. Adaptadores OpenAI/Claude para texto, OpenAI para imagem; sem chamadas se nao houver fonte autorizada e orcamento. Meta, Google Ads/GA4 e CRM via APIs oficiais. Salvar artefatos aprovados no Drive via backend com autorizacao, idempotencia e auditoria. As solicitacoes locais sao apenas rascunhos e exigem resultado anexado manualmente. Exportacoes devem ser homologadas com documentos reais antes de producao.
