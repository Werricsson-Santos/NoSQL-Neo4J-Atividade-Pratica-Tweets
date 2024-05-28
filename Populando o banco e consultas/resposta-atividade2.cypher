// Buscando todos os tweets originais
MATCH (t:Tweet)
WITH t.tweet_id as id_original

// Buscando todos os retweets que referenciam esses tweets originais
MATCH (r:Retweet)
WHERE id_original in r.id_ref 

// Criando a relação RETWEET_OF entre os retweets e os tweets originais
MERGE (r)-[:RETWEET_OF]->(t);

/* Buscando e contando os retweets para cada tweet original, com ordenação 
   decrescente na contagem de retweets, limitando a 1 nodo 
   (para trazer o Tweet mais retweetado) */
MATCH (r:Retweet)-[:RETWEET_OF]->(t:Tweet)
WITH t, COUNT(r) AS retweet_count
ORDER BY retweet_count DESC
LIMIT 1
/* Retornando o Tweet mais retweetado e seus respectivos retweets, com ordenação 
   pela data de criação mais recente, limitando em 12 nodos. */
MATCH (r:Retweet)-[:RETWEET_OF]->(t)
Match (a:Aluno) -[:RU]-> (ru:numeroRU)
RETURN t, r, a, ru ORDER BY r.criado_em DESC LIMIT 12;