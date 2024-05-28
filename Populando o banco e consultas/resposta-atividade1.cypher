/*Criando a base de dados a partir dos arquivos JSON 
  localizados na pasta import*/
CALL apoc.load.directory('*.json') YIELD value
WITH value AS arquivos
ORDER BY arquivos DESC
CALL apoc.load.json(arquivos) YIELD value
UNWIND value.data AS tweet
//Criando os nós de Tweet
MERGE (t:Tweet {tweet_id: tweet.id})
ON CREATE SET t += {
    texto: tweet.text,
    criado_em: 
        date(datetime(tweet.created_at).year + "-" +
             datetime(tweet.created_at).month + "-" +
             datetime(tweet.created_at).day),
    lingua: tweet.lang,
    curtidas: tweet.public_metrics.like_count,
    retweets: tweet.public_metrics.retweet_count,
    respostas: tweet.public_metrics.reply_count,
    citacoes: tweet.public_metrics.quote_count,
    autor: tweet.author_id,
    geolocalizacao: tweet.geo.place_id
}
//Criando os nós de Hashtags
FOREACH (hashtag IN tweet.entities.hashtags |
    MERGE (h:Hashtag {hashtag: apoc.text.replace(
        apoc.text.clean(hashtag.tag), '[^a-zA-Z0-9]', '')})
    MERGE (h)<-[:POSSUI]-(t)
)
/*Identificando o tipo de Tweet, removendo dos nós de Tweet e
  recriando o nó com a etiqueta correta conforme o tipo */
FOREACH (ref_tweet IN tweet.referenced_tweets |
    SET t.tipo_ref = coalesce(t.tipo_ref, []) + [ref_tweet.type],
        t.id_ref = coalesce(t.id_ref, []) + [ref_tweet.id]
);
MATCH (t) WHERE "retweeted" in t.tipo_ref
REMOVE t:Tweet
SET t:Retweet;
MATCH (t) WHERE "replied_to" in t.tipo_ref
REMOVE t:Tweet
SET t:Replied_to;
MATCH (t) WHERE "quoted" in t.tipo_ref
REMOVE t:Tweet
SET t:Quot;

/*Criando o nós Aluno e numeroRU com o relacionamento RU
  (para melhor apresentação da identificação na imagem de grafos) */
CREATE (a:Aluno {nome: "Werricsson Santos"}) -[:RU]-> (r:numeroRU {RU: 4231021});

/*Identificando a hashtag principal e fazendo a consulta para criar a 
  imagem de grafos conforme os requisitos da atividade*/
MATCH (h:Hashtag) <-[:POSSUI]- (t:Tweet)
WITH h.hashtag as tag, COUNT(t) AS Frequencia
ORDER BY Frequencia DESC LIMIT 1
Match (t:Tweet) -[:POSSUI]-> (h:Hashtag)
Match (a:Aluno) -[:RU]-> (r:numeroRU)
WHERE tag in h.hashtag AND date(t.criado_em) = date("2020-03-05")
RETURN t, h, a, r